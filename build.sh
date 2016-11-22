#!/bin/bash

sudo docker build -t ubuntu:pyconfigvc .
sudo docker save -o ubuntu-pyconfigvc-$BUILD_NUMBER.img ubuntu:pyconfigvc
sudo chown jenkins:jenkins ubuntu-pyconfigvc-$BUILD_NUMBER.img
scp ubuntu-pyconfigvc-$BUILD_NUMBER.img jenkins@eye.forum.lo:/usr/local/docker/ubuntu-pyconfigvc.img
ssh jenkins@eye.forum.lo 'touch /usr/local/docker/docker.newimage'
#ssh jenkins@eye.forum.lo 'sudo docker load -q -i ubuntu-pyconfigvc-$BUILD_NUMBER.img'
#ssh jenkins@eye.forum.lo 'sudo docker run -d -t -v /usr/local/orbit/pyconfigvc ubuntu:pyconfigvc'
