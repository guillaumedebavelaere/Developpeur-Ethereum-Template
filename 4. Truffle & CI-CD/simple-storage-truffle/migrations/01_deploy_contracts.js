const SimpleStorage = artifacts.require("SimpleStorage");
module.exports = async (deployer) => {
    await deployer.deploy(SimpleStorage, 6, {value: 1});
    const instance = await SimpleStorage.deployed();
    console.log(await instance.get());
}