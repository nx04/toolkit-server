## 先在 PowerShell 执行：

wsl --update

wsl --status

wsl --version

wsl --set-default-version 2

wsl --list --verbose

wsl --install Ubuntu-22.04

wsl --set-default Ubuntu-22.04

## 更新软件
sudo apt update && sudo apt upgrade -y

sudo apt install -y build-essential curl git unzip zip ca-certificates jq

## 其他
额外安装 1Panel（解决 docker 环境问题）

sudo bash -c "$(curl -sSL https://resource.fit2cloud.com/1panel/package/v2/quick_start.sh)"


## 安装 nodejs

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

source ~/.bashrc
或者
source ~/.profile

nvm --version

nvm install 22

nvm use 22

node --version

npm install -g openclaw@latest
npm install -g clawhub
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


## 查看已启动 openclaw token
openclaw dashboard --no-open

## 重启 Gateway 服务使配置生效
openclaw gateway restart

## 查看 openclaw 状态 
openclaw status

##  重启 Gateway 服务
openclaw gateway stop
openclaw gateway


## 肖念部署问题解决
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



## 配置 deepseek

openclaw config set models.providers.deepseek '{
  "baseUrl": "https://api.deepseek.com/v1",
  "apiKey": "sk-55f2c00c3a364ac9b8076b848e44adf4",
  "api": "openai-completions",
  "models": [
    {
      "id": "deepseek-chat",
      "name": "DeepSeek Chat (V3)"
    },
    {
      "id": "deepseek-reasoner",
      "name": "DeepSeek Reasoner (R1)"
    }
  ]
}'

## 设置默认交互模型
openclaw config set agents.defaults.model.primary "deepseek/deepseek-chat"

## 创建模型别名（可选）
openclaw models aliases add deepseek-v3 "deepseek/deepseek-chat"
openclaw models aliases add deepseek-r1 "deepseek/deepseek-reasoner"

## 命令行快速测试
openclaw agent --session-id test --message "你好，请介绍一下你自己"

## 查看模型配置状态
openclaw models status




## 安装飞书 
openclaw plugins install @m1heng-clawd/feishu

## 交互式添加飞书渠道
openclaw channels add

提示「Configure chat channels now?」，选择「Yes」；

渠道列表中，选择「Feishu/Lark (飞书)(needs app creds)」；

输入步骤 4.3 获取的「Feishu App ID」和「Feishu App Secret」；

飞书域名选择：「Feishu (feishu.cn) - China」（国内版飞书）；

群聊策略选择：根据需求选择（推荐测试阶段选「Disabled - don\&#39;t respond in groups」，仅开启单聊）；

后续提示「Configure DM access policies now?」「Add display names for these accounts?」，均选择「No」（后续按需配置）；

最后选择「Finished (Done)」，完成飞书渠道添加。


## 技能安装
腾讯 
https://skillhub.tencent.com/#about
curl -fsSL https://skillhub-1388575217.cos.ap-guangzhou.myqcloud.com/install/install.sh | bash  -s -- --no-skills


skill-vetter
Tavily 搜索
self-improving-agent
proactive-agent
find-skills
summarize
gog
agent-browser
github
ontology
nano-pdf
multi-search-engine
n8n-workflow-automation
notion
nano-banana-pro
baidu-search
humanizer
