# CentOS Linux

## 官网地址

https://mirrors.huaweicloud.com/centos/7/isos/x86_64/
dvd下载


[https://www.centos.org/](https://www.centos.org/)

## 简介

CentOS 是 Community Enterprise Operating System 的缩写，也叫做社区企业操作系统。是企业 Linux 发行版领头羊 Red Hat Enterprise Linux （以下称之为 RHEL ）的再编译版本（是一个再发行版本），而且在 RHEL 的基础上修正了不少已知的 Bug ，相对于其他 Linux 发行版，其稳定性值得信赖。


## 特點

- CentOS 更加稳定
- CentOS 适合于服务器

## 优化内核参数

编辑 `vi /etc/sysctl.conf`

```
# max open files 修改文件句柄数限制
fs.file-max = 1024000
# max read buffer
net.core.rmem_max = 67108864
# max write buffer
net.core.wmem_max = 67108864
# default read buffer
net.core.rmem_default = 65536
# default write buffer
net.core.wmem_default = 65536
# max processor input queue
net.core.netdev_max_backlog = 4096
# max backlog
net.core.somaxconn = 4096

# resist SYN flood attacks
net.ipv4.tcp_syncookies = 1
# reuse timewait sockets when safe
net.ipv4.tcp_tw_reuse = 1
# turn off fast timewait sockets recycling
net.ipv4.tcp_tw_recycle = 0
# short FIN timeout
net.ipv4.tcp_fin_timeout = 30
# short keepalive time
net.ipv4.tcp_keepalive_time = 1200
# outbound port range
net.ipv4.ip_local_port_range = 10000 65000
# max SYN backlog
net.ipv4.tcp_max_syn_backlog = 4096
# max timewait sockets held by system simultaneously
net.ipv4.tcp_max_tw_buckets = 5000
# TCP receive buffer
net.ipv4.tcp_rmem = 4096 87380 67108864
# TCP write buffer
net.ipv4.tcp_wmem = 4096 65536 67108864
# turn on path MTU discovery
net.ipv4.tcp_mtu_probing = 1

# for high-latency network
net.ipv4.tcp_congestion_control = hybla
# forward ipv4
net.ipv4.ip_forward = 1
```

执行 `sysctl -p` 生效

## TCP 优化 - 文件句柄数限制

修改 `vi /etc/sysctl.conf`

找到 `fs.file-max` 这一行，修改其值为 1024000 ，并保存退出。然后执行 `sysctl -p` 使其生效。

修改 `vi /etc/security/limits.conf`

加入
```
*               soft    nofile           512000
*               hard    nofile          1024000
```

## TCP 优化 - 每个进程可以打开的文件数目

```
ulimit -n 1024000
```

查询 `ulimit -n` 返回 1024000

## 开启 TCP Fast Open

编辑 `vi /etc/sysctl.conf`

文件中再加上一行：

```
# turn on TCP Fast Open on both client and server side
net.ipv4.tcp_fastopen = 3
```

执行 `sysctl -p` 生效

查询 `sysctl net.ipv4.tcp_fastopen` 輸出 net.ipv4.tcp_fastopen = 3
