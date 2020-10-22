# 编译器和工具
yum install -y gcc gcc-c++
yum install -y make cmake autoconf

yum remove docker*
yum install -y curl yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
#yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
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
# https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)
curl -L "https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/docker-compose/docker-compose-Linux-x86_64-1.27.4" -o "/usr/local/bin/docker-compose"
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version