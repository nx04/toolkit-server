# Mysql 安装

## 裸机

```
sh install.sh
```


## Docker

```
sh build.sh
```

**cmake 参数**

```
-DCMAKE_INSTALL_PREFIX=/usr/local/mysql：MySQL安装的根目录
-DMYSQL_DATADIR=/data/mysql：数据文件所存放的目录
-DSYSCONFDIR=/etc ：MySQL配置文件所在目录
-DMYSQL_USER=mysql：MySQL服务的用户名
-DWITH_MYISAM_STORAGE_ENGINE=1：安装MyISAM引擎
-DWITH_INNOBASE_STORAGE_ENGINE=1：安装InnoDB引擎
-DWITH_ARCHIVE_STORAGE_ENGINE=1：安装Archive引擎
-DWITH_MEMORY_STORAGE_ENGINE=1：安装Memory引擎
-DWITH_FEDERATED_STORAGE_ENGINE=1：安装Federated引擎
-DWITH_PARTITION_STORAGE_ENGINE=1：安装Partition引擎
-DWITH_READLINE=1：MySQL的readline library
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock：sock文件的路径
-DMYSQL_TCP_PORT=3306 ：MySQL的监听端口
-DENABLED_LOCAL_INFILE=1：启用加载本地数据
-DENABLE_DOWNLOADS=1：编译时允许自主下载相关文件
-DEXTRA_CHARSETS=all ：使MySQL支持所有的扩展字符
-DDEFAULT_CHARSET=utf8mb4：设置默认字符集为utf8mb4
-DDEFAULT_COLLATION=utf8mb4_general_ci：设置默认字符校对
-DWITH_DEBUG=0：禁用调试模式
-DMYSQL_MAINTAINER_MODE=0：是否启用mysql维护器特定的开发环境
-DDOWNLOAD_BOOST=1：允许在线更新boost库
-DWITH_BOOST=../boost：指定boost安装路径
```