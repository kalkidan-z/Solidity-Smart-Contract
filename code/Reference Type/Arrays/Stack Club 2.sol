// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StackClub {
    address[] public members;
    
    modifier onlyMember() {
        require(isMember(msg.sender), "Only existing members can call this function");
        _;
    }
    
    constructor() {
        members.push(msg.sender);
    }
    
    function addMember(address newMember) external onlyMember {
        require(!isMember(newMember), "Address is already a member");
        members.push(newMember);
    }
    
    function removeLastMember() external onlyMember {
        require(members.length > 0, "No members to remove");
        members.pop();
    }
    
    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }
}