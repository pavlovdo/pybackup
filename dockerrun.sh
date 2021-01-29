#!/bin/bash

readonly PROJECT=pybackup
readonly CONFIG_DIR=/usr/local/orbit/$PROJECT/conf.d

message="\nRunning of container from image $CONTAINER_OS:$PROJECT with name $PROJECT and mounting volumes $CONFIG_DIR':'$CONFIG_DIR':ro and $PRODUCTION_DIR/$PROJECT/data:$PRODUCTION_DIR/$PROJECT/data"

docker run --detach --tty --name "$PROJECT" --restart=always --volume "$CONFIG_DIR":"$CONFIG_DIR":ro \
 --volume "$PRODUCTION_DIR"/"$PROJECT"/data:"$PRODUCTION_DIR"/"$PROJECT"/data "$CONTAINER_OS":"$PROJECT"

echo -e "${message}"
