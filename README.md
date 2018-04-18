# fabric_in_host
./config.gen.sh
./orderer.sh
./peer*.sh
./create.channel.sh
./join.sh
./chaincode.sh


1. tlsca.example.com 证书问题 从新生成chanenel区块
2. 智能合约
    1. 问题
        1. Error: Error endorsing chaincode: rpc error: code = Unknown desc = premature execution - chaincode (fabcar:1.0) launched and waiting for registration
        2. ERRO 3a7 failed to invoke chaincode name:"lscc"  on transaction 
        3. Error trying to connect to local peer: context deadline exceeded


    2. 原因
        1. 智能合约运行在docker中, 需要与peer rpc通讯 , 由于域名在docker中无法访问. 出现deadline的问题
        
3. golang 版本1.10 编译有问题
4. fabric-ca golang1.9 版本v1.0.6
    
    1. 问题 
      1. DB: Get certificate by serial (5a4cc5d56d05b3a846dd3678a76db90231506d2c) and aki (83a266928e6e303b00cb7745890fc9a1a660181938e6b301b41dc9e29fd6ebe2)
      2. No certificates found for provided serial and aki
      3. fabric-ca request register failed with errors [[{"code":400,"message":"Authorization failure"}]]
       
    2.调整数据库字段serial_number authority_key_identifier 为varchar 2000 修改数据补上 serial 和 aki
5. Authorization for INSTALL has been denied (error-Failed verifying that proposal's creator satisfies local MSP
    chaincode 安装者必须是admin的msp
```bash
export CORE_PEER_MSPCONFIGPATH=$CONFIG_TX_PATH/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

```

5. enroll 问题
    1. Error: Enrollment failed with errors [[{"code":400,"message":"Authorization failure"}]]
  2.  missing destination name level in *lib.UserRecord
  3.  数据库错乱问题 删除数据库尝试
  4.  ca 版本要对应 1.0.6 有bug
      需要调整数据库结构补全admin的serial (332933d0e86d3abcb5bbde44432ef4adecf666bd) and aki (aa40d120c9f06a7e5bbded637293f7a78ae5afed2107d83fd2c0d65f61ff8e8d)

6. anchor节点哪里来的, 怎么更改端口信息
  1. 来自configtx.yaml 这个信息会正常anchor的msp文件 无法改变
7. 需要自建dns服务, 由于docker 启动chaincode 使用的是域名加端口的方式进行tcp通信

8. 如果删除重新跑,记得删除老的chancode的运行docker image


#构建环境
 ##依赖
 1. curl -s https://raw.githubusercontent.com/oscm/shell/master/virtualization/docker/docker.centos7.ce.sh | bash 
 2.  curl -s https://raw.githubusercontent.com/oscm/shell/master/virtualization/docker/docker-compose/docker-compose-1.19.0.sh | bash 
 3. yum install libtool-ltdl-devel
 4. go get -u github.com/hyperledger/fabric/core/chaincode/shim
 ##编译
 1. go get github.com/hyperledger/fabric-ca
    1. cd $GOPATH/src/github.com/hyperledger/fabric-ca && make fabric-ca-server fabric-ca-client
 2. go get github.com/hyperledger/fabric
    1. cd $GOPATH/src/github.com/hyperledger/fabric make configtxgen cryptogen configtxlator orderer peer
