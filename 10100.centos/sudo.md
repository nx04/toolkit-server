# sudo

$su -
(注意有- ，这和su是不同的，在用命令"su"的时候只是切换到root，但没有把root的环境变量传过去，还是当前用户的环境变量，用"su -"命令将环境变量也一起带过去，就象和root登录一样)

然后执行：
$  visudo     //切记，此处没有vi和sudo之间没有空格

也可以添加/etc/sudoers文件拥有写的权限，再编辑该文件（注意编辑完再恢复为只读权限）：

chmod u+w /etc/sudoers

vi /etc/sudoers



进入编辑/etc/sudoers:
root ALL=(ALL) ALL 的一行下面追加一行：
your_user_name ALL=(ALL)  ALL
xiaonian ALL=(ALL)  ALL
回到命令模式，用wq保存退出。


这样就把自己加入了sudo组，可以使用sudo命令了。


## 设置sudo/su无需输入密码
vi /etc/sudoers
改成免密码 NOPASSWD
your_user_name ALL=(ALL) NOPASSWD: ALL