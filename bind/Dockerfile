FROM hypriot/rpi-alpine-scratch:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apk add -U bind drill \
&& touch /etc/bind/named.conf

VOLUME ["/etc/bind/"]
EXPOSE 53 53/UDP
ENTRYPOINT ["named", "-g"]

