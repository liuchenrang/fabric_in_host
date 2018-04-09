source base.sh
source org1.peer1.env.sh

# echo $CORE_PEER_ADDRESS
peer node start -o orderer.example.com:7050
