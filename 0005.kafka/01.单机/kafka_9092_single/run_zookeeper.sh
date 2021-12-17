#!/bin/bash
echo $#
echo $2
echo $1

kafka_release="/usr/local/kafka-release"

# 启动
if [ "$1"  = "start" ]
then
    # 优化内核
    cp -rf ../zookeeper.properties ./zookeeper.properties
    $kafka_release/bin/zookeeper-server-start.sh zookeeper.properties
fi

## 停止服务
if [ "$1"  = "stop" ]
then
   $kafka_release/bin/zookeeper-server-stop.sh
fi

## 查看状态
if [ "$1"  = "status" ]
then
    $kafka_release/bin/zookeeper-server-shell.sh
fi