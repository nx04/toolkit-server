FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/soft/php
WORKDIR /data/soft/php
# 执行 shell 安装脚本
COPY install.sh ./
COPY docker-entrypoint.sh ./
COPY www.conf ./
RUN sh ./install.sh
RUN cp -rf ./www.conf /usr/local/php-release/etc/php-fpm.d
EXPOSE 9000
ENTRYPOINT ["./docker-entrypoint.sh"]