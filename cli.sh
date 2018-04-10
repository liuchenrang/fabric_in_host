#!/bin/bash
source base.sh
source org1.peer0.env.sh
#CORE_PEER_MSPCONFIGPATH 操作身份	
export CORE_PEER_MSPCONFIGPATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
peer $@
