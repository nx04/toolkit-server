#!/bin/bash
echo $#
echo $2
echo $1

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    echo 1 > /proc/sys/vm/overcommit_memory
    echo 32768 > /proc/sys/net/core/somaxconn
    redis-server ../redis.conf --daemonize yes --cluster-enabled yes --cluster-announce-ip 116.85.36.13 --port 7002 --cluster-announce-port 7002 --cluster-announce-bus-port=17002
fi

## 停止服务
if [ "$1"  = "stop" ]
then
    redis-cli -h 127.0.0.1 -p 7002 shutdown
fi

## 查看状态
if [ "$1"  = "status" ]
then
    redis-cli -h 127.0.0.1 -p 7002 info
fi