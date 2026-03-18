const hre = require("hardhat");

async function main() {
  // 1. Deploy Registry
  const Registry = await hre.ethers.getContractFactory("IdentityRegistry");
  const registry = await Registry.deploy();
  await registry.waitForDeployment();
  const registryAddr = await registry.getAddress();

  // 2. Deploy Token (e.g., 123 Blockchain Ave, NY)
  const PropertyToken = await hre.ethers.getContractFactory("PropertyToken");
  const token = await PropertyToken.deploy(
    "123 Blockchain Ave",
    "BCA123",
    registryAddr,
    "QmXoypizjUm3WknqS97C9Xv282WHLCX9rn2M",
    1000000 // Total 1M fractions
  );

  await token.waitForDeployment();
  console.log(`RWA Tokenized at: ${await token.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
