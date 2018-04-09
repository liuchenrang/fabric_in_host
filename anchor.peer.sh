#!/bin/bash
source base.sh
CHANNEL_NAME=mychannel
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_TLS_ENABLED=true
ORDERER_CA=crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem 
export CORE_PEER_MSPCONFIGPATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
	