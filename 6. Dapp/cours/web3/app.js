require('dotenv').config();
const Web3 = require('web3');
const rpc = `https://goerli.infura.io/v3/${process.env.INFURA_ID}`;
const HDWalletProvider = require("@truffle/hdwallet-provider");
const mnemonicPhrase = `${process.env.MNEMONIC}`;

let provider = new HDWalletProvider({
	mnemonic: {
	  phrase: mnemonicPhrase
	},
	providerOrUrl: rpc
  });

const web3 = new Web3(provider);

const ABI = [
	{
		"inputs": [],
		"name": "get",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			}
		],
		"name": "set",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];


const scAddress = "0x1f9C83F7311c1b0AD188E9925E2705a3B60c4b1d";
const simpleStorage = new web3.eth.Contract(ABI, scAddress);

simpleStorage.methods.get().call((err, data) => {
    console.log("data get: " + data);
});

// get balance of an address
web3.eth.getBalance(scAddress, (err, wei) => {
    const balance = web3.utils.fromWei(wei, 'ether');
    console.log("balance: " + balance);
});

simpleStorage.methods.set(123456789).send({from: '0x091CE98Ebc3812a8FdE6c5D817A9390121aFd203'}).on('receipt', function(receipt){
    // receipt example
    console.log(receipt);
});