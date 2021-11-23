# Redis

Redis 是一个开源（BSD许可）的，内存中的数据结构存储系统，它可以用作数据库、缓存和消息中间件。 它支持多种类型的数据结构，如 字符串（strings）， 散列（hashes）， 列表（lists）， 集合（sets）， 有序集合（sorted sets） 与范围查询， bitmaps， hyperloglogs 和 地理空间（geospatial） 索引半径查询。 Redis 内置了 复制（replication），LUA脚本（Lua scripting）， LRU驱动事件（LRU eviction），事务（transactions） 和不同级别的 磁盘持久化（persistence）， 并通过 Redis哨兵（Sentinel）和自动 分区（Cluster）提供高可用性（high availability）

##特性

Redis的性能极高，读的速度是110000次/s,写的速度是81000次/s，支持事务，支持备份，丰富的数据类型。

任何事情都是两面性，Redis也是有缺点的：

- 1、由于是内存数据库，所以单台机器存储的数据量是有限的，需要开发者提前预估，需要及时删除不需要的数据。
- 2、当修改Redis的数据之后需要将持久化到硬盘的数据重新加入到内容中，时间比较久，这个时候Redis是无法正常运行的。