# nginx php fpm 搭建网站

## 编辑

```
cp php-fpm.conf.default php-fpm.conf
vi etc/php-fpm.conf
```

## 啓動

/usr/local/php-release/sbin/php-fpm


ps aux|grep php-fpm


root     11667  0.0  0.1 138364  7384 ?        Ss   16:03   0:00 php-fpm: master process (/usr/local/php-release/etc/php-fpm.conf)
www-data 11668  0.0  0.2 140448  9604 ?        S    16:03   0:00 php-fpm: pool www
www-data 11669  0.0  0.2 140448  9604 ?        S    16:03   0:00 php-fpm: pool www
root     23916  0.0  0.0 112668   964 pts/0    R+   16:21   0:00 grep --color=auto php-fpm

重启php-fpm:

kill -USR2 11667