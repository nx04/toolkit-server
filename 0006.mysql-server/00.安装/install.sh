# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel

# 第三方的开发包
yum install -y bison bzip2 hostname ncurses-devel pkgconfig doxygen

# install
# https://github.com/mysql/mysql-server/archive/refs/tags/mysql-8.0.27.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/mysql-server-mysql-8.0.27.tar.gz -O mysql-release.tar.gz
rm -rf mysql-release && mkdir -p mysql-release
tar -zxvf mysql-release.tar.gz -C ./mysql-release --strip-components 1
cd mysql-release
rm -rf CMakeCache.txt
cmake .. \
-DDOWNLOAD_BOOST=1 \
-DWITH_BOOST=. \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DENABLED_LOCAL_INFILE=ON \
-DWITH_SSL=system \
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql-release/server \
-DMYSQL_DATADIR=/usr/local/mysql-release/data \
-DMYSQL_TCP_PORT=3306
make && make install
cd ../ && rm -rf mysql-release mysql-release.tar.gz