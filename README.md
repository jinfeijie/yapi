<h2 align="center">Docker for YApi</h2>
<p align="center">一键部署YApi</p>

<p align="center">
<a href="https://travis-ci.org/jinfeijie/yapi"><img src="https://travis-ci.org/jinfeijie/yapi.svg?branch=master" alt="Build Status"></a>
<a href="https://cloud.docker.com/u/mrjin/repository/docker/mrjin/yapi"><img src="https://img.shields.io/docker/automated/mrjin/yapi.svg?style=flat-square" alt=""></a>
<a href="https://github.com/jinfeijie/yapi"><img src="https://img.shields.io/github/license/jinfeijie/yapi.svg?style=flat-square" alt="License"></a>
</p>

## ⚠️注意
⚠️注意：本仓库目前只支持安装，暂不支持升级，请知晓。如需升级请备份mongoDB内的数据。

## 使用
默认密码是：`ymfe.org`，安装成功后进入后台修改

## 可修改变量
| 环境变量       | 默认值         | 建议         |
| ------------- |:-------------:|:-----------:|
| VERSION | 1.10.2  | *强烈建议升级*   |
| HOME | /home | 可修改 |  
| PORT | 3000  | 可修改 | 
| ADMIN_EMAIL | test@test.com  | 建议修改 | 
| DB_SERVER | mongo(127.0.0.1)  | 不建议修改 |
| DB_NAME | yapi  | 不建议修改 |
| DB_PORT | 27017 | 不建议修改|
| VENDORS | ${HOME}/vendors | 不建议修改  | 


## 获取本镜像
🚘获取本镜像：`docker pull mrjin/yapi:latest`

## docker-compose 部署
```
version: '2.1'
services:
  yapi:
    image: mrjin/yapi:latest
    # build: ./
    container_name: yapi
    environment:
      - VERSION=1.10.2
      - LOG_PATH=/tmp/yapi.log
      - HOME=/home
      - PORT=3000
      - ADMIN_EMAIL=test@test.com
      - DB_SERVER=mongo
      - DB_NAME=yapi
      - DB_PORT=27017
    # restart: always
    ports:
      - 127.0.0.1:3000:3000
    volumes:
      - ~/data/yapi/log/yapi.log:/home/vendors/log # log dir
    depends_on:
      - mongo
    entrypoint: "bash /wait-for-it.sh mongo:27017 -- entrypoint.sh"
    networks:
      - back-net
  mongo:
    image: mongo
    container_name: mongo
    # restart: always
    ports:
      - 127.0.0.1:27017:27017
    volumes:
      - ~/data/yapi/mongodb:/data/db #db dir
    networks:
      - back-net
networks:
  back-net:
    external: true
```

## Nginx 配置
```
server {
    listen     80;
    server_name your.domain;
    keepalive_timeout   70;

    location / {
        proxy_pass http://yapi:3000;
    }
    location ~ /\. {
        deny all;
    }
}
```

## 启动方法

1. 修改`docker-compose.yml`文件里面相关参数

2. 创建network：`docker network create back-net`

3. 启动服务：`docker-compose up -d`

✨欢迎 Star && Fork
