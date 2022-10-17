// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Random {

    uint private _nonce = 0;

    function random() external returns(uint) {
        _nonce++;

        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, _nonce))) % 100;
    }

}