source base.sh
# the following setting starts chaincode containers on the same
# bridge network as the peers
# https://docs.docker.com/compose/networking/
export CONFIG_TX_PATH=`pwd`

export FABRIC_CA_HOME=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/ca
CA1_PRIVATE_KEY=`ls -l $FABRIC_CA_HOME |grep sk|awk '{print $9}'`

export FABRIC_CA_SERVER_CA_NAME=ca.org1.example.com
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_ADDRESS=0.0.0.0
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_DEBUG=true
export FABRIC_CA_SERVER_TLS_CERTFILE=$FABRIC_CA_HOME/ca.org1.example.com-cert.pem
export FABRIC_CA_SERVER_TLS_KEYFILE=$FABRIC_CA_HOME/$CA1_PRIVATE_KEY
# export FABRIC_CA_SERVER_DB_TYPE=mysql
# export FABRIC_CA_SERVER_DB_DATASOURCE=manager:managermanager@tcp\(localhost:3306\)/fabricca?parseTime=true

# export FABRIC_CA_SERVER_DB_TYPE=postgres
# export FABRIC_CA_SERVER_DB_DATASOURCE=dbname=fabric_ca_server localhost port=5432 user=xinghuo password=1 sslmode=disable

echo $FABRIC_CA_SERVER_TLS_KEYFILE
# fabric-ca-server $@
# rm -f $FABRIC_CA_HOME/fabric-ca-server.db
# echo  "$FABRIC_CA_HOME/fabric-ca-server-config.yaml"
fabric-ca-server   start  --ca.certfile  $FABRIC_CA_SERVER_TLS_CERTFILE --ca.keyfile $FABRIC_CA_SERVER_TLS_KEYFILE -b admin:adminpw -d
# ls $FABRIC_CA_HOME/ca.org1.example.com-cert.pem
