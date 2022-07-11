#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone


mkdir -p /data/demo_server_redis_702/config
mkdir -p /data/demo_server_redis_702/logs
mkdir -p /data/demo_server_redis_702/www
cp -rf redis.conf /data/demo_server_redis_702/config
docker rm -f demo_server_redis_702
docker run -d -p 56379:6379 --name demo_server_redis_702 -v /data/demo_server_redis_702/config/redis.conf:/data/server/config/redis.conf redis:7.0.2

