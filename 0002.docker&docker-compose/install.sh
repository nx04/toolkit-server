# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

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

# install docker
yum remove docker* -y
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

# start docker
systemctl start docker
systemctl enable  docker
echo '{"registry-mirrors":["https://registry.docker-cn.com","https://docker.mirrors.ustc.edu.cn","https://hub-mirror.c.163.com"],"insecure-registries":[]}' > /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
docker version

# install docker-compose
# https://github.com/docker/compose/releases/download/v2.2.2/docker-compose-linux-x86_64
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/b7294b1b-03a4-4276-bd13-86d027729799.2 -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version