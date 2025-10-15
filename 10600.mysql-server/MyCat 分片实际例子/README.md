# Docker 及 docker-compose Mycat


```

#01 先不要 mount volumes

docker run -p 58066:8066 -p 59066:9066 --restart=always --net=docker_network --ip=172.19.60.1 --name mycat_node1 -v /home/mycat/logs:/usr/local/mycat/logs -d nc/mycat:1.6.7.5

# 拷贝容器中默认的配置文件到宿主机
docker cp mycat_node1:/usr/local/mycat/conf /home/mycat


# 修改成自己的配置文件后，重新启动容器
docker restart mycat_node1

# 对外端口防火墙
firewall-cmd --permanent --add-port=58066/tcp
firewall-cmd --permanent --add-port=59066/tcp
firewall-cmd --reload
```