// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;



contract Parent {
    string internal variable;

    function setVariable(string memory _variable) external {
        variable = _variable;
    }
}

contract Child is Parent {

    function getVariable() external view returns(string memory){
        return variable;
    }
}

contract Caller {

    Child private _child;
    
    constructor() {
        _child = new Child();
    }

    function setVariable(string memory _variable) external {
        _child.setVariable(_variable);
    }


    function getVariable() external view returns(string memory){
        return _child.getVariable();
    }

}