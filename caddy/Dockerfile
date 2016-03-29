FROM hypriot/rpi-alpine-scratch:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apk add --update openssh-client git tar php-fpm

RUN mkdir /caddysrc && \
    curl -sL -o /caddysrc/caddy_linux_arm.tar.gz "https://caddyserver.com/download/build?os=linux&arch=arm&features=ipfilter%2Crealip" && \
    tar -xf /caddysrc/caddy_linux_arm.tar.gz -C /caddysrc && \
    mv /caddysrc/caddy /usr/bin/caddy && \
    chmod 755 /usr/bin/caddy && \
    rm -rf /caddysrc && \
    printf "0.0.0.0\nfastcgi / 127.0.0.1:9000 php" > /etc/Caddyfile

RUN mkdir /srv && \
    printf "<?php phpinfo(); ?>" > /srv/index.php

EXPOSE 2015
EXPOSE 443
EXPOSE 80

WORKDIR /srv

CMD /usr/bin/php-fpm; /usr/bin/caddy --conf /etc/Caddyfile

