FROM java:8-jre

MAINTAINER <xiaonian xiaonian0430@163.com>
LABEL Description="使用 mycat 做 mysql 数据库的读写分离"

ENV MYCAT_HOME=/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin

USER root

RUN wget http://dl.mycat.io/1.6.7.4/Mycat-server-1.6.7.4-release/Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz -O mycat.tar.gz \
	&& mkdir -p mycat \
	&& tar -xf mycat.tar.gz -C mycat --strip-components=1 \
	&& rm mycat.tar.gz

WORKDIR $MYCAT_HOME/bin
RUN chmod u+x ./mycat
EXPOSE 8066 9066
CMD ["./mycat","console"]