import { ethers } from "hardhat";

async function main() {
  const ChainlinkPrice = await ethers.getContractFactory("ChainlinkPriceFeed");

  const price = await ChainlinkPrice.deploy();

  await price.deployed();

  console.log("Price Feed deployed at: ", price.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// Price Feed deployed at:  0x37a41c683402b5e332fbF00Cda38DB6463A6f6d1