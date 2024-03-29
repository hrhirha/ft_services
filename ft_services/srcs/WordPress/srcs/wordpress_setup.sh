#!/bin/sh

echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk -U upgrade
apk add nginx openssl openrc telegraf
adduser -D -g 'www' www
mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/wordpress.key -out /etc/ssl/certs/wordpress.crt -subj "/C=/ST=/L=/O=/OU=/CN="

mkdir /run/nginx
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.origin
rm /etc/nginx/conf.d/default.conf

apk add php7-fpm php7-session php7-mbstring php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype

openrc; touch /run/openrc/softlevel

wget http://wordpress.org/latest.tar.gz
tar zxvf latest.tar.gz
mv wordpress/* /www/
chown -R www:www /www/

rm -rf wordpress/ latest.tar.gz
