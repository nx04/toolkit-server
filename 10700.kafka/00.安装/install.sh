# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel

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

