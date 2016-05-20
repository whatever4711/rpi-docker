FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apt-get update && apt-get -y install wget screen iptables
RUN wget -q http://wiki.picapport.de/download/attachments/819204/picapport_6.0.1.deb?api=v2 -O picapport.deb
RUN dpkg -i picapport.deb
RUN apt-get install -yqqf

