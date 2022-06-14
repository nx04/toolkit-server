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



mkdir -p /data/demo_server_003/apache-config
mkdir -p /data/demo_server_003/apache-logs
mkdir -p /data/demo_server_003/php-config
mkdir -p /data/demo_server_003/www-html
chmod -R 777 /data/demo_server_003/www-html/bootstrap
chmod -R 777 /data/demo_server_003/www-html/storage
chmod -R 777 /data/demo_server_003/www-html/public
cp -rf httpd.conf /data/demo_server_003/apache-config
docker-compose up -d


