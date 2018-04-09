#!/bin/bash
export CONFIG_TX_PATH=`pwd`
export CORE_LOGGING_LEVEL=DEBUG
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_GOSSIP_USELEADERELECTION=true
export CORE_PEER_GOSSIP_ORGLEADER=false
export CORE_PEER_PROFILE_ENABLED=true
export CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock

