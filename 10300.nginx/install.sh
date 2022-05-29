ulimit -HSn 102400
echo 1 > /proc/sys/vm/overcommit_memory
echo 50000 > /proc/sys/net/core/somaxconn
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 0 > /proc/sys/net/ipv4/tcp_syncookies

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf cmake lsof net-tools
yum install -y wget tar curl git unzip zip zlib zlib-devel

# openssl
# https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1o.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/openssl-OpenSSL_1_1_1o.tar.gz -O openssl-release.tar.gz
rm -rf openssl-release /usr/local/openssl-release
mkdir -p openssl-release
tar -zxvf openssl-release.tar.gz -C ./openssl-release --strip-components 1
cd openssl-release
./config --prefix=/usr/local/openssl-release
./config -t
make
make install
cd ../
rm -rf openssl-release openssl-release.tar.gz
ln -s -f /usr/local/openssl-release/bin/openssl /usr/bin/openssl
#ln -s -f /usr/local/openssl-release/include/openssl /usr/include/openssl
echo "/usr/local/openssl-release/lib">> /etc/ld.so.conf
ldconfig
openssl version

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
cp -rf ./conf/nginx.conf /usr/local/nginx-release/conf/nginx.conf
nginx

# 列出所有端口
# netstat -ntlp

# 列出80端口
# lsof -i tcp:80