// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IdentityRegistry.sol";

contract PropertyToken is ERC20, Ownable {
    IdentityRegistry public registry;
    string public legalDocumentHash; // IPFS CID

    constructor(
        string memory name,
        string memory symbol,
        address _registry,
        string memory _docHash,
        uint256 initialSupply
    ) ERC20(name, symbol) Ownable(msg.sender) {
        registry = IdentityRegistry(_registry);
        legalDocumentHash = _docHash;
        _mint(msg.sender, initialSupply * 10**decimals());
    }

    /**
     * @dev Hook that is called before any transfer of tokens.
     * Includes minting and burning.
     */
    function _update(address from, address to, uint256 value) internal override {
        // Allow the initial mint from address(0) and burning to address(0)
        // Otherwise, both parties must be verified in the registry.
        if (from != address(0) && to != address(0)) {
            require(registry.isVerified(from), "Sender not KYC verified");
            require(registry.isVerified(to), "Recipient not KYC verified");
        }
        super._update(from, to, value);
    }

    function updateDocHash(string memory newHash) external onlyOwner {
        legalDocumentHash = newHash;
    }
}
