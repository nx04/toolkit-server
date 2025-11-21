#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# 进度条函数
show_progress() {
    local duration=$1
    local message=$2
    local color=${3:-$CYAN}

    echo -ne "${color}${message} [${NC}"
    local dots=20
    local sleep_time=$(echo "$duration / $dots" | bc -l)

    for ((i=0; i<dots; i++)); do
        echo -ne "${color}#${NC}"
        sleep $sleep_time
    done
    echo -e "${color}] 完成${NC}"
}

# 显示带颜色的标题
print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  Docker 守护进程重启脚本${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# 显示状态信息
print_status() {
    echo -e "${BLUE}[状态]${NC} $1"
}

# 显示成功信息
print_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}

# 显示警告信息
print_warning() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

# 显示错误信息
print_error() {
    echo -e "${RED}[错误]${NC} $1"
}

# 检查Docker进程是否存在
check_docker_processes() {
    local pids=($(ps aux | grep -E 'dockerd' | grep -v grep | awk '{print $2}'))
    if [ ${#pids[@]} -gt 0 ]; then
        echo "${pids[@]}"
        return 0
    else
        return 1
    fi
}

# 主函数
main() {
    print_header
    print_status "开始 Docker 守护进程重启流程"

    # 查找并终止 Docker 进程
    print_status "查找并终止残留的 Docker 进程..."
    local pids=($(ps aux | grep -E 'dockerd' | grep -v grep | awk '{print $2}'))

    if [ ${#pids[@]} -gt 0 ]; then
        for pid in "${pids[@]}"; do
            echo -e "${YELLOW}  终止进程 PID: $pid${NC}"
            kill -9 $pid 2>/dev/null
            if [ $? -eq 0 ]; then
                print_success "进程 $pid 已发送终止信号"
            else
                print_error "无法终止进程 $pid"
            fi
        done
    else
        print_warning "未发现残留的 Docker 进程"
    fi

    # 等待进程终止并验证
    print_status "等待进程完全终止并验证..."
    local attempts=10
    local attempt=0
    local remaining_pids

    while [ $attempt -lt $attempts ]; do
        if remaining_pids=$(check_docker_processes); then
            print_status "仍在等待进程终止，剩余进程: $remaining_pids"
            sleep 1
        else
            print_success "所有 Docker 进程已终止"
            break
        fi
        ((attempt++))
    done

    if [ $attempt -eq $attempts ]; then
        print_error "经过 $attempts 次尝试后仍有 Docker 进程未终止"
        print_status "当前剩余的 Docker 进程: $(check_docker_processes)"
    fi

    # 启动 Docker 守护进程
    print_status "启动 Docker 守护进程..."
    nohup dockerd > docker_start.log 2>&1 &
    DOCKER_PID=$!

    # 等待 Docker 启动
    print_status "等待 Docker 守护进程启动..."
    show_progress 8 "启动中" "$GREEN"

    # 验证 Docker 是否成功启动
    print_status "验证 Docker 是否成功启动..."
    if docker version >/dev/null 2>&1; then
        print_success "Docker 启动成功！"
        echo -e "${GREEN}Docker 版本信息:${NC}"
        docker version --format "Client: {{.Client.Version}}, Server: {{.Server.Version}}" 2>/dev/null || docker version
    else
        print_error "Docker 启动失败，请检查日志文件：docker_start.log"
        echo -e "${RED}日志内容:${NC}"
        cat docker_start.log
        exit 1
    fi

    # 显示最终状态
    print_status "Docker 守护进程重启完成"
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}  任务完成！${NC}"
    echo -e "${GREEN}================================${NC}"
}

# 检查是否安装了 bc 命令
if ! command -v bc &> /dev/null; then
    print_error "需要安装 bc 命令来计算进度条时间，请先安装 bc"
    exit 1
fi

# 执行主函数
main "$@"
