// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}
	
	mapping(address => User) public users;
	
	function createUser() external {
		require(!users[msg.sender].isActive, "User already exists and is active");
		
		users[msg.sender] = User({
			balance: 100,
			isActive: true
		});
	}
	
	function transfer(address recipient, uint amount) external {
		// Ensure both addresses have active users
		require(users[msg.sender].isActive, "Sender does not have an active user");
		require(users[recipient].isActive, "Recipient does not have an active user");
		
		// Ensure sender has enough balance
		require(users[msg.sender].balance >= amount, "Insufficient balance");
		
		// Perform the transfer
		users[msg.sender].balance -= amount;
		users[recipient].balance += amount;
	}
}