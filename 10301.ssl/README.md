# Certbot

Certbot 是一个免费、开源的软件工具，用于从 Let’s Encrypt 等证书颁发机构获取和自动更新 SSL/TLS 证书。

## Certbot 实现颁发证书的原理

### 生成密钥对和 CSR（证书签名请求）：

1、Certbot 首先在服务器上生成一个密钥对，包括私钥和公钥。私钥将被严格保密，存放在服务器上，用于对数据进行加密和解密。公钥则包含在 CSR 中。

2、CSR 是一个包含服务器信息（如域名、组织名称等）的文件，它是向证书颁发机构申请证书的请求。Certbot 会根据服务器的配置和用户提供的信息生成 CSR。

### 验证域名所有权：

证书颁发机构需要确保申请证书的人拥有该域名的所有权。Certbot 会通过多种方式来验证域名所有权，常见的方法有：
- HTTP 验证：Certbot 在服务器上放置一个特定的文件，证书颁发机构会通过访问该文件来验证服务器是否对该域名有控制权。
- DNS 验证：在域名的 DNS 记录中添加特定的 TXT 记录，证书颁发机构通过查询 DNS 记录来验证所有权。

### 提交 CSR 并获取证书：

1、一旦域名所有权验证通过，Certbot 会将 CSR 提交给证书颁发机构，如 Let’s Encrypt。

2、证书颁发机构会对 CSR 进行审核，如果一切符合要求，就会颁发一个数字证书。这个证书包含了服务器的公钥、域名信息、颁发机构的数字签名等。


## 安装 Certbot
1、先安装 EPEL 仓库（因为 certbot 在这个源里，目前还没在默认的源里）

```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum clean all
yum makecache
yum -y update
yum -y install epel-release
```

2、安装 certbot
```
yum -y install certbot
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

