# vim:set ft=dockerfile:
FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3 python3-pip
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN ln -s /usr/bin/pip3 /usr/bin/pip

# Clean Up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
