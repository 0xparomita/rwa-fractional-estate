# RWA Fractional Estate

This repository provides a compliant-ready template for **Real-World Asset Tokenization**. It allows an issuer to represent a property as a digital asset, enabling global investors to own a "fraction" of the real estate.

## Core Features
* **Restricted Transfers:** Tokens can only be sent to or received by addresses present in the `Registry` (KYC/AML compliance).
* **Dividend Distribution:** A built-in mechanism to distribute rental income (in USDC/ETH) to token holders proportional to their ownership.
* **Asset Documentation:** On-chain linking to legal documents via IPFS/CID hashing.

## Architecture
1. **The Asset Token:** An ERC-20 contract that overrides `_update` to check for whitelist status.
2. **The Registry:** A simple mapping managed by the property owner to track verified investors.
3. **The Payout Engine:** Logic to calculate and push/pull yields to holders.

## Setup
1. Deploy `IdentityRegistry.sol` to manage verified users.
2. Deploy `PropertyToken.sol` with the Registry address and property details.
3. Add investor addresses to the Registry before they attempt to buy or trade.
