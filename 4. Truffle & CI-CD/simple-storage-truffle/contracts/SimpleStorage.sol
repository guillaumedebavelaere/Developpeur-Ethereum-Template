// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

contract SimpleStorage {
    uint  storageData;

    event dataStored(uint _data, address _addr);
 

    function get() public view returns(uint) {
        return storageData;    
    }
    
    function set(uint n) public {
        require(n!=0, "vous ne pouvez pas mettre une valeur nulle");
        storageData = n;
        emit dataStored(n,msg.sender);    
    }

}