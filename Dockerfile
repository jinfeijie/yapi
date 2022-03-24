FROM node:12.22.11-stretch
MAINTAINER mrjin<me@jinfeijie.cn>
ENV VERSION 	1.10.2
ENV HOME        "/home"
ENV PORT        3000
ENV ADMIN_EMAIL "me@jinfeijie.cn"
ENV DB_SERVER 	"mongo"
ENV DB_NAME 	"yapi"
ENV DB_PORT 	27017

WORKDIR ${HOME}/

COPY entrypoint.sh /bin
COPY config.json ${HOME}
COPY wait-for-it.sh /

RUN npm config set registry https://registry.npmmirror.com && \
	npm install -g yapi-cli && \
	npm cache clean --force

EXPOSE ${PORT}
ENTRYPOINT ["entrypoint.sh"]
