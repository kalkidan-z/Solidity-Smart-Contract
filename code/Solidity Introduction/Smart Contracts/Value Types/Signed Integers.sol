// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 42;
    int8 public b = -30;
    int16 public difference = int16(a >= b ? a - b : b - a);
    
}