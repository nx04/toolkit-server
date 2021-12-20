# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# openssl
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

# kafka
# https://kafka.apache.org/
# https://dlcdn.apache.org/kafka/3.0.0/kafka_2.13-3.0.0.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/ff53c99f-acd4-45ab-a9e9-43e374641e00.tgz -O kafka-release.tgz
rm -rf kafka-release && mkdir -p kafka-release
tar -zxvf kafka-release.tgz -C ./kafka-release --strip-components 1
rm -rf /usr/local/kafka-release
mkdir -p /usr/local/kafka-release
mv kafka-release/* /usr/local/kafka-release
rm -rf kafka-release kafka-release.tgz

