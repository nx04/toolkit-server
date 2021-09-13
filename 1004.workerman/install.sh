# 设置系统时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
yum -y install gcc-c++ make autoconf cmake
yum -y install wget zip unzip git tar
yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# 为了能支持更大的并发连接数，必须安装event扩展，并且优化Linux内核。安装方法如下:
yum install libevent-devel -y
# 如果无法安装，尝试使用下面的命令
# yum install libevent2-devel -y

# 安装 oniguruma
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/91ebb0f5-0966-48ad-9a37-63bffe297dea.gz -O oniguruma-release.tar.gz
rm -rf oniguruma-release
mkdir -p oniguruma-release
tar -zxvf oniguruma-release.tar.gz -C ./oniguruma-release --strip-components 1
cd oniguruma-release
./configure --prefix /usr/local/oniguruma-release --libdir=/lib64
make && make install
cd ../
rm -rf oniguruma-release oniguruma-release.tar.gz

# 安装 php
# https://www.php.net/distributions/php-8.0.10.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/2ea97480-2915-453c-8e92-354cc5e2fdd9.gz -O php-release.tar.gz
rm -rf php-release && mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release
./configure --prefix /usr/local/php-release --with-openssl --with-openssl-dir --enable-pcntl --enable-posix --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl  --with-zlib=/usr/local/zlib-release
make && make install
ln -s -f /usr/local/php-release/bin/php /bin/php
ln -s -f /usr/local/php-release/bin/php /usr/bin
ln -s -f /usr/local/php-release/bin/php /usr/local/bin
ln -s -f /usr/local/php-release/bin/phpize /bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/local/bin/phpize
cd ../
rm -rf php-release php-release.tar.gz

# 已有php安装 pcntl扩展
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/2ea97480-2915-453c-8e92-354cc5e2fdd9.gz -O php-release.tar.gz
rm -rf php-release && mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release/ext/pcntl
phpize
./configure --with-php-config=/usr/local/php-release/bin/php-config
make && make install
cd ../../../
rm -rf php-release php-release.tgz
# 在PHP中开启 PHP 扩展
echo "extension=pcntl.so" >> /usr/local/php-release/lib/php.ini


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


# composer 包管理工具
# https://www.phpcomposer.com/
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/


