// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Lottery {
    address public organizer;
    address payable[] public participants;

    constructor() public {
        organizer = msg.sender;
    }
    modifier onlyAdmin() {
        require(msg.sender == organizer);
        _;
    }
    receive() external payable {
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }
    function getBalance() public view onlyAdmin returns (uint) {
        // require(msg.sender==organizer);
        return address(this).balance;
    }

    function random() public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participants.length
                    )
                )
            );
    }

    function selectWinner() public onlyAdmin {
        require(participants.length >= 3);
        uint r = random();
        address payable winner;
        uint idx = r % participants.length;
        winner = participants[idx];
        winner.transfer(getBalance());
        participants = new address payable[](0);
    }
}
