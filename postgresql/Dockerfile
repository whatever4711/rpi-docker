FROM hypriot/rpi-alpine-scratch
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

# much taken from
# https://github.com/docker-library/postgres/blob/master/9.4/Dockerfile

#RUN addgroup -S postgres && adduser -S -g postgres postgres

#ENV PG_MAJOR 9.4
#ENV PG_VERSION 9.4.4
ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data

RUN apk --update add \
    postgresql \
    curl \
    && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-armhf" \
    && chmod +x /usr/local/bin/gosu \
    && apk del curl \
    && rm -rf /var/cache/apk/*

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
VOLUME /var/lib/postgresql/data

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 5432
CMD [ "postgres" ]

LABEL \
    version=9.4.6 \
    os="linux" \
    arch="armhf"
