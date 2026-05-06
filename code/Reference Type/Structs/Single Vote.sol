// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender), "Address has already voted");
        votes.push(Vote(choice, msg.sender));
    }

    function hasVoted(address user) public view returns (bool) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == user) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address user) external view returns (Choices) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == user) {
                return votes[i].choice;
            }
        }
        revert("User has not voted");
    }
}