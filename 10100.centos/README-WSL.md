# WSL 安装

wsl --install

下载

https://github.com/mishamosher/CentOS-WSL

从GitHub下载CentOS7.zip或类似文件，解压后得到CentOS7.exe（启动器）和根文件系统。

wsl --import CentOS7 C:\WSL\CentOS7 C:\WSL\CentOS7\rootfs --version 2

首次运行需指定root密码：

sudo passwd root

创建普通用户：

sudo adduser <用户名>
sudo passwd <用户名>
sudo usermod -aG wheel <用户名>  # 授予sudo权限


列出已安装发行版：

列出已安装发行版：
wsl -l -v

启动CentOS：
wsl -d CentOS7


YUM源报错（连接失败）

sudo rm /etc/yum.repos.d/CentOS-*.repo
sudo curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
sudo yum clean all && sudo yum makecache

SSH服务无法启动 安装并配置OpenSSH：
sudo yum install openssh-server -y
sudo systemctl start sshd
sudo vim /etc/ssh/sshd_config  # 修改PermitRootLogin为yes
sudo systemctl restart sshd

