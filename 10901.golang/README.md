# Golang

## 官网地址

https://go.dev/dl/

## 简介

```
tar -C /usr/local -xzf  go1.21.5.linux-amd64.tar.gz

## 设置环境变量
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile

## 设置centos 环境变量
echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
echo 'export GOPATH=$HOME/go' >> ~/.bash_profile
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bash_profile


## 更新
source /etc/profile
source ~/.bash_profile

mkdir -p $GOPATH/src
mkdir $GOPATH/bin
mkdir $GOPATH/pkg


## 检测是否安装成功
go version

```