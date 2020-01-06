FROM java:8-jre
MAINTAINER <xiaonian xiaonian0430@163.com>
LABEL Description="使用 mycat 做 mysql 数据库的读写分离"
ENV MYCAT_VERSION 1.6.7.4
ENV MYCAT_PROJECT_NAME Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz
ENV MYCAT_HOME=/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin
USER root
RUN wget -P / http://dl.mycat.io/1.6.7.4/Mycat-server-1.6.7.4-release/Mycat-server-1.6.7.4-release-20200105164103-linux.tar.gz
RUN tar -zxf /${MYCAT_PROJECT_NAME}
RUN rm /${MYCAT_PROJECT_NAME}
WORKDIR $MYCAT_HOME/bin
RUN chmod u+x ./mycat
EXPOSE 8066 9066
CMD ["./mycat","console"]