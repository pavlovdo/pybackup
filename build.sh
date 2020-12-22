#!/bin/bash

readonly PROJECT=pybackup
readonly CONTAINER_OS=centos
readonly CONTAINER_OLD_ID=$(docker ps -q --filter ancestor="$CONTAINER_OS":"$PROJECT")

docker stop "$CONTAINER_OLD_ID"
docker build -t "$CONTAINER_OS":"$PROJECT" .
