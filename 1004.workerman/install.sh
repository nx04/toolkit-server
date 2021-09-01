# 设置系统时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone
yum -y install gcc-c++ make autoconf cmake
yum -y install wget zip unzip git tar
yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# 为了能支持更大的并发连接数，必须安装event扩展，并且优化Linux内核。安装方法如下:
yum install libevent-devel -y
# 如果无法安装，尝试使用下面的命令
# yum install libevent2-devel -y


# 安装 php
# https://www.php.net/distributions/php-8.0.10.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/2ea97480-2915-453c-8e92-354cc5e2fdd9.gz -O php-release.tar.gz
rm -rf php-release && mkdir -p php-release
tar -zxvf php-release.tar.gz -C ./php-release --strip-components 1
cd php-release
./configure --prefix /usr/local/php-release --with-openssl --with-openssl-dir --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl  --with-zlib=/usr/local/zlib-release
make && make install
ln -s -f /usr/local/php-release/bin/php /bin/php
ln -s -f /usr/local/php-release/bin/php /usr/bin
ln -s -f /usr/local/php-release/bin/php /usr/local/bin
ln -s -f /usr/local/php-release/bin/phpize /bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/bin/phpize
ln -s -f /usr/local/php-release/bin/phpize /usr/local/bin/phpize
cd ../
rm -rf php-release php-release.tar.gz

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


# 安装workerman
# https://github.com/walkor/Workerman/archive/refs/tags/v4.0.19.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/b686b187-cc39-4ce9-8a95-4883f2063395.gz -O workerman-release.tar.gz
rm -rf workerman-release && mkdir -p workerman-release
tar -zxvf workerman-release.tar.gz -C ./workerman-release --strip-components 1
rm -rf workerman-release.tar.gz


