# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils

# 第三方的开发包
yum install -y pcre pcre-devel zlib zlib-devel openssl openssl-devel

# Stable version
# http://nginx.org/download/nginx-1.21.4.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/f738c5a2-f040-4c44-b9a6-5d69c60f1c4e.gz -O nginx-release.tar.gz
rm -rf nginx-release && mkdir -p nginx-release
tar -zxvf nginx-release.tar.gz -C ./nginx-release --strip-components 1
cd nginx-release
./configure --prefix=/usr/local/nginx-release --with-http_stub_status_module --with-http_ssl_module --with-pcre --with-http_gzip_static_module --with-http_v2_module
make && make install
ln -s -f /usr/local/nginx-release/sbin/nginx /bin/nginx
ln -s -f /usr/local/nginx-release/sbin/nginx /usr/bin/nginx
ln -s -f /usr/local/nginx-release/sbin/nginx /usr/local/bin/nginx
cd ../ && rm -rf nginx-release nginx-release.tar.gz

# 优化系统内核参数，单机1万并发，每个连接请求10万次
ulimit -n 65535
echo 1 > /proc/sys/vm/overcommit_memory
echo 50000 > /proc/sys/net/core/somaxconn
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 0 > /proc/sys/net/ipv4/tcp_syncookies

# 配置文件
mkdir -p /usr/local/nginx/conf.d

# 列出所有端口
# netstat -ntlp

# 列出80端口
# lsof -i tcp:80