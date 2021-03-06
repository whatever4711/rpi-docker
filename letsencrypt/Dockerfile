# https://github.com/letsencrypt/letsencrypt/pull/431#issuecomment-103659297
# it is more likely developers will already have ubuntu:trusty rather
# than e.g. debian:jessie and image size differences are negligible
FROM resin/rpi-raspbian 
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

# Note: this only exposes the port to other docker containers. You
# still have to bind to 443@host at runtime, as per the ACME spec.
EXPOSE 443 80

# TODO: make sure --config-dir and --work-dir cannot be changed
# through the CLI (letsencrypt-docker wrapper that uses standalone
# authenticator and text mode only?)
VOLUME /etc/letsencrypt 
WORKDIR /opt
RUN apt-get update && \
    apt-get -y install --no-install-recommends git
RUN git config --global http.sslVerify false
RUN git clone https://github.com/letsencrypt/letsencrypt.git
WORKDIR /opt/letsencrypt

# no need to mkdir anything:
# https://docs.docker.com/reference/builder/#copy
# If <dest> doesn't exist, it is created along with all missing
# directories in its path.


#COPY bootstrap/ubuntu.sh /opt/letsencrypt/src/ubuntu.sh
RUN /opt/letsencrypt/bootstrap/_deb_common.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

# the above is not likely to change, so by putting it further up the
# Dockerfile we make sure we cache as much as possible


#COPY setup.py README.rst CHANGES.rst MANIFEST.in /opt/letsencrypt/src/

# all above files are necessary for setup.py, however, package source
# code directory has to be copied separately to a subdirectory...
# https://docs.docker.com/reference/builder/#copy: "If <src> is a
# directory, the entire contents of the directory are copied,
# including filesystem metadata. Note: The directory itself is not
# copied, just its contents." Order again matters, three files are far
# more likely to be cached than the whole project directory

#COPY letsencrypt /opt/letsencrypt/src/letsencrypt/
#COPY acme /opt/letsencrypt/src/acme/
#COPY letsencrypt-apache /opt/letsencrypt/src/letsencrypt-apache/
#COPY letsencrypt-nginx /opt/letsencrypt/src/letsencrypt-nginx/


# py26reqs.txt not installed!
RUN virtualenv --no-site-packages -p python2 /opt/letsencrypt/venv
RUN /opt/letsencrypt/venv/bin/pip --default-timeout=60 install -e /opt/letsencrypt/acme
RUN /opt/letsencrypt/venv/bin/pip --default-timeout=60 install -e /opt/letsencrypt
RUN /opt/letsencrypt/venv/bin/pip --default-timeout=60 install -e /opt/letsencrypt/letsencrypt-apache
RUN /opt/letsencrypt/venv/bin/pip --default-timeout=60 install -e /opt/letsencrypt/letsencrypt-nginx

# install in editable mode (-e) to save space: it's not possible to
# "rm -rf /opt/letsencrypt/src" (it's stays in the underlaying image);
# this might also help in debugging: you can "docker run --entrypoint
# bash" and investigate, apply patches, etc.

ENV PATH /opt/letsencrypt/venv/bin:$PATH
ENV DNS_MAIL abc@letsencrypt.de
ENV DNS_ENTRY abc.com,www.abc.com
ENV DNS_CERT /etc/letsencrypt

COPY ./docker-entrypoint.sh /opt/letsencrypt/
ENTRYPOINT [ "./docker-entrypoint.sh" ] 

