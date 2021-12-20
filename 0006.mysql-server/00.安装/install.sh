# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# 第三方的开发包
yum install -y bison bzip2 hostname ncurses-devel pkgconfig doxygen

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

# install
# https://github.com/mysql/mysql-server/archive/refs/tags/mysql-8.0.27.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/mysql-server-mysql-8.0.27.tar.gz -O mysql-release.tar.gz
rm -rf mysql-release && mkdir -p mysql-release
tar -zxvf mysql-release.tar.gz -C ./mysql-release --strip-components 1
cd mysql-release
rm -rf builder
mkdir builder
cd builder
cmake ../ \
-DWITH_SSL=system \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql-release \
-DMYSQL_DATADIR=/usr/local/mysql-data \
-DSYSCONFDIR=/etc \
-DMYSQL_USER=mysql \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_MEMORY_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_READLINE=1 \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DMYSQL_TCP_PORT=3306 \
-DENABLED_LOCAL_INFILE=1 \
-DENABLE_DOWNLOADS=1 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DWITH_DEBUG=0 \
-DMYSQL_MAINTAINER_MODE=0 \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=../boost

make && make install
cd ../../ && rm -rf mysql-release mysql-release.tar.gz
ln -s -f /usr/local/mysql-release/bin/mysql /usr/bin/mysql