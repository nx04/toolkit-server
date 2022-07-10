FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/soft/
RUN mkdir -p /data/www/

# 执行 shell 安装脚本
COPY install.sh /data/soft/
RUN chmod +x /data/soft/install.sh
RUN /data/soft/install.sh
WORKDIR /data/www/

# /usr/local/php80-release/lib/php.ini # php配置文件所在位置 # 
# /data/www/ # http服务部署位置 #
# php # php cli #
# composer # composer cli #


