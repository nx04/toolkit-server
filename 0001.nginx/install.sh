# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel

# nginx
# https://github.com/nginx/nginx/archive/refs/tags/release-1.21.5.tar.gz
# http://nginx.org/download/nginx-1.21.6.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/023a6b5a-0f36-4160-9c17-5961b6f1dc7f.gz -O nginx-release.tar.gz
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