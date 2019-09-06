#! /bin/sh
cd ${VENDORS}
if [ ! -e "init.lock" ]
then
	sed -i "s/DIY-PORT/"${PORT}"/g" ${HOME}/config.json
	sed -i "s/DIY-AC/"${ADMIN_EMAIL}"/g" ${HOME}/config.json
	sed -i "s/DIY-DB-SERVER/"${DB_SERVER}"/g" ${HOME}/config.json
	sed -i "s/DIY-DB-NAME/"${DB_NAME}"/g" ${HOME}/config.json
	sed -i "s/DIY-DB-PORT/"${DB_PORT}"/g" ${HOME}/config.json
	mv ${HOME}/config.json ${VENDORS}
	cp ${VENDORS}/config.json ${HOME}
	cp ${VENDORS}/config.json ${HOME}/../
	# sed -i "s/DIY-PORT/3000/g" config.json
	# sed -i "s/DIY-AC/me@jinfeijie.cn/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-SERVER/mongo/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-NAME/yapi/g" ${VENDORS}/config.json
	# sed -i "s/DIY-DB-PORT/27017/g" ${VENDORS}/config.json
	# yapi install -v 1.5.6
	cd ${VENDORS}
	git fetch origin v${VERSION}:v${VERSION}
	git checkout v${VERSION}
	yapi install -v ${VERSION}
	touch init.lock
fi

cd ${VENDORS}
# 先判断有没有CMD指定路径
if [ $1 ]
then
	node $i
else
	node server/app.js
fi