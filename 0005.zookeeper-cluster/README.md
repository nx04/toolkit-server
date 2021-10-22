# zookeeper 集群

```
docker network create --subnet 172.19.0.0/24 --gateway 172.19.0.1 zookeeper_network
```


| 名称       | 值            |
| ------------ | --------------- |
| 可用网络   | 254           |
| 子网掩码   | 255.255.255.0 |
| 网络号     | 172.19.0.0    |
| 第一个可用 | 172.19.0.1    |
| 最后可用   | 172.19.0.254  |
| 广播       | 172.19.0.255  |

```
docker-compose up -d
```

制作docker-compose.yml 如下：

```
version: '3.7'
services:
  zookeeper1000:
    image: zookeeper:3.7.0
    container_name: zookeeper1000
    hostname: zookeeper1000
    restart: unless-stopped
    ports:
      - "2888:2888"
      - "3888:3888"
      - "52181:2181"
    volumes:
      - "./data:/data"
      - "./datalog:/datalog"
    environment:
      TZ: Asia/Shanghai
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888;2181 server.2=10.255.0.18:2888:3888;2181 server.3=10.255.0.229:2888:3888;2181
    networks:
      default:
        ipv4_address: 172.19.0.10
networks:
  default:
    external:
      name: zookeeper_network
```

## 查看状态

```
docker exec -it [容器ID] zkServer.sh status
```

```
ZooKeeper JMX enabled by default
Using config: /conf/zoo.cfg
Client port found: 2181. Client address: localhost. Client SSL: false.
Mode: follower
```



或者

```
ZooKeeper JMX enabled by default
Using config: /conf/zoo.cfg
Client port found: 2181. Client address: localhost. Client SSL: false.
Mode: leader
```
