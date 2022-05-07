FROM centos:centos7.9.2009

USER root

# 执行 shell 安装脚本
COPY install.sh /home/install.sh
RUN sh /home/install.sh

# app 项目目录
WORKDIR /home
