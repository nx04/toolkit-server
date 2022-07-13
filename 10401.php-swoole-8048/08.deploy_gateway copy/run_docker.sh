#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_swoole_gateway/www
docker rm -f demo_server_php_swoole_gateway
docker rm -f demo_server_php_swoole_worker
docker rm -f demo_server_php_swoole_register
docker run -d -p 59327:9327 --name demo_server_php_swoole_register -v /data/demo_server_php_swoole_gateway/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_register.sh"
docker run -d -p 59327:9327 --name demo_server_php_swoole_worker -v /data/demo_server_php_swoole_gateway/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_worker.sh"
docker run -d -p 58000:8000 --name demo_server_php_swoole_gateway -v /data/demo_server_php_swoole_gateway/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_gateway.sh"

