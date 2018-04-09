#!/bin/bash
source org1.peer0.env.sh
export CORE_PEER_MSPCONFIGPATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer channel create -c mychannel -f channel-artifacts/channel.tx --cafile ./crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem -o orderer.example.com:7050 --tls true

