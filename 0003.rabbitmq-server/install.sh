# 编译器和工具
yum install -y gcc gcc-c++
yum install -y make cmake autoconf

# openssl
# OpenSSL 是一个强大的安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及SSL协议，并提供丰富的应用程序供测试或其它目的使用。
yum install -y openssl openssl-devel

# 安装依赖
yum install -y glibc-devel kernel-devel m4 
yum install -y ncurses-devel xmlto perl gtk2-devel binutils-devel

# wget 是Linux中的一个下载文件的工具 
# tar 解压工具
# curl 客户端（client）的 URL 工具
# xz 格式解压工具
yum install -y wget tar curl xz

# 安装 make 4.3
# http://ftp.gnu.org/gnu/make/make-4.3.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/make/make-4.3.tar.gz
tar -xzvf make-4.3.tar.gz
cd make-4.3
./configure --prefix=/usr/local/make
make && make install
mv /usr/bin/make /usr/bin/make.bak
ln -s -f /usr/local/make/bin/make /bin/make
ln -s -f /usr/local/make/bin/make /usr/bin/make
ln -s -f /usr/local/make/bin/make /usr/local/bin/make
cd ../ && rm -rf make-4.3 make-4.3.tar.gz

# 安装 erlang
# http://erlang.org/download/otp_src_23.1.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/erlang/otp_src_23.1.tar.gz
tar -xzvf otp_src_23.1.tar.gz
cd otp_src_23.1
./configure --prefix=/usr/local/erlang --with-ssl --enable-threads --enable-smp-support --enable-kernel-poll --enable-hipe 
make && make install
ln -s -f /usr/local/erlang/bin/erl /bin/erl
ln -s -f /usr/local/erlang/bin/erl /usr/bin/erl
ln -s -f /usr/local/erlang/bin/erl /usr/local/bin/erl
cd ../ && rm -rf otp_src_23.1 otp_src_23.1.tar.gz

# 安装 rabbitmq
# https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.9/rabbitmq-server-generic-unix-3.8.9.tar.xz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/rabbitmq/rabbitmq-server-generic-unix-3.8.9.tar.xz
xz -d rabbitmq-server-generic-unix-3.8.9.tar.xz
tar -xvf rabbitmq-server-generic-unix-3.8.9.tar
mv ./rabbitmq_server-3.8.9 /usr/local/rabbitmq
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-env /usr/bin/rabbitmq-env
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-plugins /usr/bin/rabbitmq-plugins
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-server /usr/bin/rabbitmq-server
ln -s -f /usr/local/rabbitmq/sbin/rabbitmqctl /usr/bin/rabbitmqctl
# 创建配置目录
mkdir -p /etc/rabbitmq
rm -f rabbitmq-server-generic-unix-3.8.9.tar

# 安装插件 rabbitmq_delayed_meaage_exchange
# https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/rabbitmq/rabbitmq_delayed_message_exchange-3.8.0.ez
mv rabbitmq_delayed_message_exchange-3.8.0.ez /usr/local/rabbitmq/plugins/
# 启动delayed_message插件
rabbitmq-plugins enable rabbitmq_delayed_message_exchange

# 启动web管理插件: 
rabbitmq-plugins enable rabbitmq_management

# 查看插件列表: 
rabbitmq-plugins list

# 启动
rabbitmq-server -detached
rabbitmqctl add_user xiaonian 123456
rabbitmqctl set_user_tags xiaonian administrator
rabbitmqctl  set_permissions -p / xiaonian '.*' '.*' '.*'
rabbitmqctl delete_user guest
rabbitmqctl list_users
rabbitmqctl list_user_permissions xiaonian
ip=`curl icanhazip.com`
# 管理端地址 http://IP:15672/
echo http://$ip:15672/


# 启动server：rabbitmq-server start
# 守护进程方式启动server：rabbitmq-server -detached
# 查看进程：netstat -lnpt|grep beam
# 关闭：rabbitmqctl stop
# 查看状态：rabbitmqctl status

# 访问地址：http://IP:15672/
# 查看管理端用户列表：rabbitmqctl list_users
# 添加管理端用户：rabbitmqctl add_user xiaonian 123456
# 将 xiaonian 设置为管理员权限：rabbitmqctl set_user_tags xiaonian administrator
# 删除gust用户：rabbitmqctl delete_user guest
# 将 xiaonian 设置为远端登录：rabbitmqctl  set_permissions -p / xiaonian '.*' '.*' '.*' 
# 查看管理端用户权限：rabbitmqctl list_user_permissions xiaonian

