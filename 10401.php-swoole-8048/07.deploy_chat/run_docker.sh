#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_php_swoole_chat/www
docker rm -f demo_server_php_swoole_chat_gateway
docker rm -f demo_server_php_swoole_chat_worker
docker rm -f demo_server_php_swoole_chat_register
docker run -d -p 50100:1236 --name demo_server_php_swoole_chat_register -v /data/demo_server_php_swoole_chat/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_register.sh"
docker run -d --name demo_server_php_swoole_chat_worker -v /data/demo_server_php_swoole_chat/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_worker.sh"
docker run -d -p 50101:7272 --name demo_server_php_swoole_chat_gateway -v /data/demo_server_php_swoole_chat/www:/data/www php-swoole-8048:2.0.0 /bin/bash -c "sh run_gateway.sh"

