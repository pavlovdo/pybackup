#!/bin/bash

PROJECT=`basename \`dirname $0\``
PRODUCTION_DIR=/usr/local/orbit
HOST_MOUNT_DIR=/backup

if [ -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage ]
then
	sudo docker stop $(sudo docker ps | grep $PROJECT | awk '{print substr($1,1)}')	
	sudo docker load -i $PRODUCTION_DIR/$PROJECT/docker-ubuntu-$PROJECT.img
	if $HOST_MOUNT_DIR
		sudo docker run -d -t -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data ubuntu:$PROJECT -v $HOST_MOUNT_DIR:$HOST_MOUNT_DIR
	else
		sudo docker run -d -t -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data ubuntu:$PROJECT
	rm -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage
fi
