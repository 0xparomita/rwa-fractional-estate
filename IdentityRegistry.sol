// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract IdentityRegistry is Ownable {
    mapping(address => bool) public isVerified;

    constructor() Ownable(msg.sender) {}

    function updateVerification(address investor, bool status) external onlyOwner {
        isVerified[investor] = status;
    }

    function batchVerify(address[] calldata investors) external onlyOwner {
        for (uint256 i = 0; i < investors.length; i++) {
            isVerified[investors[i]] = true;
        }
    }
}
