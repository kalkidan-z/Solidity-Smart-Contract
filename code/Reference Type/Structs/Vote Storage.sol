// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }

	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	Vote public vote;

	function createVote(Choices choice) external {
		// TODO: create a new vote
		vote = Vote(choice, msg.sender);
	}
}