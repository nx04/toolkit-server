# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# 第三方的开发包
yum install -y pcre pcre-devel

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

# install
# http://nginx.org/download/nginx-1.21.4.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/f738c5a2-f040-4c44-b9a6-5d69c60f1c4e.gz -O nginx-release.tar.gz
rm -rf nginx-release && mkdir -p nginx-release
tar -zxvf nginx-release.tar.gz -C ./nginx-release --strip-components 1
cd nginx-release
./configure --prefix=/usr/local/nginx-release --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_gzip_static_module --with-http_v2_module
make && make install
ln -s -f /usr/local/nginx-release/sbin/nginx /usr/bin/nginx
cd ../ && rm -rf nginx-release nginx-release.tar.gz

# 配置文件
mkdir -p /usr/local/nginx/conf.d

# 列出所有端口
# netstat -ntlp

# 列出80端口
# lsof -i tcp:80