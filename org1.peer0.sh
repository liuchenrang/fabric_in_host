#!/bin/bash
source base.sh
source org1.peer0.env.sh

peer node start -o orderer.example.com:7050
