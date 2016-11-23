#!/bin/bash

PROJECT=`basename \`dirname $0\``
PRODUCTION_DIR=/usr/local/orbit

if [ -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage ]
then
	sudo docker stop $(sudo docker ps | grep $PROJECT | awk '{print substr($1,1)}')	
	sudo docker load -i $PRODUCTION_DIR/$PROJECT/docker-ubuntu-$PROJECT.img
	sudo docker run -d -t -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data ubuntu:$PROJECT
	rm -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage
fi
