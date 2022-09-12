#!/bin/bash

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 创建docker网络
create_network_event(){
    filter_name=`docker network ls | grep docker_network | awk '{ print $2 }'`
    if [ "$filter_name" == "" ]; then
        #不存在就创建
        docker network create --subnet 172.19.0.0/16 --gateway 172.19.0.1 docker_network
        echo 'docker_network created [\e[32mok\e[0m]'
    else
        echo -e 'docker_network [\e[32mok\e[0m]'
    fi
}
create_network_event

server_run(){
    mkdir -p /data/redmine_server/data
    if [[ -n $(docker ps -q -a -f "name=^redmine_server$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' redmine_server`
        if [ "${exist}" != "true" ];then
            server_restart_event
            echo 'server restart [ok]'
        else
            server_reload_event
            echo 'server reload [ok]'
        fi
    else
        server_start_event
        echo 'server start [ok]'
    fi
}
server_start_event(){
    docker run -p 58081:3000 --restart=always --net=docker_network --ip=172.19.58.81 --name redmine_server -v /data/redmine_server/data:/usr/src/redmine/files -e TZ=Asia/Shanghai -e REDMINE_DB_MYSQL=172.19.50.112 -e REDMINE_DB_PORT=3306 -e REDMINE_DB_USERNAME=root -e REDMINE_DB_PASSWORD=123456 -e REDMINE_DB_DATABASE=redmine -e REDMINE_SECRET_KEY_BASE=supersecretkey -d redmine:5.0.2
}
server_reload_event(){
    docker restart redmine_server
}
server_restart_event(){
    docker rm -f redmine_server
    server_reload_event
}

# 拉取镜像
if [[ "$(docker images -q redmine:5.0.2 2> /dev/null)" == "" ]];then
    docker pull redmine:5.0.2
else
    server_run
fi
