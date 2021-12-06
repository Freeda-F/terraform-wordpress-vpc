#!/bin/bash
sudo -i
yum install httpd git -y
systemctl restart httpd
systemctl enable httpd
amazon-linux-extras install php7.4 -y
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
cp -pr wordpress/* /var/www/html
chown -R apache. /var/www/html
systemctl restart httpd