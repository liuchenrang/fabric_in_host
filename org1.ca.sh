source base.sh
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
export FABRIC_CA_HOME=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/ca
CA1_PRIVATE_KEY=`ls -l $FABRIC_CA_HOME |grep sk|awk '{print $9}'`
export FABRIC_CA_SERVER_CA_NAME=ca-org1
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_ADDRESS=0.0.0.0
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_TLS_CERTFILE=$FABRIC_CA_HOME/ca.org1.example.com-cert.pem
export FABRIC_CA_SERVER_TLS_KEYFILE=$FABRIC_CA_HOME/$CA1_PRIVATE_KEY

fabric-ca-server start  -b admin:adminpw -d
