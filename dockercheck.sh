#!/bin/bash

PROJECT=`basename \`dirname $0\``
PRODUCTION_DIR=/usr/local/orbit
HOST_MOUNT_DIR=/backup

if [ -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage ]
then
	PROJECTCONTAINERS=`sudo docker ps | grep $PROJECT | awk '{print substr($1,1)}'`
	echo 'Stopping containers '$PROJECTCONTAINERS ' of project '$PROJECT
	sudo docker stop $PROJECTCONTAINERS
	echo -e '\nLoading of new image ubuntu:'$PROJECT 'from '$PRODUCTION_DIR'/'$PROJECT'/docker-ubuntu-'$PROJECT'.img'
	sudo docker load -i $PRODUCTION_DIR/$PROJECT/docker-ubuntu-$PROJECT.img
	if $HOST_MOUNT_DIR
	then
		echo -e '\nRunning of container from image ubuntu:'$PROJECT' with mounting '$PRODUCTION_DIR'/'$PROJECT'/data:'$PRODUCTION_DIR'/'$PROJECT'/data and '$HOST_MOUNT_DIR':'$HOST_MOUNT_DIR
		sudo docker run -d -t -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data -v $HOST_MOUNT_DIR:$HOST_MOUNT_DIR ubuntu:$PROJECT
	else
		echo -e '\nRunning of container from image ubuntu:'$PROJECT' with mounting '$PRODUCTION_DIR'/'$PROJECT'/data:'$PRODUCTION_DIR'/'$PROJECT'/data'
		sudo docker run -d -t -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data ubuntu:$PROJECT
	fi
	rm -f $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage
fi
