#!/bin/bash 
nohup bash ./orderer.sh > /tmp/orderer.log

nohup bash ./org1.peer0.sh > /tmp/org1.peer0.log &
nohup bash ./org1.peer1.sh > /tmp/org1.peer1.log &
nohup bash ./org2.peer1.sh > /tmp/org2.peer1.log &
nohup bash ./org2.peer0.sh > /tmp/org2.peer0.log &
nohup bash ./org1.ca.sh > /tmp/org1.ca.log
