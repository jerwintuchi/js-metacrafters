const hre = require("hardhat");

async function main() {
  // Get the Points smart contract
  const ItemManager = await hre.ethers.getContractFactory("ItemManager");
  const Degen = await hre.ethers.getContractFactory("DegenToken");

  // Deploy ItemManager
  const itemManager = await ItemManager.deploy();
  await itemManager.deployed();

  // Display the ItemManager contract address
  console.log(`ItemManager deployed to ${itemManager.address}`);

  // Deploy DegenToken, passing the address of ItemManager as an argument
  const degen = await Degen.deploy(itemManager.address);
  await degen.deployed();

  // Display the DegenToken contract address
  console.log(`Degen token deployed to ${degen.address}`);
}

// Hardhat recommends this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
