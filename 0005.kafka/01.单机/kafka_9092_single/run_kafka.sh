#!/bin/bash
echo $#
echo $2
echo $1

kafka_release="/usr/local/kafka-release"

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    cp -rf ../server.properties ./server.properties
    rm -rf kafka-logs
    $kafka_release/bin/kafka-server-start.sh server.properties
fi

## 停止服务
if [ "$1"  = "stop" ]
then
  $kafka_release/bin/kafka-server-stop.sh
fi

## 查看状态
if [ "$1"  = "status" ]
then
    $kafka_release/bin/kafka-server-shell.sh
fi