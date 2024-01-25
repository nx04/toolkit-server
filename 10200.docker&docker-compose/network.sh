#!/bin/bash
docker network ls

# 	查看网络详情
docker network inspect f6e49456403b

# 创建网络
docker network create --subnet 172.19.0.0/16 --gateway 172.19.0.1 docker_network

# 	查看网络详情
docker network inspect docker_network