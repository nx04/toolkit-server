# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel

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