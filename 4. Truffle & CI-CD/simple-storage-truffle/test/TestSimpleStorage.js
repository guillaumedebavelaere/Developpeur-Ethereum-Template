const SimpleStorage = artifacts.require("./SimpleStorage.sol");
const { BN, expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');

contract('SimpleStorage2', accounts => {

  const owner = accounts[0];
  let simpleStorageInstance;

  describe("test complet", function () {
    beforeEach(async function () {
      simpleStorageInstance = await SimpleStorage.new({ from: owner });

    });

    it("...should store the value 2.", async () => {
      await simpleStorageInstance.set(2, { from: owner });
      const storedData = await simpleStorageInstance.storageData.call();
      expect(storedData).to.be.bignumber.equal(new BN(2));

    });

    it("should revert on value 0", async () => {
      await expectRevert(simpleStorageInstance.set(new BN(0), { from: owner }), 'vous ne pouvez pas mettre la premiere valeur');
    });

    it("should emit event on set", async () => {
      expectEvent(await simpleStorageInstance.set(new BN(2), { from: accounts[0] }), "dataStored", { _data: new BN(2), _addr: owner })
    });

  });

});