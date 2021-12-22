# install RedisJSON
# https://github.com/RedisJSON/RedisJSON/archive/refs/tags/v2.0.6.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/763d23f1-261d-45ff-bbc7-1f74a7313493.gz -O redisJSON-release.tar.gz
rm -rf /usr/local/redisJSON-release
mkdir -p /usr/local/redisJSON-release
tar -zxvf redisJSON-release.tar.gz -C /usr/local/redisJSON-release --strip-components 1
rm -rf redisJSON-release.tar.gz
cd /usr/local/redisJSON-release
make

# 修改 redis.conf
# vim redis.conf
# 文件底部加入,保存
# loadmodule   /usr/local/redisJSON-release/src/rejson.so