# PHP 安装

## 服务器环境及系统软件
最低配置：
- 2核 4GB 1Mbps 40G磁盘
- centos 7.8.2003 （查看版本：cat /etc/redhat-release）


## 相关命令
```
# 创建docker镜像
sh build.sh

# 或者可以不用docker 直接安装
sh install.sh
```

## 安装

为了能支持更大的并发连接数，必须安装 libevent 扩展，并且优化 Linux 内核。

