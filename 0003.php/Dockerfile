FROM centos:centos7.8.2003

USER root

# 执行 shell 安装脚本
COPY install.sh /home/install.sh
RUN sh /home/install.sh

# app 项目目录
WORKDIR /home

CMD [ "php", "-m" ]