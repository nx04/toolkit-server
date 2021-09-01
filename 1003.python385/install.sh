# 时区设置
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf

# wget是Linux中的一个下载文件的工具 
# tar解压工具
yum install -y wget tar
yum install -y zlib zlib-devel
yum install -y openssl openssl-devel
yum install -y bzip2-devel
yum install -y libffi-devel
yum install -y sqlite-devel
yum -y install libsndfile readline-devel xz-devel tk-devel gdbm-devel

# python
# https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/b4a1773d-6af2-4dec-9820-dbd63b832ae3.tgz -O python3-release.tgz
rm -rf python3-release && mkdir -p python3-release
tar -zxvf python3-release.tgz -C ./python3-release --strip-components 1
cd python3-release
./configure --prefix /usr/local/python3
make && make install
/usr/local/python3/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip
/usr/local/python3/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv
ln -s -f /usr/local/python3/bin/python3 /bin/python3
ln -s -f /usr/local/python3/bin/python3 /usr/bin/python3
ln -s -f /usr/local/python3/bin/python3 /usr/local/bin/python3
ln -s -f /usr/local/python3/bin/pip3 /bin/pip3
ln -s -f /usr/local/python3/bin/pip3 /usr/bin/pip3
ln -s -f /usr/local/python3/bin/pip3 /usr/local/bin/pip3
ln -s -f /usr/local/python3/bin/virtualenv /bin/virtualenv3
ln -s -f /usr/local/python3/bin/virtualenv /usr/bin/virtualenv3
ln -s -f /usr/local/python3/bin/virtualenv /usr/local/bin/virtualenv3
cd ../
rm -rf python3-release python3-release.tgz

echo "success";