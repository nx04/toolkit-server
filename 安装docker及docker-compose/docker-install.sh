#!/bin/bash

yum install docker
service docker start
chkconfig docker on
docker version
cp daemon.json /etc/docker/daemon.json
service docker restart

curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /bin/docker-compose
docker-compose --version
