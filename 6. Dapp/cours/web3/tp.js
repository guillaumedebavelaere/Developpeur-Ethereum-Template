async function main() {

    var  Web3  =  require('web3');
    require('dotenv').config();
    const HDWalletProvider = require('@truffle/hdwallet-provider');
    
    const provider = new HDWalletProvider(`${process.env.MNEMONIC}`, `https://goerli.infura.io/v3/${process.env.INFURA_ID}`)
    web3 = new Web3(provider);
    
    
    const ABI = [ { "inputs": [ { "internalType": "uint256", "name": "x", "type": "uint256" } ], "name": "set", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "get", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function", "constant": true } ];

    var  addr  =  "0x1f9C83F7311c1b0AD188E9925E2705a3B60c4b1d";
    
    var  Contract  =  new  web3.eth.Contract(ABI, addr);
    
    Contract.methods.get().call().then(console.log);
    await Contract.methods.set(5).send({ from: '0x13bc18faeC7f39Fb5eE428545dBba611267AEAa4' });
    Contract.methods.get().call().then(console.log);
    }
    
    main();
﻿