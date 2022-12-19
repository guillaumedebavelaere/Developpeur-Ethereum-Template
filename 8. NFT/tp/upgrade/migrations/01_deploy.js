const { deployProxy } = require('@openzeppelin/truffle-upgrades');

const Storage= artifacts.require('Storage');

module.exports = async function (deployer) {

 const instance = await deployProxy(Storage, [3], { deployer, initializer: 'store' });

 console.log('Deployed', instance.address)

};