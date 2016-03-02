FROM hypriot/rpi-alpine-scratch
MAINTAINER Marcel Grossmann <whatever4711@gmail.com> 

ENV CONF_DIR /conf
ENV CONF dnsmasq.conf
RUN mkdir $CONF_DIR
VOLUME ["$CONF_DIR"]

RUN apk update && \
apk upgrade && \
apk add dnsmasq && \
apk add bash

COPY .$CONF_DIR/$CONF $CONF_DIR/$CONF
EXPOSE 53 53/udp 67 67/udp
ENTRYPOINT ["dnsmasq", "-k", "--log-facility=-", "-C", "/conf/dnsmasq.conf"]
