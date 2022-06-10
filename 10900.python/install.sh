# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf cmake lsof
yum install -y wget tar curl git

# 第三方工具
yum install -y zlib zlib-devel bzip2-devel libffi-devel sqlite-devel
yum -y install libsndfile readline-devel xz-devel tk-devel gdbm-devel
yum -y install mesa-libGL libSM libSM.so.6

# openssl
# https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1o.tar.gz
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

# python3
# https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/1015f2d6-3350-4684-90bf-960727f6cb02.tgz -O python3-release.tgz
rm -rf python3-release && mkdir -p python3-release
tar -zxvf python3-release.tgz -C ./python3-release --strip-components 1
cd python3-release
./configure --prefix=/usr/local/python3-release --with-openssl=/usr/local/openssl-release
make && make install
/usr/local/python3-release/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip
/usr/local/python3-release/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv
ln -s -f /usr/local/python3-release/bin/python3 /usr/bin/python3
ln -s -f /usr/local/python3-release/bin/pip3 /usr/bin/pip3
ln -s -f /usr/local/python3-release/bin/virtualenv /usr/bin/virtualenv3
cd ../
rm -rf python3-release python3-release.tgz
python3 -V