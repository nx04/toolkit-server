# Docker 及 docker-compose 安装

## 服务器环境及系统软件
最低配置：
- 2核 4GB 1Mbps 40G磁盘
- centos 7.8.2003 （查看版本：cat /etc/redhat-release）


## 相关命令
```
# 启动脚本
docker-compose up -d

# 重启
docker-compose restart

# 停止脚本
docker-compose stop

# 进入容器
docker exec -it 容器id bash
```

