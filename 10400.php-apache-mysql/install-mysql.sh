docker pull mysql:5.7.32

mkdir -p /data
docker run -p 3306:3306 --name test-mysql -v /data/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=hj123456 -d mysql:5.7.32

firewall-cmd --permanent --add-port=80-59999/tcp
firewall-cmd --reload 
firewall-cmd --state
firewall-cmd --list-all

# 进入容器
docker exec -it test-mysql bash
setenforce 0
#给用于授予权限
#grant all privileges on *.*  to 'root'@'%' ;
# flush privileges;


docker run -p 3306:3306 --name test-mysql -v /data/mysql/data:/var/lib/mysql -v /data/mysql/conf/mysqld.cnf:/etc/mysql/mysql.conf.d/mysqld.cnf -e MYSQL_ROOT_PASSWORD=hj123456 -d mysql:5.7.32
