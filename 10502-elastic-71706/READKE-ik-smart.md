# IK smart 分词器安装

## 下载ik分词器插件

- 再次强调：ik分词器的版本需要和es的版本一致。

https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.14.2/elasticsearch-analysis-ik-7.14.2.zip

```
复制ik_smart 插件到容器中
docker cp /home/deploy/ik_smart server_elasticsearch:/usr/share/elasticsearch/plugins

重启容器
docker restart server_elasticsearch
```

