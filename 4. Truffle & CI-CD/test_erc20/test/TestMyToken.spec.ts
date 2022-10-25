import { MyTokenInstance } from "../types/MyToken";
const MyToken = artifacts.require("MyToken");

import { BN, expectRevert, expectEvent } from '@openzeppelin/test-helpers';
const {expect} = require('chai');


import constants from '@openzeppelin/test-helpers/src/constants';

contract("MyToken", accounts => {
  const _name = "Nabo"
  const _symbol = "NBO"
  const _initialSupply = new BN("100000000");
  const _owner = accounts[0];
  const _recipient = accounts[1];
  const _decimal = new BN(18);

  let myTokenInstance: MyTokenInstance;

  beforeEach(async () => {
    myTokenInstance = await MyToken.new(_initialSupply, { from: _owner });
  });

  it("has a name", async () => {
    expect(await myTokenInstance.name()).to.equal(_name);
  });

  it('has a symbol', async () => {
    expect(await myTokenInstance.symbol()).to.equal(_symbol);
  });

  it('has a decimal', async () => {
    expect(await myTokenInstance.decimals()).to.be.bignumber.equal(_decimal);
  });

  it('check balance', async () => {
    expect(await myTokenInstance.balanceOf(_owner)).to.be.bignumber.equal(_initialSupply);
  });

  it('has a total supply', async () => {
    expect(await myTokenInstance.totalSupply()).to.be.bignumber.equal(_initialSupply);
  });

  it('checks balance after transfer', async () => {
    let amount = new BN(100);
    let balanceOwnerBeforeTransfer = await myTokenInstance.balanceOf(_owner);
    let balanceRecipientBeforeTransfer = await myTokenInstance.balanceOf(_recipient)

    expect(balanceRecipientBeforeTransfer).to.be.bignumber.equal(new BN(0));

    await myTokenInstance.transfer(_recipient, new BN(100), { from: _owner });

    let balanceOwnerAfterTransfer = await myTokenInstance.balanceOf(_owner);
    let balanceRecipientAfterTransfer = await myTokenInstance.balanceOf(_recipient)

    expect(balanceOwnerAfterTransfer).to.be.bignumber.equal(balanceOwnerBeforeTransfer.sub(amount));
    expect(balanceRecipientAfterTransfer).to.be.bignumber.equal(balanceRecipientBeforeTransfer.add(amount));

  });

  it('approves', async () => {
    const allowance = await myTokenInstance.allowance(_owner, _recipient);
    expect(allowance).to.be.bignumber.equal(new BN(0));

    await myTokenInstance.approve(_recipient, new BN(100));

    const allowanceAfter = await myTokenInstance.allowance(_owner, _recipient);
    expect(allowanceAfter).to.be.bignumber.equal(new BN(100));
  });

  it('transfers from', async () => {
    let amount = new BN(100);
    await myTokenInstance.approve(_recipient, new BN(100));
    let balanceOwnerBeforeTransfer = await myTokenInstance.balanceOf(_owner);
    let balanceRecipientBeforeTransfer = await myTokenInstance.balanceOf(_recipient)
    expect(balanceOwnerBeforeTransfer).to.be.bignumber.equal(new BN(_initialSupply));
    expect(balanceRecipientBeforeTransfer).to.be.bignumber.equal(new BN(0));

    await myTokenInstance.transferFrom(_owner, _recipient, new BN(100), { from: _recipient });

    let balanceOwnerAfterTransfer = await myTokenInstance.balanceOf(_owner);
    let balanceRecipientAfterTransfer = await myTokenInstance.balanceOf(_recipient)

    expect(balanceOwnerAfterTransfer).to.be.bignumber.equal(balanceOwnerBeforeTransfer.sub(amount));
    expect(balanceRecipientAfterTransfer).to.be.bignumber.equal(balanceRecipientBeforeTransfer.add(amount));
  });


});