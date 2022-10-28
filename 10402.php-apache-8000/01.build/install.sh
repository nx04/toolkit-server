#!/bin/bash

##php 安装##

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel openssl openssl-devel
yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel
yum -y install mysql-devel

# cmake3
yum remove cmake
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/cmake-3.23.1-linux-x86_64.sh -O cmake3-release.sh --no-check-certificate
sh cmake3-release.sh --prefix=/usr/local --exclude-subdir
cp -rf /usr/bin/cmake /usr/bin/cmake.bak
ln -s -f /usr/local/bin/cmake /usr/bin/cmake

# oniguruma
# https://github.com/kkos/oniguruma/releases/download/v6.9.8/onig-6.9.8.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/onig-6.9.8.tar.gz -O oniguruma-release.tar.gz --no-check-certificate
rm -rf oniguruma-release /usr/local/oniguruma-release
mkdir -p oniguruma-release
tar -zxvf oniguruma-release.tar.gz -C ./oniguruma-release --strip-components 1
cd oniguruma-release
./configure --prefix=/usr/local/oniguruma-release --libdir=/lib64
make && make install
cd ../
rm -rf oniguruma-release oniguruma-release.tar.gz

# 安装 zlib
# https://github.com/madler/zlib/archive/refs/tags/v1.2.12.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/zlib-1.2.12.tar.gz -O zlib-release.tar.gz --no-check-certificate
rm -rf zlib-release /usr/local/zlib-release
mkdir -p zlib-release
tar -zxvf zlib-release.tar.gz -C ./zlib-release --strip-components 1
cd zlib-release
./configure --prefix=/usr/local/zlib-release
make && make install
cd ../
rm -rf zlib-release zlib-release.tar.gz

# 安装 libzip
# https://libzip.org/download/libzip-1.8.0.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/libzip-1.8.0.tar.gz -O libzip-release.tar.gz --no-check-certificate
rm -rf libzip-release
mkdir -p libzip-release
tar -zxvf libzip-release.tar.gz -C ./libzip-release --strip-components 1
cd libzip-release
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make && make install
cd ../../
rm -rf libzip-release libzip-release.tar.gz

# 安装 httpd
yum install httpd -y
yum install httpd-devel -y

# 安装 php
# https://www.php.net/distributions/php-8.0.19.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/php-8.0.19.tar.gz -O php80-release.tar.gz --no-check-certificate
rm -rf php80-release /usr/local/php80-release
mkdir -p php80-release
tar -zxvf php80-release.tar.gz -C ./php80-release --strip-components 1
cd php80-release
./configure --prefix=/usr/local/php80-release --with-apxs2=/usr/bin/apxs --with-openssl --enable-bcmath --enable-pcntl --enable-posix --enable-sockets --enable-mysqlnd --enable-gd --enable-mbstring --enable-fpm --enable-pdo --with-pdo-mysql --enable-sysvsem --enable-sysvshm --with-curl --with-zlib=/usr/local/zlib-release
make && make install
cp -rf /usr/local/php80-release/etc/php-fpm.conf.default /usr/local/php80-release/etc/php-fpm.conf
cp -rf /usr/local/php80-release/etc/php-fpm.d/www.conf.default /usr/local/php80-release/etc/php-fpm.d/www.conf
ln -s -f /usr/local/php80-release/bin/php /usr/bin/php
ln -s -f /usr/local/php80-release/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php80-release/sbin/php-fpm /usr/bin/php-fpm
# mysqli 扩展
cd ./ext/mysqli
phpize
./configure --with-php-config=/usr/local/php80-release/bin/php-config
make && make install
echo "extension=mysqli.so" >> /usr/local/php80-release/lib/php.ini
cd ../../
# zip 扩展
cd ./ext/zip
phpize
./configure --with-php-config=/usr/local/php80-release/bin/php-config
make && make install
echo "extension=zip.so" >> /usr/local/php80-release/lib/php.ini
cd ../../../
rm -rf php80-release php80-release.tar.gz

# 安装 php redis 扩展
# https://pecl.php.net/get/redis-5.3.7.tgz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/php-ext/redis-5.3.7.tgz -O redis-release.tar.gz --no-check-certificate
rm -rf redis-release
mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
phpize
./configure --with-php-config=/usr/local/php80-release/bin/php-config
make && make install
cd ../
rm -rf redis-release redis-release.tar.gz
# 在PHP中开启 PHP 扩展
echo "extension=redis.so" >> /usr/local/php80-release/lib/php.ini
php --ri redis

# composer
# https://github.com/composer/composer/releases/download/2.2.13/composer.phar
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/composer.phar -O composer --no-check-certificate
rm -rf /usr/local/bin/composer
mv composer /usr/local/bin/composer
chmod +x /usr/local/bin/composer

