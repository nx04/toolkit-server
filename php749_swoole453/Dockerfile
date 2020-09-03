FROM centos:centos7.6.1810

USER root

# 时区设置
ENV TZ "Asia/Shanghai"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 编译工具及相关依赖程序
RUN yum -y install gcc-c++ make autoconf
RUN yum -y install wget zip unzip git
RUN yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.gz
RUN wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1779d20-ec23-11ea-81ea-f115fe74321c.gz -O nghttp2-1.41.0.tar.gz \
    && tar zxvf nghttp2-1.41.0.tar.gz \
    && cd nghttp2-1.41.0 \
    && ./configure \
    && make && make install

# https://github.com/kkos/oniguruma/releases/download/v6.9.5/onig-6.9.5.tar.gz
RUN wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1617d10-ec23-11ea-81ea-f115fe74321c.gz -O onig-6.9.5.tar.gz \
    && tar zxvf onig-6.9.5.tar.gz \
    && cd onig-6.9.5 \
    && ./configure --libdir=/lib64 \
    && make && make install

# https://www.php.net/distributions/php-7.4.9.tar.gz
RUN wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f16d3ce0-ec23-11ea-8a36-ebb87efcf8c0.gz -O php-7.4.9.tar.gz \
    && tar zxvf php-7.4.9.tar.gz \
    && cd php-7.4.9 \
    && ./configure --prefix /usr/local/php749 --with-openssl --with-openssl-dir --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl \
    && make && make install \
    && ln -s /usr/local/php749/bin/php /bin/php \
    && ln -s /usr/local/php749/bin/phpize /bin/phpize

# https://github.com/swoole/swoole-src/archive/v4.5.3.tar.gz
RUN wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/281efaa0-ec27-11ea-9dfb-6da8e309e0d8.gz -O swoole-src-4.5.3.tar.gz \
    && tar zxvf swoole-src-4.5.3.tar.gz \
    && cd swoole-src-4.5.3 \
    && phpize \
    && ./configure --enable-openssl --enable-sockets --enable-http2 --enable-mysqlnd --with-php-config=/usr/local/php749/bin/php-config \
    && make && make install \
    && echo "extension=swoole.so" > /usr/local/php749/lib/php.ini

# https://www.phpcomposer.com/
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# app 项目目录
WORKDIR /usr/src/myapp

CMD [ "php", "-m" ]