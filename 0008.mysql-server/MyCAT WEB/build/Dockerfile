FROM java:8-jre

USER root

RUN wget http://dl.mycat.io/mycat-web-1.0/Mycat-web-1.0-SNAPSHOT-20170102153329-linux.tar.gz -O mycat-web.tar.gz \
	&& mkdir -p mycat-web \
	&& tar -xf mycat-web.tar.gz -C mycat-web --strip-components=1 \
	&& rm mycat-web.tar.gz
	
WORKDIR /mycat-web
EXPOSE 8082
CMD ["./start.sh"]