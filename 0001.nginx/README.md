# Nginx

Nginx 是一款轻量级的 Web 服务器/反向代理服务器及电子邮件（ IMAP / POP3 ）代理服务器，在 BSD-like 协议下发行。其特点是占有内存少，并发能力强，事实上nginx的并发能力在同类型的网页服务器中表现较好，中国大陆使用 nginx 网站用户有：百度、京东、新浪、网易、腾讯、淘宝等。

Nginx 是一个很强大的高性能Web和反向代理服务，它具有很多非常优越的特性：

在连接高并发的情况下， Nginx 是 Apache 服务不错的替代品：能够支持高达 50,000 个并发连接数的响应，感谢 Nginx 为我们选择了 epoll and kqueue 作为开发模型。

## 安装

### 模块依赖性

gzip 模块需要 zlib 库

rewrite 模块需要 pcre 库

ssl 功能需要 openssl 库

Nginx 在一些 Linux 发行版和 BSD 的各个变种版本的安装包仓库中都会有，通过各个系统自带的软件包管理方法即可安装。需要注意的是，很多预先编译好的安装包都比较陈旧，大多数情况下还是推荐直接从源码编译。


## 其他问题

Nginx 实现资源压缩的原理是通过 ngx_http_gzip_module 模块拦截请求，并对需要做 gzip 的类型做 gzip， ngx_http_gzip_module 是 Nginx 默认集成的，不需要重新编译，直接开启即可。




