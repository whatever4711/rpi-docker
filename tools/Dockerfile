FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apt-get update && \
        apt-get -y install iproute2 net-tools iputils-arping iputils-ping && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/*

