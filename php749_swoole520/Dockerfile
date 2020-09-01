FROM centos:centos7.6.1810

USER root

ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

RUN wget https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.gz \
    && tar zxvf nghttp2-1.41.0.tar.gz \
    && cd nghttp2-1.41.0 \
    && ./configure \
    && make && make install

RUN wget https://github.com/kkos/oniguruma/releases/download/v6.9.5/onig-6.9.5.tar.gz \
    && tar zxvf onig-6.9.5.tar.gz \
    && cd onig-6.9.5 \
    && ./configure --libdir=/lib64 \
    && make && make install

RUN wget https://www.php.net/distributions/php-7.4.9.tar.gz \
    && tar zxvf php-7.4.9.tar.gz \
    && cd php-7.4.9 \
    && ./configure --prefix /usr/local/php749 --with-openssl --with-openssl-dir --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl \
    && make && make install \
    && ln -s /usr/local/php749/bin/php /bin/php \
    && ln -s /usr/local/php749/bin/phpize /bin/phpize

RUN wget https://github.com/swoole/swoole-src/archive/v4.5.2.tar.gz \
    && tar zxvf v4.5.2.tar.gz \
    && cd v4.5.2 \
    && phpize \
    && ./configure --enable-openssl --enable-sockets --enable-http2 --enable-mysqlnd --with-php-config=/usr/local/php749/bin/php-config \
    && make && make install \
    && echo "extension=swoole.so" > /usr/local/php749/lib/php.ini

WORKDIR /usr/src/myapp
CMD [ "php", "-m" ]