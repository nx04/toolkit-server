# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf cmake lsof net-tools
yum install -y wget tar curl git unzip zip zlib zlib-devel openssl openssl-devel

# redis
# https://github.com/redis/redis/archive/refs/tags/7.0.0.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/redis-7.0.0.tar.gz -O redis-release.tar.gz --no-check-certificate
rm -rf redis-release /usr/local/redis-release
mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
make && make install PREFIX=/usr/local/redis-release
cd ../ && rm -rf redis-release redis-release.tar.gz
ln -s -f /usr/local/redis-release/bin/redis-server /usr/bin/redis-server
ln -s -f /usr/local/redis-release/bin/redis-cli /usr/bin/redis-cli
ln -s -f /usr/local/redis-release/bin/redis-sentinel /usr/bin/redis-sentinel