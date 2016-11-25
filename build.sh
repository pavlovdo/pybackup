#!/bin/bash

PROJECT=`basename $WORKSPACE`
PRODUCTION_SERVER=backup3.forum.lo
PRODUCTION_DIR=/usr/local/orbit

sudo docker build -t ubuntu:$PROJECT .
sudo docker save -o ubuntu-$PROJECT-$BUILD_NUMBER.img ubuntu:$PROJECT
sudo chown jenkins:jenkins ubuntu-$PROJECT-$BUILD_NUMBER.img
ssh jenkins@$PRODUCTION_SERVER "sudo [ -d $PRODUCTION_DIR/$PROJECT/data ] || sudo mkdir -pv $PRODUCTION_DIR/$PROJECT/data"
ssh jenkins@$PRODUCTION_SERVER "sudo chown -vR jenkins:jenkins $PRODUCTION_DIR"
scp ubuntu-$PROJECT-$BUILD_NUMBER.img jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/docker-ubuntu-$PROJECT.img
scp dockercheck.sh jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/dockercheck.sh
scp outputsend.sh jenkins@$PRODUCTION_SERVER:$PRODUCTION_DIR/$PROJECT/outputsend.sh
ssh jenkins@$PRODUCTION_SERVER "chmod -v u+x $PRODUCTION_DIR/$PROJECT/dockercheck.sh"
ssh jenkins@$PRODUCTION_SERVER "chmod -v u+x $PRODUCTION_DIR/$PROJECT/outputsend.sh"
ssh jenkins@$PRODUCTION_SERVER "echo '*/5 * * * *	$PRODUCTION_DIR/$PROJECT/dockercheck.sh' > /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "echo '0 */1 * * *       $PRODUCTION_DIR/$PROJECT/outputsend.sh' >> /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "crontab /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "rm /tmp/crontab"
ssh jenkins@$PRODUCTION_SERVER "touch $PRODUCTION_DIR/$PROJECT/$PROJECT.docker.newimage"
