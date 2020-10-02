#!/bin/bash

PROJECT=`basename $WORKSPACE`
PRODUCTION_SERVER=backup.example.com
PRODUCTION_DIR=/usr/local/orbit
CONTAINER_OS=centos
CONTAINER_OLD_ID=`ssh jenkins@$PRODUCTION_SERVER docker ps -q --filter ancestor=$CONTAINER_OS:$PROJECT`

ssh jenkins@$PRODUCTION_SERVER "sudo chown -R jenkins:jenkins $PRODUCTION_DIR"
ssh jenkins@$PRODUCTION_SERVER "[ -d $PRODUCTION_DIR/$PROJECT/data ] || mkdir -p $PRODUCTION_DIR/$PROJECT/data"
scp *.sh jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT
ssh jenkins@$PRODUCTION_SERVER "chmod -v u+x $PRODUCTION_DIR/$PROJECT/*.sh"
ssh jenkins@$PRODUCTION_SERVER "docker stop $CONTAINER_OLD_ID"
ssh jenkins@$PRODUCTION_SERVER "docker build -t centos:$PROJECT git@dev.example.com:it/$PROJECT.git"
ssh jenkins@$PRODUCTION_SERVER "$PRODUCTION_DIR/$PROJECT/dockerrun.sh"
ssh jenkins@$PRODUCTION_SERVER "echo '00 */1 * * *       $PRODUCTION_DIR/$PROJECT/outputsend.sh' >> /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "crontab /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "rm /tmp/crontab"
