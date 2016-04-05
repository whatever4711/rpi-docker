FROM hypriot/rpi-alpine-scratch:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apk add --update openssh-client git tar

RUN mkdir /caddysrc && \
    curl -sL -o /caddysrc/caddy_linux_arm.tar.gz "https://caddyserver.com/download/build?os=linux&arch=arm&features=git%2Chugo%2Cipfilter%2Cmailout%2Cprometheus%2Crealip%2Csearch" && \
    tar -xf /caddysrc/caddy_linux_arm.tar.gz -C /caddysrc && \
    mv /caddysrc/caddy /usr/bin/caddy && \
    chmod 755 /usr/bin/caddy && \
    rm -rf /caddysrc && \
    printf "localhost:80" > /etc/Caddyfile

RUN mkdir /srv 
RUN mkdir -p /root/.caddy/letsencrypt
EXPOSE 80 443 2015

WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--agree", "--conf", "/etc/Caddyfile"]

