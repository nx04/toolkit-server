#!/bin/bash
echo $#
echo $2
echo $1

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    cp -rf ../server.properties ./server.properties
    kafka-server-start.sh server.properties
fi

## 停止服务
if [ "$1"  = "stop" ]
then
   kafka-server-stop.sh
fi

## 查看状态
if [ "$1"  = "status" ]
then
    kafka-server-shell.sh
fi