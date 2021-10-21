# zookeeper 集群搭建

docker-compose up -d

制作docker-compose.yml 如下：

```
version: '3.7'

services:
  zoo1:
    image: zookeeper:3.7.0
    container_name: zoo1
    hostname: zoo1
    restart: unless-stopped
    ports:
      - 59010:2181
    volumes:
      - "./zoo1/data:/data"
      - "./zoo1/datalog:/datalog"
    environment:
      TZ: Asia/Shanghai
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888;2181 server.2=zoo2:2888:3888;2181 server.3=zoo3:2888:3888;2181
    networks:
      default:
        ipv4_address: 172.19.0.11

  zoo2:
    image: zookeeper:3.7.0
    container_name: zoo2
    hostname: zoo2
    restart: unless-stopped
    ports:
      - 59011:2181
    volumes:
      - "./zoo2/data:/data"
      - "./zoo2/datalog:/datalog"
    environment:
      TZ: Asia/Shanghai
      ZOO_MY_ID: 2
      ZOO_SERVERS: server.1=zoo1:2888:3888;2181 server.2=0.0.0.0:2888:3888;2181 server.3=zoo3:2888:3888;2181
    networks:
      default:
        ipv4_address: 172.19.0.12

  zoo3:
    image: zookeeper:3.7.0
    container_name: zoo3
    hostname: zoo3
    restart: unless-stopped
    ports:
      - 59012:2181
    volumes:
      - "./zoo3/data:/data"
      - "./zoo3/datalog:/datalog"
    environment:
      TZ: Asia/Shanghai
      ZOO_MY_ID: 3
      ZOO_SERVERS: server.1=zoo1:2888:3888;2181 server.2=zoo2:2888:3888;2181 server.3=0.0.0.0:2888:3888;2181
    networks:
      default:
        ipv4_address: 172.19.0.13

networks:
  default:
    external:
      name: zookeeper_kafka
```

## 查看状态

docker exec -it [容器ID] zkServer.sh status

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