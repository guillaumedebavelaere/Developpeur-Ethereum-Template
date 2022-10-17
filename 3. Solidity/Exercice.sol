// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Exercice {

    address state;


    function setState(address _state) public {
        state = _state;
    }

    function getBalance() public view returns(uint) {
        return state.balance;
    }

    function getBalance(address _address) public view returns(uint) {
        return _address.balance;
    }

    function transfer(address _address) public payable {
        payable(_address).transfer(msg.value);
        // (bool sent, _) = _address.call{value: msg.value}("");
        // require(sent, "Failed to send ether");
    }

    function sendEthToContract(uint256 value) payable public {
        require(state.balance > value, "You should have more wei");
        payable(state).transfer(msg.value);
    }

}