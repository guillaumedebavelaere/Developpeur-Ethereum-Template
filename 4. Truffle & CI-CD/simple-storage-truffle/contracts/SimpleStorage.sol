// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

contract SimpleStorage {
    enum StorageData {
        VALUE1, VALUE2, VALUE3
    }
    StorageData public storageData;

    event dataStored(StorageData _data, address _addr);
 

    function get() public view returns(StorageData) {
        return storageData;    
    }
    
    function set(StorageData _storageData) public {
        require(_storageData!=StorageData.VALUE1, "vous ne pouvez pas mettre la premiere valeur!");
        storageData = _storageData;
        emit dataStored(_storageData,msg.sender);    
    }

}