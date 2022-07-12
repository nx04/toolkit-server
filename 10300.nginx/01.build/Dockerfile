FROM centos:centos7.9.2009

USER root

RUN mkdir -p /data/soft
# 执行 shell 安装脚本
COPY install.sh /data/soft/
COPY docker-entrypoint.sh /data/soft/
RUN chmod +x /data/soft/*
RUN /data/soft/install.sh
EXPOSE 80 443
WORKDIR /data/soft
ENTRYPOINT ["./docker-entrypoint.sh"]