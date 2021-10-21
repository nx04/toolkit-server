# docker network ls # 列出所有网络
# docker network rm [id] # 删除指定网络

# 创建网络
docker network create --subnet 172.19.0.0/16 --gateway 172.19.0.1 zookeeper_kafka

# 查看已创建的网络
# docker network inspect zookeeper_kafka