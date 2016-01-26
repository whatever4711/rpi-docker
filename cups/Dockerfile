FROM hypriot/rpi-alpine-scratch
MAINTAINER Marcel Grossmann <whatever4711@gmail.com> 

RUN apk update && \
apk upgrade && \
apk add bash && \
apk add cups

RUN echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories 

RUN apk update && \
apk add gutenprint && \
apk add gutenprint-cups && \
apk add hplip && \
rm -rf /var/cache/apk/*

COPY ./cupsd.conf /etc/cups/
COPY ./run.sh .

ENTRYPOINT ["bash", "run.sh"]
