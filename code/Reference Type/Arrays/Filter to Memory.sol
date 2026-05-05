// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    function filterEven(uint[] memory numbers) external pure returns (uint[] memory) {
        uint[] memory evens = new uint[](numbers.length);
        uint count = 0;
        
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evens[count] = numbers[i];
                count++;
            }
        }
        
        // Create a properly sized array to return
        uint[] memory result = new uint[](count);
        for (uint i = 0; i < count; i++) {
            result[i] = evens[i];
        }
        
        return result;
    }
}