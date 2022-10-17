// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

interface Deployed {
    function get() external view returns(uint);
    function set(uint n) external ;
}

contract Caller {

    Deployed private  _d;

    constructor() {
         _d = Deployed(0xe6081F71cC25db8c0d4A5bd92fF28f62b1e3F302);
    }
    function get() external view returns(uint) {
        return _d.get();
    }

    function set(uint value) external {
        _d.set(value);
    }
}
