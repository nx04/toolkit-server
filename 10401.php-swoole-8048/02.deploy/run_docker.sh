#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_swoole_8048/www
docker rm -f demo_server_php_swoole_8048
docker run -d -p 59501:9501 --name demo_server_php_swoole_8048 -v /data/demo_server_php_swoole_8048/www:/data/www php-swoole-8048:2.0.0 "php http_server.php"

