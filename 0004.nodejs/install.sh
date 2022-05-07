# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf cmake lsof netstat
yum install -y wget tar curl git zlib zlib-devel openssl openssl-devel


# nodejs
# https://npmmirror.com/mirrors/node/v16.14.2/node-v16.14.2.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/node-v16.14.2.tar.gz -O nodejs-release.tar.gz --no-check-certificate
rm -rf nodejs-release
mkdir -p nodejs-release
tar -zxvf nodejs-release.tar.gz -C ./nodejs-release --strip-components 1
cd nodejs-release
./configure --prefix=/usr/local/nodejs-release
