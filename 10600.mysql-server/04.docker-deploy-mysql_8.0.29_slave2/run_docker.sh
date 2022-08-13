#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

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

# 拉取mysql镜像
if [[ "$(docker images -q mysql:8.0.29 2> /dev/null)" == "" ]];then
    docker pull mysql:8.0.29
else
    mysql_server_run
fi

mysql_server_run(){
    mkdir -p /data/mysql_server_004_slave2/data
    mkdir -p /data/mysql_server_004_slave2/log
    mkdir -p /data/mysql_server_004_slave2/conf
    cp -rf ./my.cnf /data/mysql_server_004_slave2/conf/my.cnf
    if [[ -n $(docker ps -q -a -f "name=^mysql_server_004_slave2$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' mysql_server_004_slave2`
        if [ "${exist}" != "true" ];then
            mysql_server_restart_event
            echo 'mysql server restart [ok]'
        else
            mysql_server_reload_event
            echo 'mysql server reload [ok]'
        fi
    else
        mysql_server_start_event
        echo 'mysql server start [ok]'
    fi
}
mysql_server_start_event(){
    docker run -p 50102:3306 -p 53102:33060 --restart=always --net=docker_network --ip=172.19.50.102 --name mysql_server_004_slave2 -v /data/mysql_server_004_slave2/data:/var/data/mysql -v /data/mysql_server_004_slave2/log:/var/log/mysql -v /data/mysql_server_004_slave2/conf/my.cnf:/etc/mysql/my.cnf -e MYSQL_ROOT_PASSWORD=123456 -e TZ=Asia/Shanghai -d mysql:8.0.29
}
mysql_server_reload_event(){
    docker restart mysql_server_004_slave2
}
mysql_server_restart_event(){
    docker rm -f mysql_server_004_slave2
    mv /data/mysql_server_004_slave2/data  /data/mysql_server_004_slave2/data.bak
    mysql_server_start_event
    rm -rf /data/mysql_server_004_slave2/data/*
    mv /data/mysql_server_004_slave2/data.bak/* /data/mysql_server_004_slave2/data
    rm -rf /data/mysql_server_004_slave2/data.bak
    mysql_server_reload_event
}

## 进入容器 修改mysql权限
# docker exec -it mysql_system bash
# setenforce 0
## 给用于授予权限,允许其他客户端访问
# mysql -p
# > 123456
# grant all privileges on *.*  to 'root'@'%' ;
# flush privileges;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
# flush privileges;

