# docker network ls # 列出所有网络
# docker network rm [id] # 删除指定网络

# 创建网络
docker network create --subnet 172.17.0.0/24 --gateway 172.17.0.1 manager_network

# 查看已创建的网络
# docker network inspect manager_network