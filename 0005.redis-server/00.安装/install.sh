# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# openssl
# https://www.openssl.org/source/openssl-1.1.1l.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/22a4ac75-e6b5-4444-8c87-cc83cbf6f19b.gz -O openssl-release.tar.gz
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

# install redis
# https://download.redis.io/releases/redis-6.2.6.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/7997731a-c833-40b6-9592-2c7f59d6fa6c.gz -O redis-release.tar.gz
rm -rf redis-release && mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
make && make install PREFIX=/usr/local/redis-release
cd ../ && rm -rf redis-release redis-release.tar.gz
ln -s -f /usr/local/redis-release/bin/redis-server /usr/bin/redis-server
ln -s -f /usr/local/redis-release/bin/redis-cli /usr/bin/redis-cli
ln -s -f /usr/local/redis-release/bin/redis-sentinel /usr/bin/redis-sentinel