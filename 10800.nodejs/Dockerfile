FROM centos:centos7.9.2009

USER root
RUN mkdir -p /data/soft/nodejs
RUN mkdir -p /data/server/nodejs
# 执行 shell 安装脚本
COPY install.sh /data/soft/nodejs/install.sh
RUN sh /data/soft/nodejs/install.sh

# app 项目目录
WORKDIR /data/server/nodejs
