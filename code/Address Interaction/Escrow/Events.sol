// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;
    
    event Approved(uint balance);
    
    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }
    
    function approve() external {
        require(msg.sender == arbiter, "Not arbiter");
        
        uint balance = address(this).balance;
        payable(beneficiary).transfer(balance);
        
        emit Approved(balance);
    }
}