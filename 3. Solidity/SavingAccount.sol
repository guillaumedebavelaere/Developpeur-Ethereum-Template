// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract SavingAccount is Ownable {
    using Counters for Counters.Counter;

    struct History {
        uint amount;
        uint timestamp;
    }

    // address private _admin;
    Counters.Counter private _counter;
    mapping(uint => History) public history;
    uint private constant WAIT_DURATION = 30 days * 3; // 3 months

    // constructor() {
    //     _admin = msg.sender;
    // }

    // modifier onlyOwner {
    //     require(msg.sender == _admin, "Only admin is allowed to do that!");
    //     _;
    // }


    function deposit() external payable {
        // keep history of the deposit
        history[_counter.current()] = History(msg.value, block.timestamp);
        _counter.increment();
    }

    function withdraw() external onlyOwner {
        // check if there is something to withdraw
        require(address(this).balance != 0 , "No balance to withdraw!");

        // owner has to wait waitDuration time from the first transaction before withdrawing
        uint waitedTime = block.timestamp - history[0].timestamp;
        require(waitedTime >= WAIT_DURATION, "you have to wait 3 months before withdrawing");

        // withdraw money from the contract to the owner
        (bool success,) = owner().call{value: address(this).balance}("");
        require(success, "Failed to withdraw ether");
    }

    function getContractBalance() external view returns (uint) {
        return address(this).balance;
    }

    function getOwnerBalance() external view returns (uint) {
        return owner().balance;
    }
}