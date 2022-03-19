#! /bin/sh
if [ ! -e "init.lock" ]
then
	yapi install -v ${VERSION}
	touch init.lock
fi

cd ${HOME}

node vendors/server/app.js