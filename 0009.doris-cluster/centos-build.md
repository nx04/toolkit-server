# 使用 centos 编译

## 1、系统依赖

```
yum install -y gmp-devel mpfr-devel libmpc-devel
yum groupinstall 'Development Tools' && yum install -y maven cmake byacc flex automake libtool bison binutils-devel zip unzip ncurses-devel curl git wget python2 glibc-static libstdc++-static java-1.8.0-openjdk
yum install -y centos-release-scl
yum install -y devtoolset-10
scl enable devtoolset-10 bash
```

安装完成后，自行设置环境变量 PATH, JAVA_HOME 等。 注意： Doris 0.14.0 的版本仍然使用gcc7 的依赖编译，之后的代码将使用gcc10 的依赖。

如果当前仓库没有提供devtoolset-10 可以添加如下repo 使用oracle 提供 package

```
[ol7_software_collections]
name=Software Collection packages for Oracle Linux 7 ($basearch)
baseurl=http://yum.oracle.com/repo/OracleLinux/OL7/SoftwareCollections/$basearch/
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
gpgcheck=1
enabled=1
```

## 2、下载源码

```
wget https://github.com/apache/incubator-doris/archive/refs/tags/0.14.0.tar.gz
# or git clone https://github.com/apache/incubator-doris.git
```

## 3、编译 Doris

```
sh build.sh
```

编译完成后，产出文件在 output/ 目录中。