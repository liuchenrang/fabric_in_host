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
      1. No certificates found for provided serial and aki
      2. fabric-ca request register failed with errors [[{"code":400,"message":"Authorization failure"}]]
    2.   
    3.   
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
