// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {

    address public owner;

    error NotOwner(address caller);

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw() external {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }

        payable(owner).transfer(address(this).balance);
    }
}