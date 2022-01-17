# 安装 TiUP
# curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
source /root/.bash_profile
tiup cluster
tiup update --self && tiup update cluster

# 检测拓扑结构
tiup cluster check ./topology.yaml --user root -p
