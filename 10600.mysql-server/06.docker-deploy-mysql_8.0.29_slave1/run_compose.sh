#!/bin/bash

# 创建docker网络
create_network_event(){
    filter_name=`docker network ls | grep docker_network | awk '{ print $2 }'`
    if [ "$filter_name" == "" ]; then
        #不存在就创建
        docker network create --subnet 172.19.0.0/24 --gateway 172.19.0.1 docker_network
        echo 'docker_network created [\e[32mok\e[0m]'
    else
        echo -e 'docker_network [\e[32mok\e[0m]'
    fi
}
create_network_event


mkdir -p /data/mysql_server_006_slave1/conf
mkdir -p /data/mysql_server_006_slave1/log
mkdir -p /data/mysql_server_006_slave1/data
cp -rf ./my.cnf /data/mysql_server_006_slave1/conf/my.cnf
docker-compose up -d

#ALTER USER 'root'@'%' IDENTIFIED BY '123456' PASSWORD EXPIRE NEVER;
#ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';



