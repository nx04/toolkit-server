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
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/63fbe139-c2d7-4600-9140-93a1e6575524.gz -O make-release.tar.gz
rm -rf make-release && mkdir -p make-release
tar -zxvf make-release.tar.gz -C ./make-release --strip-components 1
cd make-release
./configure --prefix=/usr/local/make
make && make install
mv /usr/bin/make /usr/bin/make.bak
ln -s -f /usr/local/make/bin/make /bin/make
ln -s -f /usr/local/make/bin/make /usr/bin/make
ln -s -f /usr/local/make/bin/make /usr/local/bin/make
cd ../ && rm -rfmake-release make-release.tar.gz

# 安装 erlang
# https://erlang.org/download/otp_src_24.0.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/c70623d1-478b-469e-8cb7-23fcc9c2fc8e.gz -O erlang-release.tar.gz
rm -rf erlang-release && mkdir -p erlang-release
tar -zxvf erlang-release.tar.gz -C ./erlang-release --strip-components 1
cd erlang-release
./configure --prefix=/usr/local/erlang --with-ssl --enable-threads --enable-smp-support --enable-kernel-poll --enable-hipe 
make && make install
ln -s -f /usr/local/erlang/bin/erl /bin/erl
ln -s -f /usr/local/erlang/bin/erl /usr/bin/erl
ln -s -f /usr/local/erlang/bin/erl /usr/local/bin/erl
cd ../ && rm -rf erlang-release erlang-release.tar.gz

# 安装 rabbitmq
# https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.22/rabbitmq-server-generic-unix-3.8.22.tar.xz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/6a3a012b-664c-4dc1-80e1-0f6f20823edc.xz -O rabbitmq-release.tar.xz
xz -d rabbitmq-release.tar.xz
rm -rf rabbitmq-release && mkdir -p rabbitmq-release
tar -xvf rabbitmq-release.tar -C ./rabbitmq-release --strip-components 1
mv ./rabbitmq-release /usr/local/rabbitmq
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-env /usr/bin/rabbitmq-env
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-plugins /usr/bin/rabbitmq-plugins
ln -s -f /usr/local/rabbitmq/sbin/rabbitmq-server /usr/bin/rabbitmq-server
ln -s -f /usr/local/rabbitmq/sbin/rabbitmqctl /usr/bin/rabbitmqctl
# 创建配置目录
mkdir -p /etc/rabbitmq
rm -f rabbitmq-release.tar

# 安装插件 rabbitmq_delayed_meaage_exchange
# https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/3.9.0/rabbitmq_delayed_message_exchange-3.9.0.ez
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/d821992c-7351-4c66-be45-db657f8f9dd0.ez -O rabbitmq_delayed_message_exchang.ez
mv rabbitmq_delayed_message_exchange.ez /usr/local/rabbitmq/plugins/
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

