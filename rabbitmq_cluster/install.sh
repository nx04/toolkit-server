# rabbitmq server 安装

# 安装依赖
yum -y install gcc gcc-c++ glibc-devel make kernel-devel m4 ncurses-devel openssl-devel xmlto perl wget gtk2-devel binutils-devel xz

# 安装 make 4.3
# http://ftp.gnu.org/gnu/make/make-4.3.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/make/make-4.3.tar.gz
tar -xzvf make-4.3.tar.gz
cd make-4.3
./configure --prefix=/usr/local/make
make && make install
mv /usr/bin/make make.bak
ln -s /usr/local/make/bin/make /usr/bin/make

# 安装 erlang
# http://erlang.org/download/otp_src_23.1.tar.gz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/erlang/otp_src_23.1.tar.gz
tar -xzvf otp_src_23.1.tar.gz
cd otp_src_23.1
./configure --prefix=/usr/local/erlang --with-ssl --enable-threads --enable-smp-support --enable-kernel-poll --enable-hipe 
make && make install
echo 'export PATH=$PATH:/usr/local/erlang/bin' >> /etc/profile
source /etc/profile

# 安装 rabbitmq
# https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.9/rabbitmq-server-generic-unix-3.8.9.tar.xz
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/rabbitmq/rabbitmq-server-generic-unix-3.8.9.tar.xz
xz -d rabbitmq-server-3.8.9.tar.xz
tar -xvf rabbitmq-server-3.8.9.tar
mv ./rabbitmq_server-3.8.9 /usr/local/rabbitmq
echo 'export PATH=$PATH:/usr/local/rabbitmq/sbin' >> /etc/profile
source /etc/profile
# 创建配置目录
mkdir /etc/rabbitmq

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

