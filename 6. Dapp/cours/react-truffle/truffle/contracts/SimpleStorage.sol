// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SimpleStorage {
    uint256 value;
    string public greeter;

    event ValueChanged(uint256 value);

    function read() public view returns (uint256) {
        return value;
    }

    function write(uint256 newValue) public {
        require(newValue != 5, "5 forbidden");
        value = newValue;
        emit ValueChanged(value);
    }

    function setGreeter(string calldata _greeter) external {
        greeter = _greeter;
    }
}
