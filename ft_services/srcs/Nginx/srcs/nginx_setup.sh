#!/bin/sh

echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
apk -U upgrade
apk add nginx openssl openssh openrc telegraf

openrc; touch /run/openrc/softlevel

mkdir /run/nginx/
adduser -D -g 'www' www
mkdir /www && chown -R www:www /var/lib/nginx && chown -R www:www /www
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=/ST=/L=/O=/OU=/CN="
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
rm -rf /etc/nginx/conf.d/default.conf

mkdir .ssh
chown -R www:www /etc/ssh; chown -R www:www .ssh
apk add sudo
addgroup sudo
echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers
adduser -D admin -G sudo
echo "admin:admin" | chpasswd
