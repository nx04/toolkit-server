# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ make cmake autoconf wget tar curl yum-utils git zlib zlib-devel

# 第三方的开发包
yum -y install libxml2 libxml2-devel sqlite-devel libcurl-devel libevent-devel

# openssl
# https://www.openssl.org/source/openssl-1.1.1l.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/22a4ac75-e6b5-4444-8c87-cc83cbf6f19b.gz -O openssl-release.tar.gz
rm -rf openssl-release && mkdir -p openssl-release
tar -zxvf openssl-release.tar.gz -C ./openssl-release --strip-components 1
cd openssl-release
./config --prefix=/usr/local/openssl-release
./config -t
make
make install
cd ../
rm -rf openssl-release openssl-release.tar.gz
ln -s -f /usr/local/openssl-release/bin/openssl /usr/bin/openssl
ln -s -f /usr/local/openssl-release/include/openssl /usr/include/openssl
echo "/usr/local/openssl-release/lib">> /etc/ld.so.conf
ldconfig
openssl version

# java8
# https://www.oracle.com/java/technologies/downloads/#java8
wget https://696e-infobird-4682b5-1302949103.tcb.qcloud.la/jdk-8u311-linux-x64.tar.gz -O java8-release.tar.gz
rm -rf java8-release && mkdir -p java8-release
tar -zxvf java8-release.tar.gz -C ./java8-release --strip-components 1
rm -rf /usr/local/java8-release
mkdir -p /usr/local/java8-release
mv java8-release/* /usr/local/java8-release
ln -s -f /usr/local/java8-release/bin/java /usr/bin/java
rm -rf java8-release java8-release.tar.gz
java -version

# 修改配置文件
# vim /etc/profile

# 在文件末尾添加如下代码，JAVA_HOME=和JRE_HOME=后面是JDK的安装目录
# export JAVA_HOME=/usr/local/java8-release
# export JRE_HOME=/usr/local/java8-release/jre
# export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
# export PATH=$PATH:$JAVA_HOME/bin

# 使配置文件立即生效
# source /etc/profile