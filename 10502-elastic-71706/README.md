# ES
顺序一定要注意，
先es
在kb


修改密码：
elastic
aa5626188

kibana
aa5626188
docker exec -it 578b09ea6648 bash
./bin/elasticsearch-setup-passwords interactive


http://192.168.91.145:9200/
http://192.168.91.145:5601/


curl -k -u elastic:aa5626188 -XPUT -H "Content-Type:application/json" http://192.168.91.145:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": false}'

curl -k -u elastic:aa5626188 -XPUT -H "Content-Type:application/json" http://114.55.41.252:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": false}'


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
