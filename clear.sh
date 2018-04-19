#!/bin/bash
rm -rf /var/hyperledger/*
rm -f mychannel.block
rm -rf channel-artifacts/*
rm -rf crypto-config
docker stop $(docker ps -a |grep dev-peer|awk '{print $1}')
docker rm $(docker ps -a |grep dev-peer|awk '{print $1}')
docker rmi $(docker images|grep dev-peer|awk '{print $3}')
