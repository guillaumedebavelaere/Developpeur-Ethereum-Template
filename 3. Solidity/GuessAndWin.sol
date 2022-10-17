// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';

contract GuessAndWin is Ownable, ReentrancyGuard {
  struct Game {
    string clue;
    uint256 answer;
    uint256 jackpot;
    bool answered;
  }
  Game[] games;

  event GameCreated(uint256 _id);
  event Answered(uint256 _id, address _player);

  /**
   * Create a new game.
   * @dev Only the contract owner can call. Owner can set a jackpot.
   */
  function createGame(string memory _clue, uint256 _answer) public payable onlyOwner {
    Game memory g = Game({ clue: _clue, answer: _answer, jackpot: msg.value, answered: false });
    games.push(g);
    emit GameCreated(games.length - 1);
  }

  /*
   * Get the game struct associated with the id.
   * @returns The game struct.
   */

  function getGame(uint256 _id) public view returns (Game memory) {
    require(_id < games.length, 'no game with this id');
    return games[_id];
  }

  /*
   * @return Amount of games registered.
   */
  function gameCount() public view returns (uint256) {
    return games.length;
  }

  /*
   * Guess a game.
   * @params _id is the id of the game, _answer is the answer in string.
   */

  function guess(uint256 _id, string memory _answer) public nonReentrant {
    require(_id < games.length, 'no game with this id');
    require(games[_id].answered == false, 'game already won');
    uint256 hash = uint256(keccak256(abi.encodePacked(_answer)));
    require(hash == games[_id].answer, 'wrong answer');

    /* Was money involved? */
    if (games[_id].jackpot > 0) {
      (bool sent, ) = msg.sender.call{ value: games[_id].jackpot }('');
      require(sent, 'failed to send ether, try again, quick');
    }

    /* Closing the game. */
    games[_id].answered = true;
    emit Answered(_id, msg.sender);
  }
}