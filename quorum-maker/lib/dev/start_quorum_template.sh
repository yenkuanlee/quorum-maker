#!/bin/bash

function upcheck() {
    DOWN=true
    k=10
    while ${DOWN}; do
        sleep 1
        DOWN=false
        
        if [ ! -S "qdata/#mNode#.ipc" ]; then
            echo "Node is not yet listening on #mNode#.ipc" >> qdata/gethLogs/#mNode#.log
            DOWN=true
        fi

    #     result=$(curl -s http://$CURRENT_NODE_IP:22002/upcheck)

    #     if [ ! "${result}" == "I'm up!" ]; then
    #         echo "Node is not yet listening on http" >> qdata/gethLogs/#mNode#.log
    #         DOWN=true
    #     fi
    
        k=$((k - 1))
        if [ ${k} -le 0 ]; then
            echo "Crux is taking a long time to start.  Look at the Crux logs for help diagnosing the problem." >> qdata/gethLogs/#mNode#.log
        fi
       
        sleep 5
    done
}

NETID=#network_Id_value#
R_PORT=22000
W_PORT=22001
NODE_MANAGER_PORT=22004
CURRENT_NODE_IP=#node_ip#
ENODE_IP=#enode_ip#


ENABLED_API="admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum,clique"
GLOBAL_ARGS="--bootnodes $ENODE_IP --gcmode=archive --networkid $NETID --rpc --rpcaddr 0.0.0.0 --rpcapi $ENABLED_API --emitcheckpoints --syncmode full --mine --minerthreads 1 --unlock 0 --password passwords.txt"

rm -f qdata/*lock.db

echo "[*] Starting Constellation node" > qdata/constellationLogs/crux_#mNode#.log

crux #mNode#.conf >> qdata/constellationLogs/crux_#mNode#.log 2>&1 &

upcheck

echo "[*] Starting #mNode# node" >> qdata/gethLogs/#mNode#.log

echo "[*] Waiting for Crux to start..." >> qdata/gethLogs/#mNode#.log

upcheck

echo "[*] Starting #mNode# node" >> qdata/gethLogs/#mNode#.log
echo "[*] geth --verbosity 6 --datadir qdata" $GLOBAL_ARGS" --rpcport "$R_PORT "--port "$W_PORT "--nat extip:"$CURRENT_NODE_IP>> qdata/gethLogs/#mNode#.log

PRIVATE_CONFIG=qdata/#mNode#.ipc geth --verbosity 6 --datadir qdata $GLOBAL_ARGS --rpccorsdomain "*" --rpcport $R_PORT --port $W_PORT --nat extip:$CURRENT_NODE_IP 2>>qdata/gethLogs/#mNode#.log &

