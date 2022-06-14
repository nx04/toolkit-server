#!/bin/bash
# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip pcre-devel

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel openssl openssl-devel
yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel

# cmake3
yum remove cmake
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/cmake-3.23.1-linux-x86_64.sh -O cmake3-release.sh --no-check-certificate
sh cmake3-release.sh --prefix=/usr/local --exclude-subdir
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

# 安装 apache httpd
yum install httpd -y
yum install httpd-devel -y
cat /etc/httpd/conf/httpd.conf

# 安装 php
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/php-8.0.19.tar.gz -O php-release.tar.gz --no-check-certificate
rm -rf php-release /usr/local/php-release
mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release
./configure --prefix=/usr/local/php-release --enable-soap --with-apxs2=/usr/bin/apxs --with-openssl --enable-bcmath --enable-pcntl --enable-posix --enable-sockets --enable-mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-gd-native-ttf --with-gd --enable-mbstring --enable-fpm --enable-pdo --enable-sysvsem --enable-sysvshm --with-curl --with-zlib=/usr/local/zlib-release
make && make install
cp -rf /usr/local/php-release/etc/php-fpm.conf.default /usr/local/php-release/etc/php-fpm.conf
ln -s -f /usr/local/php-release/bin/php /usr/bin/php
ln -s -f /usr/local/php-release/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php-release/sbin/php-fpm /usr/bin/php-fpm
# mysqli 扩展
cd ./ext/mysqli
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
echo "extension=mysqli.so" >> /usr/local/php-release/lib/php.ini
cd ../../
# zip 扩展
cd ./ext/zip
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
echo "extension=zip.so" >> /usr/local/php-release/lib/php.ini
cd ../../../
rm -rf php-release php-release.tar.gz

# 安装event扩展
# https://pecl.php.net/get/event-3.0.6.tgz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/php-ext/event-3.0.8.tgz -O event-release.tgz --no-check-certificate
rm -rf event-release
mkdir -p event-release
tar -zxvf event-release.tgz -C ./event-release --strip-components 1
cd event-release
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
cd ../
rm -rf event-release event-release.tgz
# 在PHP中开启 PHP 扩展
echo "extension=event.so" >> /usr/local/php-release/lib/php.ini
php --ri event

# 安装 php redis 扩展
# https://pecl.php.net/get/redis-5.3.7.tgz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/php-ext/redis-5.3.7.tgz -O phpredis-release.tar.gz --no-check-certificate
rm -rf phpredis-release
mkdir -p phpredis-release
tar -zxvf phpredis-release.tar.gz -C ./phpredis-release --strip-components 1
cd phpredis-release
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
cd ../
rm -rf phpredis-release phpredis-release.tar.gz
# 在PHP中开启 PHP 扩展
echo "extension=redis.so" >> /usr/local/php-release/lib/php.ini
php --ri redis

# composer
# https://github.com/composer/composer/releases/download/2.2.13/composer.phar
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/composer.phar -O composer --no-check-certificate
rm -rf /usr/local/bin/composer
mv composer /usr/local/bin/composer
chmod +x /usr/local/bin/composer