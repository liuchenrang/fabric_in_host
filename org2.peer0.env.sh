#!/bin/bash
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
export BASE_PATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com
export FABRIC_CFG_PATH=$BASE_PATH
sed -i "" "s/fileSystemPath:.*/fileSystemPath: \/var\/hyperledger\/org2.0\/production/" core.yaml
cp core.yaml $FABRIC_CFG_PATH

export CORE_PEER_TLS_CERT_FILE=$FABRIC_CFG_PATH/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=$FABRIC_CFG_PATH/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=$FABRIC_CFG_PATH/tls/ca.crt
export CORE_PEER_ID=peer0.org2.example.com
export CORE_PEER_ADDRESS=peer0.org2.example.com:9051
export CORE_PEER_LISTENADDRESS=0.0.0.0:9051
export CORE_PEER_EVENTS_ADDRESS=peer0.org2.example.com:9053
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=peer0.org1.example.com:7051
export CORE_PEER_LOCALMSPID=Org2MSP
