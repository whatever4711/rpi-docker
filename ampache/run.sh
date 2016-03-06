#!/bin/bash

# Start apache in the background
#service apache2 start

# Start cron in the background
#cron

# Start a process to watch for changes in the library with inotify
#(
#while true; do
#    inotifywatch /media
#    php /var/www/bin/catalog_update.inc -a
#    sleep 30
#done
#) &

# run this in the foreground so Docker won't exit
#exec mysqld_safe

mysql -uroot -p$MYSQL_ENV_MYSQL_ROOT_PASSWORD -h$MYSQL_PORT_3306_TCP_ADDR -P$MYSQL_PORT_3306_TCP_PORT -e "CREATE DATABASE IF NOT EXISTS ampache; CREATE USER IF NOT EXISTS 'ampache'@'%' IDENTIFIED BY '1234567890'; GRANT ALL PRIVILEGES ON ampache.* TO 'ampache'@'%';"

mysql -Dampache -uampache -p1234567890 -h$MYSQL_PORT_3306_TCP_ADDR -P$MYSQL_POYSQL_PORT_3306_TCP_PORT < /usr/share/ampache/www/sql/ampache.sql
