FROM resin/rpi-raspbian
MAINTAINER Marcel Grossmann

RUN apt-get update && apt-get install -y --no-install-recommends ampache mysql-client

ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD run.sh /run.sh
ADD config/ampache.cfg.php /etc/ampache/ampache.cfg.php
RUN chmod 755 /*.sh

# setup apache with default ampache vhost
ADD 001-ampache.conf /etc/apache2/sites-available/
RUN rm -rf /etc/apache2/sites-enabled/*
RUN ln -s /etc/apache2/sites-available/001-ampache.conf /etc/apache2/sites-enabled/
RUN a2enmod rewrite

RUN chown -R www-data:www-data /usr/share/ampache/www

# Add job to cron to clean the library every night
RUN echo '30 7    * * *   www-data php /var/www/bin/catalog_update.inc' >> /etc/crontab

VOLUME ["/media"]
VOLUME ["/var/www/config"]
VOLUME ["/var/www/themes"]
EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#CMD ["/run.sh"]
