# Nginx 的使用

## 简介

Nginx 是一款轻量级的 Web 服务器/反向代理服务器及电子邮件（ IMAP / POP3 ）代理服务器，在 BSD-like 协议下发行。其特点是占有内存少，并发能力强，事实上 Nginx 的并发能力在同类型的网页服务器中表现较好，中国大陆使用 Nginx 网站用户有：百度、京东、新浪、网易、腾讯、淘宝等。

Nginx 是一个很强大的高性能Web和反向代理服务，它具有很多非常优越的特性：

在连接高并发的情况下， Nginx 是 Apache 服务不错的替代品：能够支持高达 50,000 个并发连接数的响应，感谢 Nginx 为我们选择了 epoll and kqueue 作为开发模型。

## 安装模块依赖性

- gzip 模块需要 zlib 库
- rewrite 模块需要 pcre 库
- ssl 功能需要 openssl 库

> Nginx 在一些 Linux 发行版和 BSD 的各个变种版本的安装包仓库中都会有，通过各个系统自带的软件包管理方法即可安装。需要注意的是，很多预先编译好的安装包都比较陈旧，大多数情况下还是推荐直接从源码编译。

**pcre**

PCRE(Perl Compatible Regular Expressions)是一个Perl库，包括 perl 兼容的正则表达式库。 

nginx的http模块使用pcre来解析正则表达式，所以需要在linux上安装pcre库。 

注：pcre-devel是使用pcre开发的一个二次开发库。nginx也需要此库。

**zlib**

zlib库提供了很多种压缩和解压缩的方式，nginx使用zlib对http包的内容进行gzip，所以需要在linux上安装zlib库。

**openssl**

OpenSSL 是一个强大的安全套接字层密码库，囊括主要的密码算法、常用的密钥和证书封装管理功能及SSL协议，并提供丰富的应用程序供测试或其它目的使用。

nginx不仅支持http协议，还支持https（即在ssl协议上传输http），所以需要在linux安装openssl库。

## 其他问题

Nginx 实现资源压缩的原理是通过 ngx_http_gzip_module 模块拦截请求，并对需要做 gzip 的类型做 gzip，ngx_http_gzip_module 是 Nginx 默认集成的，不需要重新编译，直接开启即可。

