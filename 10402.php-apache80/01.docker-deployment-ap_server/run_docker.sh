#!/bin/bash
# 设置防火墙
firewall-cmd --state
firewall-cmd --list-all
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --permanent --add-port=3306/tcp
firewall-cmd --permanent --add-port=6379/tcp
firewall-cmd --permanent --add-port=50000-59999/tcp
firewall-cmd --reload 

ulimit -HSn 102400
echo 1 > /proc/sys/vm/overcommit_memory
echo 50000 > /proc/sys/net/core/somaxconn
echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
echo 0 > /proc/sys/net/ipv4/tcp_syncookies

# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 初次创建服务
# /etc/httpd/conf/httpd.conf # apache 配置文件
# /var/www/html #http服务部署位置
# /etc/httpd/logs #日志文件位置
# /usr/local/php-release/lib/php.ini # php配置文件所在位置
mkdir -p /data/demo_server_002/apache-config
mkdir -p /data/demo_server_002/apache-logs
mkdir -p /data/demo_server_002/php-config
mkdir -p /data/demo_server_002/www-html
cp -rf httpd.conf /data/demo_server_002/apache-config
docker rm -f demo_server_002
docker run -d -p 8881:80 --name demo_server_002 -v /data/demo_server_002/apache-config/httpd.conf:/etc/httpd/conf/httpd.conf -v /data/demo_server_002/apache-logs:/etc/httpd/logs -v /data/demo_server_002/www-html:/var/www/html apache_php80:2.0.0

