#!/bin/bash
##安装docker##
# time zone
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# build tools
sudo yum update -y
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# docker
yum remove docker* -y
sudo yum install -y docker-ce


# start docker
systemctl start docker
systemctl enable  docker
echo '{"registry-mirrors":["https://docker.1ms.run","https://docker.1panel.live","https://docker.1ms.run","https://mirror.ccs.tencentyun.com","https://docker.mirrors.ustc.edu.cn","https://hub-mirror.c.163.com"],"insecure-registries":[]}' > /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
docker version

# docker-compose
# https://github.com/docker/compose/releases/download/v2.40.2/docker-compose-linux-x86_64
rm -rf /usr/local/bin/docker-compose
wget https://github.com/docker/compose/releases/download/v2.40.2/docker-compose-linux-x86_64 -O /usr/local/bin/docker-compose --no-check-certificate
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
