FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

ENV ORACLE_JAVA=jdk1.8.0_91
ENV ORACLE=http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-arm32-vfp-hflt.tar.gz

RUN apt-get -qq update && apt-get -y install wget screen iptables
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -O java.tar.gz $ORACLE && \
    tar xvzf java.tar.gz  -C /opt && \
    update-alternatives --install /usr/bin/javac javac /opt/$ORACLE_JAVA/bin/javac 1 && \
    update-alternatives --install /usr/bin/java java /opt/$ORACLE_JAVA/bin/java 1 

RUN wget -q http://wiki.picapport.de/download/attachments/819204/picapport_6.0.1.deb?api=v2 -O picapport.deb
#RUN adduser --disabled-password --gecos '' picapport
RUN dpkg -i picapport.deb
RUN apt-get install -yqqf

#USER picapport
#WORKDIR /home/picapport

EXPOSE 8080

#ENTRYPOINT ["/opt/picapport/StartPicApport.sh"]
