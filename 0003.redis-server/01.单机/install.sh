# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils

# install redis
# https://download.redis.io/releases/redis-6.2.6.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/7997731a-c833-40b6-9592-2c7f59d6fa6c.gz -O redis-release.tar.gz
rm -rf redis-release && mkdir -p redis-release
tar -zxvf redis-release.tar.gz -C ./redis-release --strip-components 1
cd redis-release
make && make install PREFIX=/usr/local/redis-release
cd ../ && rm -rf redis-release redis-release.tar.gz
ln -s -f /usr/local/redis-release/bin/redis-server /usr/bin
ln -s -f /usr/local/redis-release/bin/redis-cli /usr/bin
ln -s -f /usr/local/redis-release/bin/redis-sentinel /usr/bin