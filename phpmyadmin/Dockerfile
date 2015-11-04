FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

ENV REQUIRED_PACKAGES phpmyadmin

# apache2 php-apache2 php-mysqli php-zip php-zlib php-bz2 php-ctype php-gd php-mcrypt php-json php-openssl

RUN apt-get update

RUN  apt-get -yqq install $REQUIRED_PACKAGES

#RUN \
#  apt-get install -yqq wget && \
#  cd /tmp && \
#  wget -q --no-check-certificate $PHPMYADMIN_DOWNLOAD && \
#  tar xzf $PHPMYADNIN_PACKAGE.tar.gz && \
#  mkdir -p /usr/share/webapps && \
#  mv $PHPMYADNIN_PACKAGE $PHPMYADMIN_DIR && \
#  rm -fr $PHPMYADMIN_DIR/config.sample.inc.php && \
#  rm -fr $PHPMYADMIN_DIR/setup && \
#  chown -R apache:apache $PHPMYADMIN_DIR
#
#ADD config.inc.php $PHPMYADMIN_DIR
#ADD phpmyadmin.conf /etc/apache2/conf.d/
#
#WORKDIR $PHPMYADMIN_DIR

EXPOSE 80

ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
