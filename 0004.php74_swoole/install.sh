# 设置系统时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
yum -y install gcc-c++ make autoconf cmake
yum -y install wget zip unzip git tar
yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# 为了能支持更大的并发连接数，必须安装event扩展，并且优化Linux内核。安装方法如下:
yum install libevent-devel -y

# 安装 oniguruma
# https://github.com/kkos/oniguruma/releases/download/v6.9.7.1/onig-6.9.7.1.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/91ebb0f5-0966-48ad-9a37-63bffe297dea.gz -O oniguruma-release.tar.gz
rm -rf oniguruma-release
mkdir -p oniguruma-release
tar -zxvf oniguruma-release.tar.gz -C ./oniguruma-release --strip-components 1
cd oniguruma-release
./configure --prefix /usr/local/oniguruma-release --libdir=/lib64
make && make install
cd ../
rm -rf oniguruma-release oniguruma-release.tar.gz

# 安装 zlib
# https://github.com/madler/zlib/archive/refs/tags/v1.2.11.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/a788bd58-ec24-4eb9-b23d-164d86b70315.gz -O zlib-release.tar.gz
rm -rf zlib-release
mkdir -p zlib-release
tar -zxvf zlib-release.tar.gz -C ./zlib-release --strip-components 1
cd zlib-release
./configure --prefix /usr/local/zlib-release
make && make install
cd ../
rm -rf zlib-release zlib-release.tar.gz

# 安装 php
# https://www.php.net/distributions/php-8.0.10.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/2ea97480-2915-453c-8e92-354cc5e2fdd9.gz -O php-release.tar.gz
rm -rf php-release
mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release
./configure --prefix /usr/local/php-release --with-openssl --with-openssl-dir --enable-bcmath --enable-pcntl --enable-posix --enable-sockets --enable-mysqlnd --enable-mysqli --enable-mbstring --with-curl  --with-zlib=/usr/local/zlib-release
make && make install
ln -s -f /usr/local/php-release/bin/php /bin/php
ln -s -f /usr/local/php-release/bin/php /usr/bin
ln -s -f /usr/local/php-release/bin/php /usr/local/bin
ln -s -f /usr/local/php-release/bin/phpize /bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/local/bin/phpize
cd ./ext/mysqli
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
echo "extension=mysqli.so" >> /usr/local/php-release/lib/php.ini
cd ../../../
rm -rf php-release php-release.tar.gz

# 安装 php swoole 扩展
# https://github.com/swoole/swoole-src/archive/refs/tags/v4.8.1.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/a724b3ec-772c-4fc2-8b67-30e7fb3494f9.gz -O swoole-release.tar.gz
rm -rf swoole-release && mkdir -p swoole-release
tar -zxvf swoole-release.tar.gz -C ./swoole-release --strip-components 1
cd swoole-release
phpize
./configure --enable-openssl --enable-sockets --enable-mysqlnd --with-php-config=/usr/local/php-release/bin/php-config
make && make install
cd ../
rm -rf swoole-release swoole-release.tar.gz
# 在PHP中开启 PHP 扩展
echo "extension=swoole.so" >> /usr/local/php-release/lib/php.ini

php --ri swoole

# 安装event扩展
# https://pecl.php.net/get/event-3.0.5.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/1b997eb6-6372-454d-9f64-1d3ccd7a3d75.tgz -O event-release.tgz
rm -rf event-release && mkdir -p event-release
tar -zxvf event-release.tgz -C ./event-release --strip-components 1
cd event-release
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
cd ../
rm -rf event-release event-release.tgz
# 在PHP中开启 PHP 扩展
echo "extension=event.so" >> /usr/local/php-release/lib/php.ini

# 安装 php redis 扩展
# https://pecl.php.net/get/redis-5.3.4.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/8154890a-ab7d-4c74-a81f-ab19244d0f72.tgz -O phpredis-release.tar.gz
rm -rf phpredis-release && mkdir -p phpredis-release
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

# composer 包管理工具
# https://github.com/composer/composer/releases/download/2.1.12/composer.phar
wget https://github.com/composer/composer/releases/download/2.1.12/composer.phar
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer



