# 使用 Doris Docker 编译

## 1、使用现成镜像

```
docker pull apache/incubator-doris:build-env-1.2
```

## 2、运行镜像

```
docker run -it -v /home/doris-www/.m2:/root/.m2 -v /home/doris-release/:/root/doris-release/ apache/incubator-doris:build-env-1.2
```

## 3、下载源码

启动镜像后，你应该已经处于容器内。可以通过以下命令下载 Doris 源码（已挂载本地源码目录则不用）：

```
wget https://github.com/apache/incubator-doris/archive/refs/tags/0.14.0.tar.gz -O doris-release.tar.gz
rm -rf doris-release
mkdir -p doris-release
tar -zxvf doris-release.tar.gz -C ./doris-release --strip-components 1
```

## 4、编译 Doris

```
sh build.sh
```

编译完成后，产出文件在 output/ 目录中。
