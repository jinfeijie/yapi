FROM node:10.22.0-jessie
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

RUN sed -i "s/3000/"${PORT}"/g" ${HOME}/config.json && \
	sed -i "s/admin@admin.com/"${ADMIN_EMAIL}"/g" ${HOME}/config.json && \
	sed -i "s/mongo/"${DB_SERVER}"/g" ${HOME}/config.json && \
	sed -i "s/yapi/"${DB_NAME}"/g" ${HOME}/config.json && \
	sed -i "s/27017/"${DB_PORT}"/g" ${HOME}/config.json && \
	npm config set registry https://registry.npmmirror.com && \
	npm install -g yapi-cli && \
	npm cache clean --force

EXPOSE ${PORT}
ENTRYPOINT ["entrypoint.sh"]
