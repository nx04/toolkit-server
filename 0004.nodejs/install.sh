# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git


# nodejs
# https://npmmirror.com/mirrors/node/v16.14.2/node-v16.14.2.tar.gz
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