FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/soft
WORKDIR /data/soft
# 执行 shell 安装脚本
COPY install.sh ./
COPY docker-entrypoint.sh ./
RUN chmod +x *
RUN ls -l
RUN ./install.sh
EXPOSE 80 443
# /etc/httpd/conf/httpd.conf # apache 配置文件
# /var/www/html #http服务部署位置
# /etc/httpd/logs #日志文件位置
# /usr/local/php-release/lib/php.ini # php配置文件所在位置
ENTRYPOINT ["docker-entrypoint.sh"]