# install RediSearch
# https://github.com/RediSearch/RediSearch/archive/refs/tags/v2.0.15.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/dec435ad-73af-4a80-970b-680c2b238ac3.gz -O rediSearch-release.tar.gz
rm -rf /usr/local/rediSearch-release
mkdir -p /usr/local/rediSearch-release
tar -zxvf rediSearch-release.tar.gz -C /usr/local/rediSearch-release --strip-components 1
rm -rf rediSearch-release.tar.gz
cd /usr/local/rediSearch-release
make all

# 修改 redis.conf
# vim redis.conf
# 文件底部加入,保存
# loadmodule   /usr/local/rediSearch-release/src/redisearch.so