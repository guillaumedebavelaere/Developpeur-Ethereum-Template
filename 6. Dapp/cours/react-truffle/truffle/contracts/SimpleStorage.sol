// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleStorage {
  uint256 value;
  string public greeter;

  event ValueChanged(uint value);

  function read() public view returns (uint256) {
    return value;
  }

  function write(uint256 newValue) public {
    value = newValue;
    emit ValueChanged(value);
  }

  function setGreeter(string calldata _greeter) external {
    greeter = _greeter;
  }
  
}
