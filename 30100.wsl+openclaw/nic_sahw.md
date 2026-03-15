先在 PowerShell 执行：

wsl --update
wsl --status
wsl --version
wsl --set-default-version 2
wsl --list --verbose

wsl --install Ubuntu-22.04


sudo apt update && sudo apt upgrade -y

sudo apt install -y build-essential curl git unzip zip ca-certificates jq


额外安装 1Panel（解决 docker 环境问题）

sudo bash -c "$(curl -sSL https://resource.fit2cloud.com/1panel/package/v2/quick_start.sh)"


nodejs

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
source ~/.bashrc
nvm --version

nvm install 22
nvm use 22
node --version

npm install -g openclaw@latest
openclaw --version
openclaw onboard --install-daemon

选yes
QuickStart
Skip for now 跳过
All providers
默认
channel 跳过
配置skill，跳过
第一个选项是在 Gateway 启动时运行 BOOT.md，这个后期有需要自己加。
第二个是注入额外的工作区引导文件，后期再加。
第三个是把所有命令事件写到日志，这个必须开。
第四个保留对话上下文记忆，这个也要开（养龙虾）。
网关页面的打开方式，webui比较方便
随后在控制台日志中的复制整串url（带token）



第一个问题：systemd user service 未启用
先检查 service 状态：

systemctl --user is-enabled openclaw-gateway.service

输出：

disabled

启用 service：

systemctl --user enable openclaw-gateway.service
执行：

systemctl --user daemon-reload
systemctl --user restart openclaw-gateway

检查状态：

systemctl --user status openclaw-gateway

输出：

Active: active (running)
Main PID: node

说明服务已经正常运行。