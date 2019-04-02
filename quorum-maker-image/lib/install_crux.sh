#!/bin/bash

source qm.variables
source lib/common.sh 

echo $CYAN"Building Crux, "$crux_version"..."$COLOR_END

rm -rf crux

docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git alpine/git clone https://github.com/denny60004/crux.git
docker run -ti --rm -v ${HOME}:/root -v $(pwd):/git -w /git/crux alpine/git checkout Develop/SyncMap
docker run -it --rm -v $(pwd)/crux:/crux -w /crux golang:1.11.6 make setup
docker run -it --rm -v $(pwd)/crux:/crux -w /crux golang:1.11.6 make

## Change the owneship of crux directory
chownDir 'crux'

echo $CYAN"Building Crux, "$crux_version" Completed."$COLOR_END
