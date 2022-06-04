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

# 拉取mysql 5.7版本的镜像
docker pull mysql:5.7.32

# 初次创建服务
mkdir -p /data/mysql_erpsystem/conf
cp -rf mysqld.cnf /data/mysql_erpsystem/conf
docker run -p 3306:3306 -p 33060:33060 --name mysql_erpsystem -v /data/mysql_erpsystem/data:/var/lib/mysql -v /data/mysql_erpsystem/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -e MYSQL_ROOT_PASSWORD=hj123456 -d mysql:5.7.32

## 进入容器
docker exec -it mysql_erpsystem bash
setenforce 0
## 给用于授予权限,允许其他客户端访问
# mysql -p
# > hj123456
# grant all privileges on *.*  to 'root'@'%' ;
# flush privileges;


# 非首次创建服务
docker rm -f mysql_erpsystem
mv /data/mysql_erpsystem/data  /data/mysql_erpsystem/data.bak
cp -rf mysqld.cnf /data/mysql_erpsystem/conf
docker run -p 3306:3306 -p 33060:33060 --name mysql_erpsystem -v /data/mysql_erpsystem/data:/var/lib/mysql -v /data/mysql_erpsystem/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -e MYSQL_ROOT_PASSWORD=hj123456 -d mysql:5.7.32
rm -rf /data/mysql_erpsystem/data/*
mv /data/mysql_erpsystem/data.bak/* /data/mysql_erpsystem/data
rm -rf /data/mysql_erpsystem/data.bak
docker restart mysql_erpsystem
