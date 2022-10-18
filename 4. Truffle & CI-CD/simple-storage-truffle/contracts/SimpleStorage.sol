// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

contract SimpleStorage {
    uint data;

    constructor(uint _data) {
        data = _data;
    }

    function set(uint x) public {
        data = x;
    }

    function get() public view returns (uint) {
        return data;
    }
}