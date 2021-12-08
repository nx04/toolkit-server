# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils

# 第三方工具
yum install -y zlib zlib-devel bzip2-devel libffi-devel sqlite-devel
yum -y install libsndfile readline-devel xz-devel tk-devel gdbm-devel

# openssl
# https://www.openssl.org/source/openssl-1.1.1l.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/22a4ac75-e6b5-4444-8c87-cc83cbf6f19b.gz -O openssl1release.tar.gz
rm -rf openssl1release && mkdir -p openssl1release
tar -zxvf openssl1release.tar.gz -C ./openssl1release --strip-components 1
cd openssl1release
./config --prefix /usr/local/openssl1release
./config -t
make && make install
cd ../
rm -rf openssl1release openssl1release.tar.gz
ln -s /usr/local/openssl1release/bin/openssl /usr/bin/openssl
ln -s /usr/local/openssl1release/include/openssl /usr/include/openssl
echo "/usr/local/openssl1release/lib" >> /etc/ld.so.conf
openssl version

# install
# https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/55260cf4-9e3d-45cf-90e9-bac2912f3709.tgz -O python3release.tgz
rm -rf python3release && mkdir -p python3release
tar -zxvf python3release.tgz -C ./python3release --strip-components 1
cd python3release
./configure --prefix /usr/local/python3release --with-openssl=/usr/local/openssl1release
make && make install
/usr/local/python3release/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip
/usr/local/python3release/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv
ln -s -f /usr/local/python3release/bin/python3 /usr/bin/python3
ln -s -f /usr/local/python3release/bin/pip3 /usr/bin/pip3
ln -s -f /usr/local/python3release/bin/virtualenv /usr/bin/virtualenv3
cd ../
rm -rf python3release python3release.tgz