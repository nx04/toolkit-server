FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/server/php

# 执行 shell 安装脚本
COPY install.sh /data/server/php/install.sh
RUN sh /data/server/php/install.sh

# app 项目目录
WORKDIR /data