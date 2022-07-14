#!/bin/bash
# author: xiaonian #
# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_swoole_tcp/www
docker rm -f demo_server_php_swoole_tcp
docker run -d -p 59502:9502 --name demo_server_php_swoole_tcp -v /data/demo_server_php_swoole_tcp/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "php server_tcp.php"

