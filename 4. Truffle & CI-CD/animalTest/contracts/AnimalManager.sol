// // SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract AnimalManager {

    struct Animal {
        string breed;
        uint8 age;
        uint8 size;
        bool isAdopted;
    }

    Animal[] animals;

    mapping(address => Animal) ownerAnimalMapping;

    event AnimalAdded();
    event AnimalRemoved();
    event AnimalAdopted();

    function create(string calldata _breed, uint8 _age, uint8 _size) external {
        (bool exists, ) = _doesAnimalExist(_breed, _age, _size);
        if (!exists) {
            animals.push(Animal(_breed, _size, _age, false));
        }
    }

    function remove(string calldata _breed, uint8 _age, uint8 _size) external {
        (bool exists, uint index) = _doesAnimalExist(_breed, _age, _size);

        if (exists) {
            delete animals[index];
        }
    }

    function adopt(string calldata _breed, uint8 _age, uint8 _size) external {
        (bool exists, uint index) = _doesAnimalExist(_breed, _age, _size);

        if (exists && !animals[index].isAdopted) {
            animals[index].isAdopted = true;
            ownerAnimalMapping[msg.sender] = animals[index];
        }
    }

    function _doesAnimalExist(string memory _breed, uint8 _age, uint8 _size)
        private
        view
        returns (bool, uint)
    {
        for (uint i = 0; i < animals.length; i++) {
            if (
                _stringEquals(animals[i].breed, _breed) && animals[i].age == _age && animals[i].size == _size
            ) {
                return (true, i);
            }
        }
        return (false, 0);
    }

    function _stringEquals(string memory _s1, string memory _s2) private pure returns(bool) {
        return keccak256(bytes(_s1)) == keccak256(bytes(_s2));
    }

}