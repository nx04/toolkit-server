#!/bin/bash

##########安装 redis7############
# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel openssl openssl-devel

# redis702
# https://github.com/redis/redis/archive/refs/tags/7.0.5.tar.gz
wget https://github.com/redis/redis/archive/refs/tags/7.0.5.tar.gz -O redis-release.tar.gz --no-check-certificate
rm -rf redis-release /usr/local/redis-release
mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
make && make install PREFIX=/usr/local/redis-release
cd ../ && rm -rf redis-release redis-release.tar.gz
ln -s -f /usr/local/redis-release/bin/redis-server /usr/bin/redis-server
ln -s -f /usr/local/redis-release/bin/redis-cli /usr/bin/redis-cli
ln -s -f /usr/local/redis-release/bin/redis-sentinel /usr/bin/redis-sentinel



