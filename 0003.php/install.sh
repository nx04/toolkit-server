# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel

# openssl
# https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1m.tar.gz
# https://www.openssl.org/source/openssl-1.1.1m.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/bbaac4f6-6dd5-4591-8391-4bf5b4677b3d.gz -O openssl-release.tar.gz
rm -rf openssl-release && mkdir -p openssl-release
tar -zxvf openssl-release.tar.gz -C ./openssl-release --strip-components 1
cd openssl-release
./config --prefix=/usr/local/openssl-release
./config -t
make
make install
cd ../
rm -rf openssl-release openssl-release.tar.gz
ln -s -f /usr/local/openssl-release/bin/openssl /usr/bin/openssl
ln -s -f /usr/local/openssl-release/include/openssl /usr/include/openssl
echo "/usr/local/openssl-release/lib">> /etc/ld.so.conf
ldconfig
openssl version

# oniguruma
# https://github.com/kkos/oniguruma/releases/download/v6.9.7.1/onig-6.9.7.1.tar.gz
# https://gitee.com/xiaonian0430/oniguruma/repository/archive/v6.9.7.1?format=tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/91ebb0f5-0966-48ad-9a37-63bffe297dea.gz -O oniguruma-release.tar.gz
rm -rf oniguruma-release
mkdir -p oniguruma-release
tar -zxvf oniguruma-release.tar.gz -C ./oniguruma-release --strip-components 1
cd oniguruma-release
./configure --prefix=/usr/local/oniguruma-release --libdir=/lib64
make && make install
cd ../
rm -rf oniguruma-release oniguruma-release.tar.gz

# 安装 zlib
# https://github.com/madler/zlib/archive/refs/tags/v1.2.11.tar.gz
# https://gitee.com/zhang1021/zlib/repository/archive/v1.2.11?format=tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/a788bd58-ec24-4eb9-b23d-164d86b70315.gz -O zlib-release.tar.gz
rm -rf zlib-release
mkdir -p zlib-release
tar -zxvf zlib-release.tar.gz -C ./zlib-release --strip-components 1
cd zlib-release
./configure --prefix=/usr/local/zlib-release
make && make install
cd ../
rm -rf zlib-release zlib-release.tar.gz

# 安装 php
# https://github.com/php/php-src/archive/refs/tags/php-8.0.14.tar.gz
# https://www.php.net/distributions/php-8.0.14.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/8a76f2be-193a-4318-a357-2bba80620fab.gz -O php-release.tar.gz
rm -rf php-release
mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release
./configure --prefix=/usr/local/php-release --with-openssl-dir=/usr/local/openssl-release/lib --with-openssl --enable-bcmath --enable-pcntl --enable-posix --enable-sockets --enable-mysqlnd --enable-mbstring --enable-fpm --enable-pdo --enable-sysvsem --enable-sysvshm --enable-zip --with-curl --with-zlib=/usr/local/zlib-release
make && make install
ln -s -f /usr/local/php-release/bin/php /usr/bin/php
ln -s -f /usr/local/php-release/bin/phpize /usr/bin/phpize
cd ./ext/mysqli
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
echo "extension=mysqli.so" >> /usr/local/php-release/lib/php.ini
cd ../../../
rm -rf php-release php-release.tar.gz

# 安装 php swoole 扩展
# https://github.com/swoole/swoole-src/archive/refs/tags/v4.8.5.tar.gz
# https://gitee.com/swoole/swoole/repository/archive/v4.8.5?format=tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/79dbe9e1-6521-4a8f-ad2f-a40102044e5a.gz -O swoole-release.tar.gz
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
# https://pecl.php.net/get/event-3.0.6.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/83dd059b-abbf-4778-8d36-9676429a9ab0.tgz -O event-release.tgz
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
php --ri event

# 安装 php redis 扩展
# https://pecl.php.net/get/redis-5.3.5.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/14771100-53e2-4963-b203-8ebd4a5b103c.tgz -O phpredis-release.tar.gz
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

# composer
# https://github.com/composer/composer/releases/download/2.2.3/composer.phar
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/83f0e991-23bd-4d03-becd-9e726546e2ea.phar -O composer
mv composer /usr/local/bin/composer
chmod +x /usr/local/bin/composer



