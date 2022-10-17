// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract epargne is Ownable {


    string private mot;

    string public indice;

    address public gagnant;

    mapping(address=>bool) played;

    function setMot(string calldata _mot, string calldata _indice) public onlyOwner{

        mot=_mot;

        indice=_indice;

    }

function getWinner() view public returns (string memory){

if(gagnant==address(0)){

return "Pas encore de gagnant!";

}

else {

return "Il y a un gagnant!";

}

}

function playWord(string calldata _try) public returns (bool) {

        require(played[msg.sender]==false, "t'as deja joue");

if (keccak256(abi.encodePacked(_try)) == keccak256(abi.encodePacked(mot))){

gagnant=msg.sender;

played[msg.sender]=true;

return true;

}

else {

played[msg.sender]=true;

return false;

}

}

}