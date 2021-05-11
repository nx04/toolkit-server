# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf

yum remove docker*
yum install -y curl yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io

# start docker
systemctl start docker
systemctl enable  docker
cp -rf daemon.json "/etc/docker/daemon.json"
systemctl daemon-reload
systemctl restart docker
docker version


# install docker-compose
# https://github.com/docker/compose/releases
# https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/74a40d60-e737-4973-b6cd-8702ac1d00ea.2 -O /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /bin/docker-compose
ln -s -f /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version