#!/bin/bash

source qm.variables
source lib/common.sh

# Build Quorum Crux image
dockername=$quorumImage
echo $CYAN"Building image, "$dockername"..."$COLOR_END

docker build --no-cache -f Dockerfile_Quorum_Crux -t $dockername .

# Build node manager image
dockername=$nodeManagerImage
echo $CYAN"Building image, "$dockername"..."$COLOR_END

docker build --no-cache -f Dockerfile_NodeManager -t $dockername .
