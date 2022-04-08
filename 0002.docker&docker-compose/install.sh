# time zone
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# build tools
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel

# docker
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

# docker-compose
# https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-linux-x86_64
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/dc38addf-cb77-4c34-8f74-2812d5595e79.1 -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version