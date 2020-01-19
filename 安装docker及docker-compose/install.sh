#!/bin/bash

# var defined
DOCKER_COMPOSE_VERSION = "1.25.1"
DOCKER_VERSION = "19.03.5"

yum install -y curl wget gcc-c++ make autoconf

# install docker
wget "https://github.com/docker/docker-ce/archive/v${DOCKER_VERSION}.tar.gz" -o "docker.tar.gz"
mkdir -p docker
tar -xf docker.tar.gz -C docker --strip-components=1
rm docker.tar.gz
cd docker
./configure --prefix="/usr/local/docker"
make
make install
rm -r docker
service docker start
chkconfig docker on
cp daemon.json "/etc/docker/daemon.json"
service docker restart
docker version


# install docker-compose
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o "/usr/local/bin/docker-compose"
chmod +x "/usr/local/bin/docker-compose"
ln -s "/usr/local/bin/docker-compose" "/bin/docker-compose"
docker-compose --version
