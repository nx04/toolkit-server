yum install nginx

wget http://nginx.org/download/nginx-1.18.0.tar.gz -o nginx.tar.gz
tar -zxvf nginx.tar.gz
cd nginx
./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module
make
make install
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

# 启动命令
cd /usr/local/nginx/sbin
# 配置文件
cd /usr/local/nginx/conf
cd /usr/local/nginx && mkdir conf.d

# 问题1
# ./configure: error: the HTTP rewrite module requires the PCRE library.
# yum install pcre-devel

# 问题2
# ./configure: error: SSL modules require the OpenSSL library.
# yum install openssl-devel

# 列出所有端口
netstat -ntlp

# 列出80端口
lsof -i tcp:80