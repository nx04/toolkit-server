# http://ftp.gnu.org/gnu/make/make-4.3.tar.gz
wget https://vkceyugu.cdn.bspapp.com/VKCEYUGU-f21b85c6-6337-4b61-b6e7-aca75841afed/63fbe139-c2d7-4600-9140-93a1e6575524.gz -O make-release.tar.gz
rm -rf make-release && mkdir -p make-release
tar -zxvf make-release.tar.gz -C ./make-release --strip-components 1
cd make-release
./configure --prefix=/usr/local/make-release
make
make install
mv /usr/bin/make /usr/bin/make.bak
ln -s -f /usr/local/make-release/bin/make /usr/bin/make
make -v
cd ../
rm -rf make-release make-release.tar.gz

# install RediSearch
# https://github.com/RediSearch/RediSearch/archive/refs/tags/v2.0.15.tar.gz
# https://gitee.com/xiaonian0430/RediSearch.git
git clone --recursive https://gitee.com/xiaonian0430/RediSearch.git rediSearch-release
cd rediSearch-release
make setup
make build
make run
rm -rf /usr/local/rediSearch-release
mkdir -p /usr/local/rediSearch-release
mv build/redisearch.so /usr/local/rediSearch-release
rm -rf rediSearch-release

# 修改 redis.conf
# vim redis.conf
# 文件底部加入,保存
# loadmodule   /usr/local/rediSearch-release/redisearch.so