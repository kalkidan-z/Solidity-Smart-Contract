// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Hero.sol";

// Inherits everything from Hero
contract Mage is Hero(50) {
    // no extra code needed
}

// Inherits everything from Hero
contract Warrior is Hero (200){
    // no extra code needed
}
