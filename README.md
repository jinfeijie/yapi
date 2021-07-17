1⃣️ ⚠️⚠️[YAPI 0Day](https://s.tencent.com/research/report/76)，各位注意检查服务器。官方暂无更新npm最新包，临时解决方案查看下文⚠️⚠️
<details>
<summary>⚠️⚠️⚠️临时处置方案，点击这里⚠️⚠️⚠️</summary>
<pre><code>
1、关闭YAPI用户注册功能

在 config.json 中添加以下配置项，禁止用户注册或启用LDAP认证：
```
{

  "closeRegister":true 

}
```
修改完成后，重启 YAPI 服务生效。

2、关闭YAPI Mock功能

1)、在config.json中新增mock: false参数：
```
{ ... "mock": false, }
```

2)、在`exts/yapi-plugin-andvanced-mock/server.js`文件中找到：

```
if (caseData && caseData.case_enable) {...}`
```

并添加下列代码：
```
if(!yapi.WEBCONFIG.mock) { return false; }
```
3、对高级Mock功能进行关键字过滤

在`/server/utils/commons.js`文件中找到：
```
sandbox = yapi.commons.sandbox(sandbox, script);
```
并添加下列代码：
```
const filter = '/process|exec|require/g'; const reg = new RegExp(filter, "g"); if(reg.test(script)) { return false; }
```
4、对YAPI平台的访问进行限制

5、修改管理员默认账号口令，清除弱口令。

</code></pre>
</details>

<br/>
<br/>
<br/>




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
| VERSION | 1.5.6  | 可以修改成yapi已发布的版本   |
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
      - VERSION=1.5.6
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
