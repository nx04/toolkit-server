FROM centos:centos7.9.2009

USER root
RUN mkdir -p /data/soft/mysql
RUN mkdir -p /data/server/mysql

# 执行 shell 安装脚本
COPY install.sh /data/soft/mysql/install.sh
RUN sh /data/soft/mysql/install.sh

# 项目目录
WORKDIR /data/server/mysql
