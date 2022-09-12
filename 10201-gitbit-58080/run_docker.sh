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
    mkdir -p /data/gitbit_server/data
    if [[ -n $(docker ps -q -a -f "name=^gitbit_server$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' gitbit_server`
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
    docker run -p 58080:8080 --restart=always --net=docker_network --ip=172.19.80.80 --name gitbit_server -v /data/gitbit_server/data:/var/opt/gitblit -e TZ=Asia/Shanghai -d gitblit/gitblit:latest --httpsPort=0
}
server_reload_event(){
    docker restart gitbit_server
}
server_restart_event(){
    docker rm -f gitbit_server
    mv /data/gitbit_server/data  /data/gitbit_server/data.bak
    server_start_event
    rm -rf /data/gitbit_server/data/*
    mv /data/gitbit_server/data.bak/* /data/gitbit_server/data
    rm -rf /data/gitbit_server/data.bak
    server_reload_event
}

# 拉取镜像
if [[ "$(docker images -q gitblit/gitblit:latest 2> /dev/null)" == "" ]];then
    docker pull gitblit/gitblit:latest
else
    server_run
fi
