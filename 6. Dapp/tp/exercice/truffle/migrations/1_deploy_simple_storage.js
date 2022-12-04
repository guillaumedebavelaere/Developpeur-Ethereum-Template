const MyToken = artifacts.require("MyToken");
const web3 = require("web3");
module.exports = function (deployer) {
  deployer.deploy(MyToken, web3.utils.toBN("10000000000000000000000"));
};
