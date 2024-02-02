# ES 安装部署教程

## 顺序一定要注意，
- 先按照es
- 再按照kb


## 修改 elastic 密码：
elastic
aa5626188

kibana
aa5626188


**如下操作：进入Elastic容器**
```
docker exec -it 578b09ea6648 bash
./bin/elasticsearch-setup-passwords interactive

# 然后按照指引就可以设置密码。
```

## elastic 地址
http://192.168.91.145:9200/
http://192.168.91.145:5601/


## read_only_allow_delete 参数设置

参数意思:当属性为true的时候,es索引只可以读和删,不可以增和改。变成true的原因:ES集群为了保护数据,会自动把索引分片index置为只读read-only
```
curl -k -u elastic:aa5626188 -XPUT -H "Content-Type:application/json" http://192.168.91.145:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": false}'

curl -k -u elastic:aa5626188 -XPUT -H "Content-Type:application/json" http://114.55.41.252:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": false}'
```

## 如下暂未使用
{
  "index.blocks.read_only_allow_delete": "false",
  "index.priority": "1",
  "index.query.default_field": [
    "*"
  ],
  "index.refresh_interval": "1s",
  "index.write.wait_for_active_shards": "1",
  "index.routing.allocation.include._tier_preference": "data_content",
  "index.number_of_replicas": "1"
}


curl -H "Content-Type:application/json" -X POST -d '{"user": "admin", "passwd":"12345678"}' http://192.168.91.145:9200/testidex/test
