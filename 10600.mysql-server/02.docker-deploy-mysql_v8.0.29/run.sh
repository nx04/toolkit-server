#!/bin/bash
mysql_image_name=mysql:8.0.29
mysql_server_name='mysql_server_001'
mysql_conf='mysqld.cnf'
init_env_data="/.init_env_data"
# 初始化环境
init_env_action_event(){
    # 设置防火墙
    firewall-cmd --state
    firewall-cmd --list-all
    firewall-cmd --permanent --add-port=80/tcp
    firewall-cmd --permanent --add-port=443/tcp
    firewall-cmd --permanent --add-port=3306/tcp
    firewall-cmd --permanent --add-port=6379/tcp
    firewall-cmd --permanent --add-port=50000-59999/tcp
    firewall-cmd --reload 

    # 内核参数
    ulimit -HSn 102400
    echo 1 > /proc/sys/vm/overcommit_memory
    echo 50000 > /proc/sys/net/core/somaxconn
    echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
    echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
    echo 0 > /proc/sys/net/ipv4/tcp_syncookies

    # 时区
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

    # 拉取mysql镜像
    docker pull $mysql_image_name
}

# 初始化环境-之前的事件
init_env_before_event(){
    action_event_status=0
    if [ -f "$init_env_data" ]; then
        while read line; do
            if [ $line -eq 1 ]; then
                action_event_status=1
            fi
        done < $init_env_data
    fi
    if [ $action_event_status -eq 0 ]; then
        init_env_action_event
        echo 1 > $init_env_data
    fi
    init_env_after_event
}

init_env_after_event(){
    if [[ -n $(docker images -q -f "name=^${mysql_image_name}$") ]];then
	    mysql_server_run
    else
        echo "$mysql_image_name not exist"
    fi
}

init_env_run(){
    init_env_before_event
}

mysql_server_run(){
    if [[ -n $(docker ps -q -f "name=^${mysql_server_name}$") ]];then
	    exist=`docker inspect --format '{{.State.Running}}' ${mysql_server_name}`
        if [ "${exist}" != "true" ];then
        mysql_server_restart_event
        else
        mysql_server_reload_event
        fi
    else
        mysql_server_start_event
    fi
}
mysql_server_start_event(){
    mkdir -p /data/$mysql_server_name/conf
    cp -rf $mysql_conf /data/$mysql_server_name/conf
    docker run -p 53306:3306 -p 33060:33060 --name $mysql_server_name -v /data/$mysql_server_name/data:/var/lib/mysql -v /data/$mysql_server_name/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -e MYSQL_ROOT_PASSWORD=xn9981k% -d $mysql_image_name
}
mysql_server_reload_event(){
    docker restart $mysql_server_name
}
mysql_server_restart_event(){
    docker rm -f $mysql_server_name
    mv /data/$mysql_server_name/data  /data/$mysql_server_name/data.bak
    mysql_server_start_event
    rm -rf /data/$mysql_server_name/data/*
    mv /data/$mysql_server_name/data.bak/* /data/$mysql_server_name/data
    rm -rf /data/$mysql_server_name/data.bak
    mysql_server_reload_event
}

init_env_run

## 进入容器 修改mysql权限
# docker exec -it mysql_system bash
# setenforce 0
## 给用于授予权限,允许其他客户端访问
# mysql -p
# > hj123456
# grant all privileges on *.*  to 'root'@'%' ;
# flush privileges;
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'hj123456' WITH GRANT OPTION;
# flush privileges;
