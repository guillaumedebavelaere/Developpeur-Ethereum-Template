// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Guess is Ownable {

    string private wordToGuess;
    string private hint;
    mapping(address => bool) private _hasPlayed;
    address private _winner;
    address[] private _players;

    // setting the game
    function setEnigma(string calldata _wordToGuess, string calldata _hint) external onlyOwner {
        wordToGuess = _wordToGuess;
        hint = _hint;
    }

    function getHint() view external returns(string memory) {
        return hint;
    }

    function tryGuess(string calldata _word) external returns(bool) {
        // player can play once
        require(!_hasPlayed[msg.sender], "You can't guess twice the word!");
        // player can play if there is no winner yet
        require(_winner == address(0), "There is already a winner!");

        // keeping track of players
        _players.push(msg.sender);
        _hasPlayed[msg.sender] = true;

        // checking if the player has found the world to guess
        bool guessed = keccak256(bytes(_word)) == keccak256(bytes(wordToGuess));
        if (guessed) {
            _winner = msg.sender;
        }
        return guessed;
    }


    function getWinner() view external returns(address) {
        return _winner;
    }

    // resets the game
    function reset() external onlyOwner {
        for (uint i = 0; i<_players.length; i++) {
            _hasPlayed[_players[i]] = false;
        }
        delete _players;
        wordToGuess = "";
        hint = "";
        _winner = address(0);
    }

}