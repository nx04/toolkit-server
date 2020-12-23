# 设置系统时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

yum -y install gcc-c++ make autoconf cmake
yum -y install wget zip unzip git
yum -y install openssl-devel libxml2 libxml2-devel sqlite-devel libcurl-devel

# 安装 nghttp2
# https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.gz
# wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1779d20-ec23-11ea-81ea-f115fe74321c.gz -O nghttp2-1.41.0.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/66449250-44c8-11eb-97b7-0dc4655d6e68.gz -O nghttp2-1.41.0.tar.gz
tar zxvf nghttp2-1.41.0.tar.gz
cd nghttp2-1.41.0
./configure
make && make install
cd ../
rm -rf nghttp2-1.41.0 nghttp2-1.41.0.tar.gz

# 安装 oniguruma
# https://github.com/kkos/oniguruma/releases/download/v6.9.5/onig-6.9.5.tar.gz
# wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/f1617d10-ec23-11ea-81ea-f115fe74321c.gz -O onig-6.9.5.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/92ffd5c0-44c8-11eb-bd01-97bc1429a9ff.gz -O onig-6.9.5.tar.gz
tar zxvf onig-6.9.5.tar.gz
cd onig-6.9.5
./configure --libdir=/lib64
make && make install
cd ../
rm -rf onig-6.9.5 onig-6.9.5.tar.gz

# 安装 php7.4
# https://www.php.net/distributions/php-7.4.11.tar.gz
# wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/php/php-7.4.11.tar.gz -O php-7.4.11.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/ba2ef680-44c8-11eb-bf0a-894cbc80c40a.gz -O php-7.4.11.tar.gz
tar zxvf php-7.4.11.tar.gz
cd php-7.4.11
./configure --prefix /usr/local/php74 --with-openssl --with-openssl-dir --enable-sockets --enable-mysqlnd --enable-mbstring --with-curl
make && make install
ln -s -f /usr/local/php74/bin/php /bin/php
ln -s -f /usr/local/php74/bin/phpize /bin/phpize
cd ../
rm -rf php-7.4.11 php-7.4.11.tar.gz

# 安装 php swoole 扩展
# https://github.com/swoole/swoole-src/archive/v4.5.4.tar.gz
#wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/swoole/swoole-src-4.5.4.tar.gz -O swoole-src-4.5.4.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/e7831e90-44c8-11eb-97b7-0dc4655d6e68.gz -O swoole-src-4.5.4.tar.gz
tar zxvf swoole-src-4.5.4.tar.gz
cd swoole-src-4.5.4
phpize
./configure --enable-openssl --enable-sockets --enable-http2 --enable-mysqlnd --with-php-config=/usr/local/php74/bin/php-config
make && make install
cd ../
rm -rf swoole-src-4.5.4 swoole-src-4.5.5.tar.gz

# 开启 PHP 扩展
echo "extension=swoole.so" > /usr/local/php74/lib/php.ini

# composer 包管理工具
# https://www.phpcomposer.com/
php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer



