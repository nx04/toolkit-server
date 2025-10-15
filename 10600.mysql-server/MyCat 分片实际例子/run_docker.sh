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

mycat_server_run(){
    if [[ -n $(docker ps -q -a -f "name=^mycat_node1$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' mycat_node1`
        if [ "${exist}" != "true" ];then
            mycat_server_restart_event
            echo 'mysql server restart [ok]'
        else
            mycat_server_reload_event
            echo 'mysql server reload [ok]'
        fi
    else
        mycat_server_restart_event
        echo 'mysql server start [ok]'
    fi
}
mycat_server_restart_event(){
    docker run -p 58066:8066 -p 59066:9066 --restart=always --net=docker_network --ip=172.19.60.1 --name mycat_node1 -v /home/mycat/conf:/usr/local/mycat/conf -v /home/mycat/logs:/usr/local/mycat/logs -d nc/mycat:1.6.7.5
}
mycat_server_reload_event(){
    docker restart mycat_node1
}
mycat_server_run
