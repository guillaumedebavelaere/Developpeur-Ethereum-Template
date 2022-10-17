// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Bank {

    mapping(address => uint) private _balances;

    function deposit(uint _amount) external {
        _balances[msg.sender] += _amount;
    }

    function transfer(address _recipient, uint _amount) external {
        require(_balances[msg.sender] >= _amount, "insufficient balance");
        _balances[msg.sender]-=_amount;
        _balances[_recipient]+=_amount;
    }

    function balanceOf(address _address) external view returns(uint) {
        return _balances[_address];
    }
}