#!/bin/bash

function main(){
    
    nodeName=$(basename `pwd`)

    publickey=$(cat node/qdata/keys/$nodeName.pub)
         
    cd node
    ./start_$nodeName.sh
    while true
    do
        sleep 1
    done
}
main
