// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

contract Whitelist {

    event Authorized(address _address);

    mapping(address => bool) private whitelist;


    function authorize(address _address) public check() {
        whitelist[_address] = true;
        emit Authorized(_address);
    }

    modifier check() {
        require (whitelist[msg.sender], "you are not authorized");
        _;
    }

}
    