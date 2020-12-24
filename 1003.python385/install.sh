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
# https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
# https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/python/Python-3.9.0.tgz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/e58f4860-44c9-11eb-8a36-ebb87efcf8c0.tgz -O Python-3.9.0.tgz
tar zxvf Python-3.9.0.tgz
cd Python-3.9.0
./configure --prefix /usr/local/python390
make && make install
/usr/local/python390/bin/python3 -m pip install -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip
/usr/local/python390/bin/pip3 install -i https://mirrors.aliyun.com/pypi/simple/ virtualenv
ln -s -f /usr/local/python390/bin/python3 /bin/python3
ln -s -f /usr/local/python390/bin/python3 /usr/bin/python3
ln -s -f /usr/local/python390/bin/python3 /usr/local/bin/python3
ln -s -f /usr/local/python390/bin/pip3 /bin/pip3
ln -s -f /usr/local/python390/bin/pip3 /usr/bin/pip3
ln -s -f /usr/local/python390/bin/pip3 /usr/local/bin/pip3
ln -s -f /usr/local/python390/bin/virtualenv /bin/virtualenv3
ln -s -f /usr/local/python390/bin/virtualenv /usr/bin/virtualenv3
ln -s -f /usr/local/python390/bin/virtualenv /usr/local/bin/virtualenv3
cd ../
rm -rf Python-3.9.0 Python-3.9.0.tgz

echo "success";