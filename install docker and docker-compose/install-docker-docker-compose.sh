#!/bin/bash

yum install -y curl yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#yum update
yum install -y docker-ce docker-ce-cli containerd.io
#安装指定版本的 docker 如下
#yum list docker-ce --showduplicates | sort -r
#yum install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io

# start docker
systemctl start docker
systemctl enable  docker
cp daemon.json "/etc/docker/daemon.json"
systemctl daemon-reload
systemctl restart docker
docker version


# install docker-compose
# https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)
curl -L "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-infobird/57e661c0-ed89-11ea-81ea-f115fe74321c.2" -o "/usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version