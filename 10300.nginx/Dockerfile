FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/soft/nginx
RUN mkdir -p /data/server/nginx

# 执行 shell 安装脚本
COPY install.sh /data/soft/nginx/install.sh
RUN sh /data/soft/nginx/install.sh

# app 项目目录
WORKDIR /data/server/nginx