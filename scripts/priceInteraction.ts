import { ethers } from "hardhat";

async function main() {
    const priceFeed = await ethers.getContractFactory("ChainlinkPriceFeed");

    const feed = priceFeed.attach("0xE3Be6837b3B74eD7a143409789365981CcB0BA09");

    const getLatestPrice = await feed.getLatestPrice();
    console.log("Get Latest Price: ", Number(getLatestPrice));

    const setFeedAddress = feed.setFeedAddress("0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419");

    const getDynamicPriceFeed = await feed.getLatestCoinPrice();
    console.log("Dynamic FUnction Feed", Number(getDynamicPriceFeed));

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  