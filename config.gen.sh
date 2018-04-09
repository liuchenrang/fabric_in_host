rm -rf channel-artifacts
rm -rf crypto-config
mkdir channel-artifacts
cryptogen generate --config=./crypto-config.yaml
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID  mychannel
configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
