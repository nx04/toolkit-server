# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils

# 第三方工具
yum install -y zlib zlib-devel openssl openssl-devel bzip2-devel libffi-devel sqlite-devel
yum -y install libsndfile readline-devel xz-devel tk-devel gdbm-devel

# python
# https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/55260cf4-9e3d-45cf-90e9-bac2912f3709.tgz -O python3-release.tgz
rm -rf python3-release && mkdir -p python3-release
tar -zxvf python3-release.tgz -C ./python3-release --strip-components 1
cd python3-release
./configure --prefix /usr/local/python3-release --with-openssl
make && make install
/usr/local/python3-release/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip
/usr/local/python3-release/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv
ln -s -f /usr/local/python3-release/bin/python3 /usr/bin/python3
ln -s -f /usr/local/python3-release/bin/pip3 /usr/bin/pip3
ln -s -f /usr/local/python3-release/bin/virtualenv /usr/bin/virtualenv3
cd ../
rm -rf python3-release python3-release.tgz