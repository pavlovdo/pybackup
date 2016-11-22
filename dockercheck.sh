#!/bin/bash

PROJECT=`basename \`pwd\``
DOCKERDIR=/usr/local/orbit/docker

if [ -f $DOCKERDIR/$PROJECT.newimage ]
then
	docker stop $(docker ps | grep $PROJECT | awk '{print substr($1,1)}')	
	docker load -i $DOCKERDIR/ubuntu-$PROJECT.img
	docker run -d -t -v /usr/local/orbit/$PROJECT/data:/usr/local/orbit/$PROJECT/data ubuntu:$PROJECT
	rm -f $DOCKERDIR/$PROJECT.newimage
fi
