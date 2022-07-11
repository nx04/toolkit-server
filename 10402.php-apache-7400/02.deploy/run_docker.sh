#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
# /etc/httpd/conf/httpd.conf # apache 配置文件
# /var/www/html #http服务部署位置
# /etc/httpd/logs #日志文件位置
# /usr/local/php74-release/lib/php.ini # php配置文件所在位置
mkdir -p /data/demo_server_apache_php_7400/apache-config
mkdir -p /data/demo_server_apache_php_7400/apache-logs
mkdir -p /data/demo_server_apache_php_7400/php-config
mkdir -p /data/demo_server_apache_php_7400/www
cp -rf httpd.conf /data/demo_server_apache_php_7400/apache-config
docker rm -f demo_server_apache_php_7400
docker run -d -p 58801:80 --name demo_server_apache_php_7400 -v /data/demo_server_apache_php_7400/apache-config/httpd.conf:/etc/httpd/conf/httpd.conf -v /data/demo_server_apache_php_7400/apache-logs:/etc/httpd/logs -v /data/demo_server_apache_php_7400/www:/var/www/html php-apache-7400:2.0.0

