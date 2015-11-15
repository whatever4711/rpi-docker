PHPMyAdmin
==========

Add at the end of /etc/phpmyadmin/config.inc.php

```php
$i++;
$cfg['Servers'][$i]['verbose'] = 'Database Server 2';
$cfg['Servers'][$i]['host'] = '192.168.1.102';
$cfg['Servers'][$i]['port'] = '';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['AllowNoPassword'] = false;
```

TODO: generate PMA Database

MariaDB
=======

Build Dockerfile from:

Basic Installation


```bash
docker run -it resin/rpi-raspbian /bin/bash
```
Inside the container run:
```bash
apt-get update
# a mounted file system to make MySQL happy
cat /proc/mounts > /etc/mtab
apt-get install mariadb-server
exit
```
Commit the basic install
```bash
docker commit <container_id> <YOU>/mariadb100
```
First Run

```bash
docker run -v="$HOME/mysqldata":"/data" -it -p 3306 <YOU>/mariadb100 /bin/bash
```

```bash
cp /etc/mysql/my.cnf /etc/mysql/my.cnf.orig
# Allow access from any ip address
sed -i '/^bind-address*/ s/^/#/' /etc/mysql/my.cnf
# Change the data dir
sed -i '/^datadir*/ s|/var/lib/mysql|/data/mysql|' /etc/mysql/my.cnf
rm -Rf /var/lib/mysql
# Setup new data tables
mysql_install_db
# Startup
/usr/bin/mysqld_safe &
# First setup
mysql_secure_installation
# Create user admin to login from everywhere
mysql -p --execute="CREATE USER 'admin'@'%' IDENTIFIED BY '1234';"
mysql -p --execute="GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;"
mysqladmin -p shutdown
exit
```
Commit and tag
```bash
docker commit -m "mariadb100 image w/ external data" -author"<YOU>" <CONTAINER_ID> <YOU>/mariadb100 <SOME_TAG>
```

Runnning
```bash
docker run -v="$HOME/mysqldata":"/data" -d -p 3306 <YOU>/mariadb100:<SOME_TAG> /usr/bin/mysqld_safe
```



