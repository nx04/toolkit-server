# nodejs

## 官网地址

[http://nodejs.cn/](http://nodejs.cn/)

## 简介

Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行时。


wget https://npm.taobao.org/mirrors/node/v10.8.0/node-v10.8.0-linux-x64.tar.xz

xz -d node-v10.8.0-linux-x64.tar.xz
tar xvf node-v10.8.0-linux-x64.tar

mv node-v10.8.0-linux-x64 /usr/local/nodejs/bin/node
ln -s /usr/local/nodejs/bin/node /usr/node
ln -s /usr/local/nodejs/bin/npm /usr/npm
npm config set registry https://registry.npm.taobao.org
npm install -g pm2
ln -s /usr/local/nodejs/bin/pm2 /usr/pm2

node index.js
pm2 start index.js