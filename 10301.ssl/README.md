## 安装 Certbot
1、先安装 EPEL 仓库（因为 certbot 在这个源里，目前还没在默认的源里）

```
sudo yum install epel-release
```

2、安装 certbot
```
sudo yum install certbot
```

3、查看 certbot 版本，因为 ACME v2 要在 certbot 0.20.0 以后的版本支持。

```
certbot --version
```

输出：certbot 1.11.0

## 申请证书
申请命令如下

```
sudo certbot certonly -d test.yourdomain.com --manual --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory
```
主要参数说明：

- certonly 是 certbot 众多插件之一，您可以选择其他插件。
- -d 为那些主机申请证书，如果是通配符，输入 *.yourdomain.com。
- 注意：本文还申请了 yourdomain.com 这是为了避免通配符证书不匹配。
- –preferred-challenges dns，使用 DNS 方式校验域名所有权。
- 注意：通配符证书只能使用 dns-01 这种方式申请。

此时去 DNS 服务商那里，配置 _acme-challenge.yourdomain.com 类型为 TXT 的记录。在没有确认 TXT 记录生效之前不要回车执行。

## CMD 窗口，输入下列命令确认 TXT 记录是否生效：
```
nslookup -qt=txt _acme-challenge.test.gytlfc.com
```

```
服务器:  UnKnown
Address:  26.26.26.53

非权威应答:
_acme-challenge.test.gytlfc.com text =

        "mf8cT3Y-q1OEeYxAncQVmvXXRyArGKTJ3JRAziaBwI4"
```

## 证书存储路径：
```
cd /etc/letsencrypt/live
```

证书文件
```
ssl_certificate   /etc/letsencrypt/live/www.domain.com/fullchain.pem;
ssl_certificate_key  /etc/letsencrypt/live/www.domain.com/privkey.pem;
```

