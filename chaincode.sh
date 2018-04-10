#!/bin/bash
# 将first-fabric 的 chaincode 拷贝到 $GOPATH/src 下
sh ./cli.sh  chaincode install -n fabcar -v 1.0 -p chaincode/fabcar

sh ./cli.sh chaincode instantiate --cafile crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem  --tls true  -o orderer.example.com:7050 -C mychannel -n fabcar -v 1.0 -c '{"Args":[""]}' 
# -P "OR ('Org1MSP.member','Org2MSP.member')"
# wait instantiate docker 
sleep 30 
sh ./cli.sh chaincode invoke -o orderer.example.com:7050 --cafile crypto-config/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem  --tls true  -C mychannel -n fabcar -c '{"function":"initLedger","Args":[""]}'

