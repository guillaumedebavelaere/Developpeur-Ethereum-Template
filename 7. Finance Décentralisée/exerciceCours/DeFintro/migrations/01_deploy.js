const Dai = artifacts.require('Dai');
const DefiProject = artifacts.require('DefiProject')

module.exports = async (deployer, _network, accounts) => {
    await deployer.deploy(Dai);
    const dai = await Dai.deployed();
    
    await deployer.deploy(DefiProject, dai.address);
    const defiProject = await DefiProject.deployed();

    await dai.faucet(defiProject.address, 100); // send 100 token to defi project contract
    const balance00 = await dai.balanceOf(defiProject.address); // get dai balance of defi project contract
    console.log(balance00.toString());

    await defiProject.foo(accounts[1], 100); // send 100 tokens from defi project contract to accounts[1]

    const balance0 = await dai.balanceOf(defiProject.address); // get dai balance of defi project contract
    const balance1 = await dai.balanceOf(accounts[1]); // // get dai balance of accounts[1]

    console.log(balance0.toString());
    console.log(balance1.toString());
}


