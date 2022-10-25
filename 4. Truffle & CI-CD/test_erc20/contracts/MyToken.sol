// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    constructor(uint _initialSupply) ERC20("Nabo", "NBO") {
        _mint(msg.sender, _initialSupply);
    }
    
}