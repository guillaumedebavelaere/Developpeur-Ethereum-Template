// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;


contract People {

    struct Person {
        string name;
        uint8 age;
    }

    Person public moi;

    Person[] public persons;


    function add(string calldata _name, uint8 _age) public {
        persons.push(Person(_name, _age));
    }

    function remove() public {
        persons.pop();
    }

    function modifyPerson(string calldata _name, uint8 _age)  public {
        moi.age = _age;
        moi.name = _name;
    }

}
