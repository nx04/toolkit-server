# 关于nginx并发连接能力优化

nginx 服务器老是报告 TIME_WAIT 告警,  ESTABLISHED 告警,检查 nginx 配置和系统网络配置发现现有的配置并发能力太弱，无法满足现有的并发请求的需求。

## 查看 linux 内核
```
cat /proc/version
```
Linux version 3.10.0-957.27.2.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SMP Mon Jul 29 17:46:05 UTC 2019

```
uname -a
```
Linux iZwz9fz9mqmeex5u8wchuoZ 3.10.0-957.27.2.el7.x86_64 #1 SMP Mon Jul 29 17:46:05 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

- 第1个组数字：3, 主版本号
- 第2个组数字：10, 次版本号，当前为稳定版本
- 第3个组数字：0, 修订版本号
- 第4个组数字：957.27.2，表示发型版本的补丁版本
- el7：则表示我正在使用的内核是 RedHat / CentOS 系列发行版专用内核
- x86_64：采用的是64位的CPU


## 查看Linux系统版本
```
lsb_release -a
```
LSB Version:    :core-4.1-amd64:core-4.1-noarch
Distributor ID: CentOS
Description:    CentOS Linux release 7.6.1810 (Core) 
Release:        7.6.1810
Codename:       Core

```
cat /etc/redhat-release
# 这种方法只适合Redhat系的Linux
```
CentOS Linux release 7.6.1810 (Core)



## 解决方法

### 1 改进方案
- a、使用epoll模式，增加并发连接数，增加nginx系统并发连接能力。
- b、后端使用长连接, 提高端口利用率，减少TIME_WAIT状态比例, 使系统可以允许更多的TIME_WAIT.
- c、优化tcp连接工作模式，减少FIN2_WAIT状态比例 (对应监控中的OTHERSTATE)。
- d、合理的设置监控参数

### 2 具体配置内容如下

2.1) 打开 conf/nginx.conf 配置文件，对其中 events 的 worker_connections 、 multi_accept 、 accept_mutex 等参进行调优，如下所示

Epoll: 使用于 Linux 内核 2.6 版本及以后的系统。

***原配置***

```
events {
    worker_connections  1024;
}
```

***优化后配置***

```
events {
    use epoll; #支持大量连接和非活动连接
    worker_connections 32768;
    multi_accept on; #nginx在已经得到一个新连接的通知时，接收尽可能多的连接
    accept_mutex on; #防止惊群现象发生，默认为on
}
```

***优化说明***

使用 epoll 模式，将连接从现在的 2048 增加到 32768 ，Epoll 模式将提高并发连接到 100K 级别, 而且非活跃的连接（连接正常但没有数据或死的连接对象）数量不影响活跃连接的性能。

2.2) upstream 中使用 keepalive ，如下

```
upstream httpproxy{ 
    server 192.168.1.14:8080; 
    server 192.168.1.15:8080;
    keepalive 128; 
}
```

2.3) 内核参数优化

fs.file-max = 999999 
这个参数表示进程（比如一个worker进程）可以同时打开的最大句柄数，这个参数直线限制最大并发连接数，需根据实际情况配置。

net.ipv4.tcp_max_tw_buckets = 6000
这个参数表示操作系统允许TIME_WAIT套接字数量的最大值，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。该参数默认为180000，过多的TIME_WAIT套接字会使Web服务器变慢。注：主动关闭连接的服务端会产生TIME_WAIT状态的连接

net.ipv4.ip_local_port_range = 1024 65000
允许系统打开的端口范围。

net.ipv4.tcp_tw_recycle = 1
启用timewait快速回收。

net.ipv4.tcp_tw_reuse = 1
开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接。这对于服务器来说很有意义，因为服务器上总会有大量TIME-WAIT状态的连接。

net.ipv4.tcp_keepalive_time = 30
这个参数表示当keepalive启用时，TCP发送keepalive消息的频度。默认是2小时，若将其设置的小一些，可以更快地清理无效的连接。

net.ipv4.tcp_syncookies = 1
开启SYN Cookies，当出现SYN等待队列溢出时，启用cookies来处理。

net.core.somaxconn = 40960
web 应用中 listen 函数的 backlog 默认会给我们内核参数的。

net.core.somaxconn 限制到128，而nginx定义的NGX_LISTEN_BACKLOG 默认为511，所以有必要调整这个值。注：对于一个TCP连接，Server与Client需要通过三次握手来建立网络连接.当三次握手成功后,我们可以看到端口的状态由LISTEN转变为ESTABLISHED,接着这条链路上就可以开始传送数据了.每一个处于监听(Listen)状态的端口,都有自己的监听队列.监听队列的长度与如somaxconn参数和使用该端口的程序中listen()函数有关。somaxconn定义了系统中每一个端口最大的监听队列的长度,这是个全局的参数,默认值为128，对于一个经常处理新连接的高负载 web服务环境来说，默认的 128 太小了。大多数环境这个值建议增加到 1024 或者更多。大的侦听队列对防止拒绝服务 DoS 攻击也会有所帮助。

net.core.netdev_max_backlog = 262144
每个网络接口接收数据包的速率比内核处理这些包的速率快时，允许送到队列的数据包的最大数目。

net.ipv4.tcp_max_syn_backlog = 262144
这个参数标示TCP三次握手建立阶段接受SYN请求队列的最大长度，默认为1024，将其设置得大一些可以使出现Nginx繁忙来不及accept新连接的情况时，Linux不至于丢失客户端发起的连接请求。

net.ipv4.tcp_rmem = 10240 87380 12582912
这个参数定义了TCP接受缓存（用于TCP接受滑动窗口）的最小值、默认值、最大值。

net.ipv4.tcp_wmem = 10240 87380 12582912
这个参数定义了TCP发送缓存（用于TCP发送滑动窗口）的最小值、默认值、最大值。

net.core.rmem_default = 6291456
这个参数表示内核套接字接受缓存区默认的大小。

net.core.wmem_default = 6291456
这个参数表示内核套接字发送缓存区默认的大小。

net.core.rmem_max = 12582912
这个参数表示内核套接字接受缓存区的最大大小。

net.core.wmem_max = 12582912
这个参数表示内核套接字发送缓存区的最大大小。

net.ipv4.tcp_syncookies = 1
该参数与性能无关，用于解决TCP的SYN攻击。


vi /etc/sysctl.conf

```
fs.file-max = 999999
net.ipv4.ip_forward = 0
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296
net.ipv4.tcp_max_tw_buckets = 6000
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_rmem = 10240 87380 12582912
net.ipv4.tcp_wmem = 10240 87380 12582912
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.netdev_max_backlog = 262144
net.core.somaxconn = 40960
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.tcp_max_syn_backlog = 262144
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_fin_timeout = 1
net.ipv4.tcp_keepalive_time = 30
net.ipv4.ip_local_port_range = 1024 65000
```

执行 sysctl  -p 使内核修改生效。


2.4）关于系统连接数的优化

linux 默认值 open files为1024。

查看当前系统值： ulimit -n

1024

说明server只允许同时打开1024个文件。

使用ulimit -a 可以查看当前系统的所有限制值，使用ulimit -n 可以查看当前的最大打开文件数。

新装的linux 默认只有1024 ，当作负载较大的服务器时，很容易遇到error: too many open files。因此，需要将其改大，在/etc/security/limits.conf最后增加：
```
#<domain>      <type>  <item>         <value>
*              soft    nofile         65535
*              hard    nofile         65535
*              soft    noproc         65535
*              hard    noproc         65535
```

