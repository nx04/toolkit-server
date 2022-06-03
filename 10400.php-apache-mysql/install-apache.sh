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
yum install -y gcc gcc-c++ make automake autoconf
yum install -y lsof net-tools sysstat tree iotop
yum install -y wget tar curl git unzip zip pcre-devel

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel openssl openssl-devel
yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel

# 安装 zlib
# https://github.com/madler/zlib/archive/refs/tags/v1.2.12.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/server/zlib-1.2.12.tar.gz -O zlib-release.tar.gz --no-check-certificate
rm -rf zlib-release /usr/local/zlib-release
mkdir -p zlib-release
tar -zxvf zlib-release.tar.gz -C ./zlib-release --strip-components 1
cd zlib-release
./configure --prefix=/usr/local/zlib-release
make && make install
cd ../
rm -rf zlib-release zlib-release.tar.gz

yum install httpd -y
yum install httpd-devel -y
cat /etc/httpd/conf/httpd.conf
systemctl start httpd.service
systemctl restart httpd.service