// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ChainlinkPriceFeed {
  AggregatorV3Interface internal priceFeed;
  AggregatorV3Interface internal floorFeed;
   AggregatorV3Interface internal dynamicFeed;



  constructor() {
    // ETH / USD
    priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    floorFeed = AggregatorV3Interface(0xaEA2808407B7319A31A383B6F8B60f04BCa23cE2);
  }

  function getLatestPrice() public view returns (int) {
    (
      uint80 roundID,
      int price,
      uint startedAt,
      uint timeStamp,
      uint80 answeredInRound
    ) = priceFeed.latestRoundData();
    // for ETH / USD price is scaled up by 10 ** 8
    return price / 1e8;
  }

  function setFeedAddress (address _addr) external {
        dynamicFeed = AggregatorV3Interface(_addr);
    }

    function getLatestCoinPrice() external view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dynamicFeed.latestRoundData();
        return price;
    }


function getETCPrice() public view returns (int) {
    (
      uint80 roundID,
      int price,
      uint startedAt,
       uint timeStamp,
      uint80 answeredInRound
    ) = floorFeed.latestRoundData();
    // for ETC / USD price is scaled up by 10 ** 8
    return price / 1e8;
  }

}

interface AggregatorV3Interface {
  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int answer,
      uint startedAt,
      uint updatedAt,
      uint80 answeredInRound
    );

}


// Price Feed deployed at:  0x37a41c683402b5e332fbF00Cda38DB6463A6f6d1