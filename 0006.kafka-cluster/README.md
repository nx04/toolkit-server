# zookeeper 集群

```
docker network create --subnet 172.18.0.0/24 --gateway 172.18.0.1 zookeeper_network
```


| 名称       | 值            |
| ------------ | --------------- |
| 可用网络   | 254           |
| 子网掩码   | 255.255.255.0 |
| 网络号     | 172.18.0.0    |
| 第一个可用 | 172.18.0.1    |
| 最后可用   | 172.18.0.254  |
| 广播       | 172.18.0.255  |

```
docker-compose up -d
```

制作docker-compose.yml 如下：

```
version: '3.7'
services:
  kafka1000:
    image: wurstmeister/kafka:2.12-2.5.0
    restart: unless-stopped
    hostname: kafka1000
    container_name: kafka1000
    ports:
      - "59091:9092"
      - "59092:9092"
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
      KAFKA_ADVERTISED_LISTENERS: INSIDE://10.255.0.108:59091,OUTSIDE://116.85.15.74:59092
      KAFKA_LISTENERS: INSIDE://:59091,OUTSIDE://:59092
      KAFKA_ZOOKEEPER_CONNECT: 10.255.0.108:52181,10.255.0.18:52181,10.255.0.229:52181
      KAFKA_INTER_BROKER_LISTENER_NAME: INSIDE
    volumes:
      - ./kafka1/logs:/kafka
    networks:
      default:
        ipv4_address: 172.18.0.10
networks:
  default:
    external:
      name: kafka_network
```

- 1）KAFKA_LISTENERS 定义kafka的服务监听地址，addr可以为空，或者0.0.0.0，表示kafka服务会监听在指定地址
- 2）KAFKA_ADVERTISED_LISTENERS kafka发布到zookeeper供客户端使用的服务地址，格式也是PLAINTEXT://<addr>:<port>，但是addr不能为空。
    - 2.1）如果KAFKA_ADVERTISED_LISTENERS没有定义，则是取的KAFKA_LISTENERS的值。
    - 2.2）如果KAFKA_LISTENERS的addr没有定义，则取的java.net.InetAddress.getCanonicalHostName()值。

### 例子：
- 1）容器内定义了：KAFKA_LISTENERS=PLAINTEXT://:9092。
    - 标识kafka服务运行在容器内的9092端口，因为没有指定host，所以是0.0.0.0标识所有的网络接口。
- 2）没有定义KAFKA_ADVERTISED_LISTENERS
    - 按缺省规则，等同于KAFKA_LISTENERS，即PLAINTEXT://:9092，但由于host不能为空，于是取java.net.InetAddress.getCanonicalHostName()，正好取到localhost。
- 3）于是在容器内和宿主机上都能通过地址localhost:9092访问kafka；但其实他们有本质的区别。
    - 在宿主机上通过localhost:9092第一次访问kafka，这个localhost是宿主机，9092是映射到宿主机的端口，容器内的kafka服务接到访问请求后，把KAFKA_ADVERTISED_LISTENERS返回给客户端，其本意是我容器主机localhost和容器端口9092，而客户端接到这个返回brokers后重新解析了localhost为宿主机，和宿主机的端口；但他们正好能够合作。

### 如何让外部其他主机也能访问。

方案已经很明确了，就是发布一个KAFKA_ADVERTISED_LISTENERS到所有人都认识的地址。

- 1）修改docker配置，让container能够访问宿主主机。
- 2）映射kafka容器端口9092到宿主主机。
- 3）定义KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://<宿主主机>:9092

### 实现内外地址分离

让容器网络上的主机访问一个kafka地址，让宿主机网络上的主机访问另一个kafka地址，实现内外地址分离。

```
# 主要INSIDE和OUTSIDE不是保留字，只是普通标识，可以任意取名，解释在KAFKA_LISTENER_SECURITY_PROTOCOL_MAP。
KAFKA_LISTENERS=INSIDE://:9092,OUTSIDE://:9094
KAFKA_ADVERTISED_LISTENERS=INSIDE://<container>:9092,OUTSIDE://<host>:9094
KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INSIDE:PLAINTEXT,OUTSIDE:PLAINTEXT
KAFKA_INTER_BROKER_LISTENER_NAME=INSIDE
```
- 映射容器端口9094到主机9094
- 在容器内kafka服务监听在两个端口9092和9094，端口9094被映射到外面同端口，9094:9094。
- 容器网络使用<container>:9092访问kafka，主机网络使用<host>:9094访问kafka。

## kafka
```
cd kafka
docker-compose up -d
```

## 创建topic
```
docker exec -it kafka1 /opt/kafka_2.12-2.5.0/bin/kafka-topics.sh --create --zookeeper zoo1:2181,zoo2:2181,zoo3:2181 --replication-factor 3 --partitions 1 --topic mytest

docker exec -it kafka1 /opt/kafka_2.12-2.5.0/bin/kafka-topics.sh --describe --zookeeper zoo1:2181,zoo2:2181,zoo3:2181 --topic mytest
```

## 消息测试
```
docker exec -it kafka1 /opt/kafka_2.12-2.5.0/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --topic mytest --from-beginning

docker exec -it kafka1 /opt/kafka_2.12-2.5.0/bin/kafka-console-producer.sh --broker-list kafka1:9092,kafka2:9092,kafka3:9092 --topic mytest
```
