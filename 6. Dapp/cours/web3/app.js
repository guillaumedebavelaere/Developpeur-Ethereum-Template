require('dotenv').config();
const Web3 = require('web3');
const rpc = `https://goerli.infura.io/v3/${process.env.INFURA_ID}`;
const web3 = new Web3(rpc);

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
	}
];

const scAddress = "0xfA95935932ECcd000765C772CF8A731B1E215d06";
const simpleStorage = new web3.eth.Contract(ABI, scAddress);

simpleStorage.methods.get().call((err, data) => {
    console.log("data get: " + data);
});

// get balance of an address
web3.eth.getBalance(scAddress, (err, wei) => {
    const balance = web3.utils.fromWei(wei, 'ether');
    console.log("balance: " + balance);
});