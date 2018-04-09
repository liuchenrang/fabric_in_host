#!/bin/bash
source base.sh
export ORDERER_GENERAL_LOGLEVEL=debug
export ORDERER_GENERAL_LISTENADDRESS=0.0.0.0
export ORDERER_GENERAL_GENESISMETHOD=file
export ORDERER_GENERAL_GENESISFILE=$CONFIG_TX_PATH/channel-artifacts/genesis.block
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=$CONFIG_TX_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp
# enabled TLS
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_TLS_PRIVATEKEY=$CONFIG_TX_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
export ORDERER_GENERAL_TLS_CERTIFICATE=$CONFIG_TX_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_GENERAL_TLS_ROOTCAS=[$CONFIG_TX_PATH/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]
echo $CONFIG_TX_PATH
orderer
