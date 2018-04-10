'use strict';
/*
* Copyright IBM Corp All Rights Reserved
*
* SPDX-License-Identifier: Apache-2.0
*/
/*
 * Chaincode query
 */

var Fabric_Client = require('fabric-client');
var path = require('path');
var util = require('util');
var os = require('os');
const fs = require('fs'); 

//
var fabric_client = new Fabric_Client();
var options = {
	"server_hostname":"peer0.org1.example.com",
	"peerOrg1Host0":"grpcs://localhost:7051",
	"tls_cacerts":"../first-network/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt",
	"orderer_host" : "orderer.example.com",
	"orderer_grpcs" : "grpcs://localhost:7050",
	"orderer_tls_cacerts":"../first-network/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt",
}
// setup the fabric network
var channel = fabric_client.newChannel('mychannel');
let serverCert = fs.readFileSync(options.tls_cacerts);
let peer = fabric_client.newPeer(
		'grpcs://localhost:7051',
		{
			pem: Buffer.from(serverCert).toString(),
			'ssl-target-name-override' : options.server_hostname
		}
);
channel.addPeer(peer);

//
var member_user = null;
var store_path = path.join(__dirname, 'hfc-key-store');
console.log('Store path:'+store_path);
var tx_id = null;
var registerUser = "user3";

// create the key value store as defined in the fabric-client/config/default.json 'key-value-store' setting
Fabric_Client.newDefaultKeyValueStore({ path: store_path
}).then((state_store) => {
	// assign the store to the fabric client
	fabric_client.setStateStore(state_store);
	var crypto_suite = Fabric_Client.newCryptoSuite();
	// use the same location for the state store (where the users' certificate are kept)
	// and the crypto store (where the users' keys are kept)
	var crypto_store = Fabric_Client.newCryptoKeyStore({path: store_path});
	crypto_suite.setCryptoKeyStore(crypto_store);
	fabric_client.setCryptoSuite(crypto_suite);

	// get the enrolled user from persistence, this user will sign all requests
	return fabric_client.getUserContext(registerUser, true);
}).then((user_from_store) => {
	if (user_from_store && user_from_store.isEnrolled()) {
		console.log('Successfully loaded ${registerUser} from persistence');
		member_user = user_from_store;
	} else {
		throw new Error('Failed to get ${registerUser}.... run registerUser.js');
	}

	// queryCar chaincode function - requires 1 argument, ex: args: ['CAR4'],
	// queryAllCars chaincode function - requires no arguments , ex: args: [''],
	const request = {
		//targets : --- letting this default to the peers assigned to the channel
		chaincodeId: 'fabcar',
		fcn: 'queryAllCars',
		args: ['']
	};

	// send the query proposal to the peer
	return channel.queryByChaincode(request);
}).then((query_responses) => {
	console.log("Query has completed, checking results");
	// query_responses could have more than one  results if there multiple peers were used as targets
	if (query_responses && query_responses.length == 1) {
		if (query_responses[0] instanceof Error) {
			console.error("error from query = ", query_responses[0]);
		} else {
			console.log("Response is ", query_responses[0].toString());
		}
	} else {
		console.log("No payloads were returned from query");
	}
}).catch((err) => {
	console.error('Failed to query successfully :: ' + err);
});
