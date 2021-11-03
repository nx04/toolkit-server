# 使用 Doris 安装

## 1、使用现成镜像

```
docker pull apache/incubator-doris:build-env-1.3.1
```

## 2、运行镜像

```
docker run -it -v /home/doris-www/.m2:/root/.m2 -v /home/doris-src/:/root/doris-src/ apache/incubator-doris:build-env-1.3.1
```

## 3、下载源码

启动镜像后，你应该已经处于容器内。可以通过以下命令下载 Doris 源码（已挂载本地源码目录则不用）：

```
wget https://github.com/apache/incubator-doris/archive/refs/tags/0.14.0.tar.gz
# or git clone https://github.com/apache/incubator-doris.git
```

## 4、编译 Doris

```
sh build.sh
```

编译完成后，产出文件在 output/ 目录中。


