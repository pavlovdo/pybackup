#!/bin/bash

PROJECT=`basename $WORKSPACE`
PRODUCTION_SERVER=backup2.forum.lo
PRODUCTION_DIR=/usr/local/orbit

sudo docker build -t ubuntu:$PROJECT .
sudo docker save -o ubuntu-$PROJECT-$BUILD_NUMBER.img ubuntu:$PROJECT
sudo chown jenkins:jenkins ubuntu-$PROJECT-$BUILD_NUMBER.img
scp ubuntu-$PROJECT-$BUILD_NUMBER.img jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/docker-ubuntu-$PROJECT.img
scp dockercheck.sh jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/dockercheck.sh
scp outputsend.sh jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/outputsend.sh
ssh jenkins@$PRODUCTION_SERVER "chmod u+x $PRODUCTION_DIR/$PROJECT/dockercheck.sh"
ssh jenkins@$PRODUCTION_SERVER "chmod u+x $PRODUCTION_DIR/$PROJECT/outputsend.sh"
ssh jenkins@$PRODUCTION_SERVER "echo '*/5 * * * *	$PRODUCTION_DIR/$PROJECT/dockercheck.sh' > /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "echo '30 05 * * *       $PRODUCTION_DIR/$PROJECT/outputsend.sh' >> /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "crontab /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "rm /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "touch $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage"
