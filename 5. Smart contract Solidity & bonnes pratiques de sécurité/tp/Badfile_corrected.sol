// SPDX-License-Identifier: MIT
pragma solidity 0.8.17; // better to use a fixed version and more recent
 
contract Crowdsale {
 
   address public owner; // the owner of the contract
   address payable public escrow; // wallet to collect raised ETH => must be payable
   uint256 public savedBalance = 0; // Total amount raised in ETH => pas besoin d'initialiser
   mapping (address => uint256) public balances; // Balances in incoming Ether
 
   // Initialization
   constructor(address payable _escrow) { // bad: must use constructor
       owner = msg.sender; // bad tx origin
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH
   receive() external payable { // payable? external better utiliser receive
       balances[msg.sender] += msg.value;
       savedBalance += msg.value;
       (bool success,) = escrow.call{value: msg.value}(""); // call better
       require(success);
   }
  
   // refund investisor
   function withdrawPayments() external { // external better
       address payable payee = payable(msg.sender); // has to be payable
       uint256 payment = balances[payee];
        require(payment != 0);
        
       savedBalance -= payment;
       balances[payee] = 0;
       
       (bool success,) = payee.call{value: payment}(""); // Reentrancy? On devrait checker s'il y a une erreur pour pas executer le code qui suit
       require(success);
   }
}