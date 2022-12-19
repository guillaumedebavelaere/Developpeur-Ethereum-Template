// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BonhommesNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

		struct Bonhommes {
			uint height;
			bool hair;
		}
		Bonhommes[] bonhommes;

    constructor() ERC721 ("Bonhommes", "BH") {}

    function mintBonhommes(address _player, string calldata _tokenURI, uint _height, bool _hair) external returns (uint256)
    {
        _tokenIdCounter.increment();
				bonhommes.push(Bonhommes(_height, _hair));
        uint256 newItemId = _tokenIdCounter.current();
        _mint(_player, newItemId);
        _setTokenURI(newItemId, _tokenURI);

        return newItemId;
    }
}
