const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Storage = artifacts.require('Storage');
const Storage2 = artifacts.require('Storage2');

module.exports = async function (deployer) {
    const existing = await Storage.deployed();
    const instance = await upgradeProxy(existing.address, Storage2, { deployer });

    console.log('Upgraded', instance.address)

};