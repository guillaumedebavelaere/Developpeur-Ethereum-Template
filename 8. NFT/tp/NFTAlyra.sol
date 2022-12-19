// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

//import Open Zepplin contracts

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";

contract NFTs is ERC721 {
    uint256 private _tokenIds;

    uint256 datetoreveal;

    mapping(address => bool) minted;

    constructor() ERC721("Chien Chat", "CC") {}

    //use the mint function to create an NFT. Mint le plus simple possible ici

    function mint() public returns (uint256) {
        require(minted[msg.sender] == false, "already minted");
        _tokenIds += 1;
        _mint(msg.sender, _tokenIds);
        minted[msg.sender] = true;
        return _tokenIds;
    }

    //in the function below include the CID of the JSON folder on IPFS

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (block.timestamp < datetoreveal) {
            return
                string(
                    abi.encodePacked(
                        "https://gateway.pinata.cloud/ipfs/CIDDEMETADATA/hiden.json"
                    )
                );
        } else {
            return
                string(
                    abi.encodePacked(
                        "ipfs://bafybeig4zjvi4am7zrinqao3hqbjduyn7qxa3emkdiv76zyeuo4dunlbqm/",
                        Strings.toString(_tokenId),
                        ".json"
                    )
                );
        }
    }
}
