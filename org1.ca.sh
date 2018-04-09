source base.sh
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
export ORG1_CA_PATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/ca
CA1_PRIVATE_KEY=`ls -l $ORG1_CA_PATH |grep sk|awk '{print $9}'`
export FABRIC_CA_HOME=/etc/hyperledger/fabric-ca-server
export FABRIC_CA_SERVER_CA_NAME=ca-org1
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_TLS_CERTFILE=$ORG1_CA_PATH/ca.org1.example.com-cert.pem
export FABRIC_CA_SERVER_TLS_KEYFILE=$ORG1_CA_PATH/$CA1_PRIVATE_KEY

