# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ cmake3 golang autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel
ln -s /usr/bin/cmake3 /usr/bin/cmake

curl https://sh.rustup.rs -sSf | sh -s
rustup override set nightly-2018-01-12
cargo +nightly-2018-01-12 install rustfmt-nightly --version 0.3.4 --force

export GOPATH=/data/tidb

# java8
# https://github.com/pingcap/tidb/archive/refs/tags/v5.0.6.tar.gz
wget https://github.com/pingcap/tidb/archive/refs/tags/v5.0.6.tar.gz -O tidb-release.tar.gz
rm -rf tidb-release && mkdir -p tidb-release
tar -zxvf tidb-release.tar.gz -C ./tidb-release --strip-components 1
