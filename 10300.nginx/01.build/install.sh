#!/bin/bash

##安装nginx##

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip zlib zlib-devel pcre pcre-devel openssl openssl-devel

# nginx
# http://nginx.org/download/nginx-1.22.0.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/nginx-1.22.0.tar.gz -O nginx-release.tar.gz --no-check-certificate
rm -rf nginx-release /usr/local/nginx-release
mkdir -p nginx-release
tar -zxvf nginx-release.tar.gz -C ./nginx-release --strip-components 1
cd nginx-release
./configure --prefix=/usr/local/nginx-release --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_gzip_static_module --with-http_v2_module
make && make install
ln -s -f /usr/local/nginx-release/sbin/nginx /usr/bin/nginx
cd ../ && rm -rf nginx-release nginx-release.tar.gz

# 配置文件
mkdir -p /usr/local/nginx-release/conf.d
cp -rf ./nginx.conf /usr/local/nginx-release/conf/nginx.conf