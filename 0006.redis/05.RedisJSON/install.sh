# install RedisJSON
# https://github.com/RedisJSON/RedisJSON.git
# https://gitee.com/xiaonian0430/RedisJSON.git
git clone --recursive https://gitee.com/xiaonian0430/RedisJSON.git redisJSON-release
cd redisJSON-release
make setup
make build
make run
rm -rf /usr/local/redisJSON-release
mkdir -p /usr/local/redisJSON-release
mv build/rejson.so /usr/local/redisJSON-release
rm -rf redisJSON-release

# 修改 redis.conf
# vim redis.conf
# 文件底部加入,保存
# loadmodule   /usr/local/redisJSON-release/src/rejson.so