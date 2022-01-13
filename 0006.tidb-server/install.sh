# 时区
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone

# 编译器和工具
yum install -y gcc gcc-c++ cmake3 golang autoconf wget tar curl yum-utils git zlib zlib-devel openssl openssl-devel
ln -s /usr/bin/cmake3 /usr/bin/cmake

## d1 在线部署 TiUP 组件
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
source /root/.bash_profile
which tiup
tiup --version
tiup cluster
tiup update --self && tiup update cluster

## d2 初始化集群拓扑文件
tiup cluster template > topology.yaml
# 混合部署场景也可以使用 tiup cluster template --full > topology.yaml 生成的建议拓扑模板，
# 跨机房部署场景可以使用 tiup cluster template --multi-dc > topology.yaml 生成的建议拓扑模板。

## d3 检查和自动修复集群存在的潜在风险
tiup cluster check ./topology.yaml --user root -p
tiup cluster check ./topology.yaml --apply --user root -p

## d4 部署集群
tiup cluster deploy tidb-test v5.3.0 ./topology.yaml --user root -p

## d5 查看 TiUP 管理的集群情况
tiup cluster list

## d6 检查部署的 TiDB 集群情况
tiup cluster display tidb-test

## d7 启动集群
tiup cluster start tidb-test

## d8 验证集群运行状态
## 通过 TiUP 检查集群状态
tiup cluster display tidb-test
## 执行如下命令登录数据库
mysql -u root -h 10.0.1.4 -P 4000