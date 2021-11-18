#!/bin/bash
echo $#
echo $2
echo $1

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    echo 1 > /proc/sys/vm/overcommit_memory
    echo 50000 > /proc/sys/net/core/somaxconn
    cp -rf ../redis.conf.tpl ./redis.conf
    redis-server ./redis.conf --daemonize yes --cluster-enabled yes --cluster-announce-ip 116.85.36.13 --port 7001 --cluster-announce-port 7001 --cluster-announce-bus-port=17001
fi

## 停止服务
if [ "$1"  = "stop" ]
then
    redis-cli -h 127.0.0.1 -p 7001 shutdown
fi

## 查看状态
if [ "$1"  = "status" ]
then
    redis-cli -h 127.0.0.1 -p 7001 info
fi