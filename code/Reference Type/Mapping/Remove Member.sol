// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    mapping(address => bool) public members;
    
    function addMember(address newMember) external {
        members[newMember] = true;
    }
    
    function removeMember(address member) external {
        members[member] = false;
    }
    
    function isMember(address user) external view returns (bool) {
        return members[user];
    }
}