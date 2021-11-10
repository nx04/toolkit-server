#!/bin/bash
echo $#
echo $2
echo $1

# 启动
if [ "$1"  = "start" ]
then
    echo 1 > /proc/sys/vm/overcommit_memory
    echo 1024 > /proc/sys/net/core/somaxconn
    redis-server ./redis.conf
fi

## 停止服务
if [ "$1"  = "stop" ]
then
    redis-cli -h 127.0.0.1 -p 7006 shutdown
fi

## 查看状态
if [ "$1"  = "status" ]
then
    redis-cli -h 127.0.0.1 -p 7006 info
fi