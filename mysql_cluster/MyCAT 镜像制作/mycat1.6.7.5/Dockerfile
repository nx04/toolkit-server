FROM java:8-jre

ENV MYCAT_HOME=/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin

USER root

RUN wget http://dl.mycat.org.cn/1.6.7.5/2020-4-10/Mycat-server-1.6.7.5-release-20200410174409-linux.tar.gz -O mycat.tar.gz \
	&& mkdir -p mycat \
	&& tar -xf mycat.tar.gz -C mycat --strip-components=1 \
	&& rm mycat.tar.gz

WORKDIR $MYCAT_HOME/bin
RUN chmod u+x ./mycat
EXPOSE 8066 9066
CMD ["./mycat","console"]