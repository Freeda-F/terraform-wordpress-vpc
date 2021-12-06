#!/bin/bash
sudo -i
sudo yum install mariadb-server -y
sudo /sbin/chkconfig mariadb on
sudo /sbin/service mariadb start
sudo mysqladmin -u root password '123a'
sudo mysql -u root -p123a
sudo mysql -u root -p123a -e  "CREATE DATABASE db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
use db;
create user 'dbuser'@'%' identified by '123a';
GRANT ALL ON db.* TO 'dbuser'@'%';
FLUSH PRIVILEGES;"
sudo /sbin/service mariadb restart