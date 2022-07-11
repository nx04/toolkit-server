#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_apache_5600/apache-config
mkdir -p /data/demo_server_php_apache_5600/apache-logs
mkdir -p /data/demo_server_php_apache_5600/php-config
mkdir -p /data/demo_server_php_apache_5600/www
cp -rf httpd.conf /data/demo_server_php_apache_5600/apache-config
docker rm -f demo_server_php_apache_5600
docker run -d -p 58800:80 --name demo_server_php_apache_5600 -v /data/demo_server_php_apache_5600/apache-config/httpd.conf:/etc/httpd/conf/httpd.conf -v /data/demo_server_php_apache_5600/apache-logs:/etc/httpd/logs -v /data/demo_server_php_apache_5600/www:/var/www/html php-apache-5600:2.0.0

