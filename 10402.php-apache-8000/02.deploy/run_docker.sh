#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
# /etc/httpd/conf/httpd.conf # apache 配置文件
# /var/www/html #http服务部署位置
# /etc/httpd/logs #日志文件位置
# /usr/local/php80-release/lib/php.ini # php配置文件所在位置
mkdir -p /data/demo_server_php_apache_8000/apache-config
mkdir -p /data/demo_server_php_apache_8000/apache-logs
mkdir -p /data/demo_server_php_apache_8000/php-config
mkdir -p /data/demo_server_php_apache_8000/www
cp -rf httpd.conf /data/demo_server_php_apache_8000/apache-config
docker rm -f demo_server_php_apache_8000
docker run -d -p 8881:80 --name demo_server_php_apache_8000 -v /data/demo_server_php_apache_8000/apache-config/httpd.conf:/etc/httpd/conf/httpd.conf -v /data/demo_server_php_apache_8000/apache-logs:/etc/httpd/logs -v /data/demo_server_php_apache_8000/www:/var/www/html php-apache-8000:2.0.0

