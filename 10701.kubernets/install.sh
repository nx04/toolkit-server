# time zone
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# build tools
yum install -y yum-utils
yum install -y gcc gcc-c++ make automake autoconf cmake lsof net-tools
yum install -y wget tar curl git unzip zip zlib zlib-devel openssl openssl-devel

# kubelet
## 1、所有机器上执行以下命令，准备安装环境：(注意是所有机器，主机master，从机node都要安装)
#安装epel-release源
yum -y install epel-release
yum -y install firewalld
#所有机器关闭防火墙
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
#查看防火墙状态
firewall-cmd --state
#关闭swap
swapoff -a