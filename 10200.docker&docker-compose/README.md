# Docker 及 docker-compose 安装

## 官网地址

[https://github.com/docker](https://github.com/docker)

## 简介

Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从 Apache2.0 协议开源。

Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。

容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

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

# 拷贝容器的文件到宿主机
docker cp mycontainer:/app/data.txt /home
```

docker至少有一个进程保持运行，否则会启动失败


# dockerd 也可以启动