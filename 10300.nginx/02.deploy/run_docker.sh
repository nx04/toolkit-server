#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
mkdir -p /data/demo_server_nginx/www
mkdir -p /data/demo_server_nginx/config
cp -rf nginx.conf /data/demo_server_nginx/config
cp -rf demo.com.conf /data/demo_server_nginx/config
docker rm -f demo_server_nginx
docker run -d -p 58800:80 --name demo_server_nginx -v /data/demo_server_nginx/config/nginx.conf:/usr/local/nginx-release/conf/nginx.conf -v /data/demo_server_nginx/www:/data/server/www -v /data/demo_server_nginx/config/demo.com.conf:/usr/local/nginx-release/conf.d/demo.com.conf nginx:1.22.0

