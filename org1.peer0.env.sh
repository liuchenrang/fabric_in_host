#!/bin/bash
source base.sh
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
BASE_PATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com
export FABRIC_CFG_PATH=$BASE_PATH
sed -i "" "s/fileSystemPath:.*/fileSystemPath: \/var\/hyperledger\/org1.0\/production/" core.yaml
cp core.yaml $FABRIC_CFG_PATH
export CORE_PEER_TLS_CERT_FILE=$FABRIC_CFG_PATH/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=$FABRIC_CFG_PATH/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=$FABRIC_CFG_PATH/tls/ca.crt
#CORE_PEER_MSPCONFIGPATH 操作身份
export CORE_PEER_ID=peer0.org1.example.com
export CORE_PEER_ADDRESS=peer0.org1.example.com:7051
export CORE_PEER_LISTENADDRESS=peer0.org1.example.com:7051

export CORE_PEER_EVENTS_ADDRESS=peer0.org1.example.com:7053
export CORE_PEER_CHAINCODELISTENADDRESS=peer0.org1.example.com:7054
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.example.com:7051
export CORE_PEER_GOSSIP_BOOTSTRAP=peer0.org1.example.com:7051
export CORE_PEER_LOCALMSPID=Org1MSP