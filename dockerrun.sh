#!/bin/bash

PROJECT=`basename \`dirname $0\``
PRODUCTION_DIR=/usr/local/orbit
CONFIG_DIR=/etc/orbit/$PROJECT
CONTAINER_OS=centos
HOST_MOUNT_DIR=

if [ -z $HOST_MOUNT_DIR ]
    then
        echo -e '\nRunning of container from image '$CONTAINER_OS':'$PROJECT' with mounting '$PRODUCTION_DIR'/'$PROJECT'/data:'$PRODUCTION_DIR'/'$PROJECT'/data and '$CONFIG_DIR':'$CONFIG_DIR':ro'
        sudo docker run -d -t --restart=always -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data -v $CONFIG_DIR:$CONFIG_DIR:ro $CONTAINER_OS:$PROJECT
    else
        echo -e '\nRunning of container from image '$CONTAINER_OS':'$PROJECT' with mounting '$PRODUCTION_DIR'/'$PROJECT'/data:'$PRODUCTION_DIR'/'$PROJECT'/data and '$HOST_MOUNT_DIR':'$HOST_MOUNT_DIR 'and '$CONFIG_DIR':'$CONFIG_DIR':ro'
        sudo docker run -d -t --restart=always -v $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data -v $HOST_MOUNT_DIR:$HOST_MOUNT_DIR -v $CONFIG_DIR:$CONFIG_DIR:ro $CONTAONER_OS:$PROJECT
fi
