# kafka 集群

## zookeeper
```
cd zookeeper
docker-compose up -d
```

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