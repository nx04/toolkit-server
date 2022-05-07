FROM centos:centos7.9.2009

USER root
RUN mkdir -p /data/soft/redis
RUN mkdir -p /data/server/redis

# 执行 shell 安装脚本
COPY install.sh /data/soft/redis/install.sh
RUN sh /data/soft/redis/install.sh

# 项目目录
WORKDIR /data/server/redis
