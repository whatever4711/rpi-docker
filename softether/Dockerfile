FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

ENV VERSION v4.19-9599-beta-2015.10.19
WORKDIR /usr/local/vpnserver

RUN apt-get update &&\
        apt-get -y -q install gcc make wget build-essential && \
        wget http://www.softether-download.com/files/softether/${VERSION}-tree/Linux/SoftEther_VPN_Server/32bit_-_ARM_EABI/softether-vpnserver-${VERSION}-linux-arm_eabi-32bit.tar.gz -O /tmp/softether-vpnserver.tar.gz &&\
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ 

RUN make i_read_and_agree_the_license_agreement

RUN apt-get purge -y -q --auto-remove gcc make wget build-essential && \
        apt-get clean && \
        rm /tmp/softether-vpnserver.tar.gz && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/*

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

ENTRYPOINT ["/usr/local/vpnserver/runner.sh"]

