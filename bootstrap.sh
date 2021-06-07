#!/bin/ash
DIR="/root/.ethereum/"

if [ "$NETWORK" == "mainnet" ]; then
    cp /conf_bsc/mainnet/genesis.json /genesis.json
    cp /conf_bsc/mainnet/config.toml /config.toml
else
    cp /conf_bsc/testnet/genesis.json /genesis.json
    cp /conf_bsc/testnet/config.toml /config.toml
fi

if [ "$(ls -A $DIR)" ]; then
     echo "Take action $DIR is not Empty"
else
    echo "$DIR is Empty"
    bsc --datadir /root/.ethereum/ init genesis.json
fi

if [ "$NETWORK" == "mainnet" ]; then
    bsc --config /config.toml --datadir /root/.ethereum \
    --syncmode fast --cache "10000" --maxpeers "50" \
    --snapshot=false --txlookuplimit=0 \
    --rpc --rpcaddr "0.0.0.0" --http --http.port 8575 --http.addr "0.0.0.0"
else
    bsc --config /config.toml --datadir /root/.ethereum \
    --syncmode full --gcmode archive --cache "14000" --maxpeers "200" \
    --snapshot=false \
    --rpc --rpcport "8575" --rpcaddr "0.0.0.0" --rpccorsdomain "*" \
    --rpcapi="admin,db,debug,eth,miner,net,personal,txpool,web3,personal,shh"
fi