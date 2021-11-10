# redis 集群部署及相关配置
redis 文件夹中保存的是 master 和 slaves 的docker-compose.yml 信息
如果想使用，vim 该文件，将里面的 ip 修改为自己的 ip 即可。

**注意**
> --requirepass 密码 --masterauth 密码

上面两个在 redis 文件夹下的 docker-compose.yml 中，两个密码尽量相同，不同可能会出现错误

sentinel 文件中保存的是哨兵文件信息
使用时，将 sentinel中每个文件夹的中的 ip 修改为自己的 ip 即可


这三个 sentinel1.confg ,sentinel2.confg,sentinel3.confg 文件是笔者已经构建过

默认的 sentinel.conf 是基础，如果想简单使用，删除有 1-3 的conf ，将这个默认文件赋值三份
然后每份文件修改端口和 ip 

最后直接部署即可。

no_password 文件夹下的哨兵集群不存在密码

have_password 文件夹下的哨兵集群存在密码，可以自行选择



## 进入哨兵节点，查看是否有主节点

docker exec -it 85cd540802f9 bash

redis-cli -p 26379

sentinel master mymaster

显示如下信息表示成功

33)"num-slaves"
34) "2"
35) "num-other-sentinels"
36) "2"
37) "quorum"
38) "2"
