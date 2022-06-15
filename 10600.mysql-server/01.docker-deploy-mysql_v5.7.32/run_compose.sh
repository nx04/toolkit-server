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

mysql_server_run(){
    mkdir -p /data/mysql_server_001/conf
    cp -rf ./mysqld.cnf /data/mysql_server_001/conf/mysqld.cnf
    if [[ -n $(docker ps -q -a -f "name=^mysql_server_001$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' mysql_server_001`
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
    docker-compose up -d
}
mysql_server_reload_event(){
    docker-compose restart
}
mysql_server_restart_event(){
    docker-compose down
    mv /data/mysql_server_001/data  /data/mysql_server_001/data.bak
    mysql_server_start_event
    rm -rf /data/mysql_server_001/data/*
    mv /data/mysql_server_001/data.bak/* /data/mysql_server_001/data
    rm -rf /data/mysql_server_001/data.bak
    mysql_server_reload_event
}

create_network_event
mysql_server_run

## 进入容器 修改mysql权限
# docker exec -it mysql_server_001 bash
# setenforce 0
## 给用于授予权限,允许其他客户端访问
# mysql -p
# > hj123456
# grant all privileges on *.*  to 'root'@'%' ;
# flush privileges;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'hj123456' WITH GRANT OPTION;
# flush privileges;


