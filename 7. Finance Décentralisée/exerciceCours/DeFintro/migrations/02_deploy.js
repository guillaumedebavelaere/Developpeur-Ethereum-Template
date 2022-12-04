const DefiProject = artifacts.require('DefiProject')

module.exports = (deployer) => {
    deployer.deploy(DefiProject, '0xdc31Ee1784292379Fbb2964b3B9C4124D8F89C60');
}


