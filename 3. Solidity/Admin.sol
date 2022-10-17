// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";

contract Admin is Ownable {

    event Whitelisted(address _address);
    event Blacklisted(address _address);

    mapping(address => bool) private _whitelist;
    mapping(address => bool) private _blacklist;

    function isWhitelisted(address _address) external view returns(bool) {
        return _whitelist[_address];
    }

    function isBlacklisted(address _address) external view returns(bool) {
        return _blacklist[_address];
    }

    function whitelist(address _address) external onlyOwner {
        _blacklist[_address] = false;
        _whitelist[_address] = true;
        emit Whitelisted(_address);
    }

    function blacklist(address _address) external onlyOwner {
        _whitelist[_address] = false;
        _blacklist[_address] = true;
        emit Blacklisted(_address);
    }
}