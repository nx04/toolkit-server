FROM java:8-jre

MAINTAINER <xiaonian xiaonian0430@163.com>
LABEL Description="使用 mycat 做 mysql 数据库的读写分离"

USER root

RUN wget http://dl.mycat.io/mycat-web-1.0/Mycat-web-1.0-SNAPSHOT-20170102153329-linux.tar.gz -O mycat_web.tar.gz \
	&& mkdir -p mycat_web \
	&& tar -xf mycat_web.tar.gz -C mycat_web --strip-components=1 \
	&& rm mycat_web.tar.gz

RUN wget https://www-eu.apache.org/dist/zookeeper/zookeeper-3.5.6/apache-zookeeper-3.5.6.tar.gz -O zookeeper.tar.gz \
	&& mkdir -p zookeeper \
	&& tar -xf zookeeper.tar.gz -C zookeeper --strip-components=1 \
	&& rm zookeeper.tar.gz
	
WORKDIR /zookeeper/bin
EXPOSE 2181
CMD ["./zkServer.sh", "start"]