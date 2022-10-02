// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ChainlinkPriceFeed {
    address public USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address public INCH = 0x111111111117dC0aa78b770fA6A738034120C302;
    AggregatorV3Interface internal priceFeed;

    constructor() {
        // ETH / USD
        priceFeed = AggregatorV3Interface(
            0xc929ad75B72593967DE83E7F7Cda0493458261D9
        );
        
        // floorFeed = AggregatorV3Interface(0xaEA2808407B7319A31A383B6F8B60f04BCa23cE2);
    }

    event Swap(uint256 USDT, uint256 INCH);
    event priceCheck(uint);

    function getLatestPrice() public view returns (int256) {
        (
            ,
            int256 price,
            ,
            ,
            
        ) = priceFeed.latestRoundData();
        // for ETH / USD price is scaled up by 10 ** 8
        return price;
    }

    function calculate(uint256 ___in) public returns (uint256 _amountOut) {
      emit priceCheck(0);
      int256 INCHprice = getLatestPrice();
      emit priceCheck(1);
      uint256 INCHout = uint256(((___in * 1e20) / uint256(INCHprice)));
      emit priceCheck(2);
      _amountOut = INCHout;


    }

    function swap(uint256 _amountIn) external {
      emit priceCheck(10);
      IERC20(USDT).transferFrom(msg.sender, address(this), _amountIn);
      emit priceCheck(11);
      uint256 amountOut = calculate(_amountIn);
      IERC20(INCH).transfer(msg.sender, amountOut);
      emit Swap(_amountIn, amountOut);
        

    }
}

interface IERC20 {
    function approve(address _spender, uint256 _amount) external;

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) external returns (bool);

    function transfer(address _to, uint256 _amount) external returns (bool);
}

interface AggregatorInterface {
    function latestAnswer() external view returns (int256);

    function latestTimestamp() external view returns (uint256);

    function latestRound() external view returns (uint256);

    function getAnswer(uint256 roundId) external view returns (int256);

    function getTimestamp(uint256 roundId) external view returns (uint256);

    event AnswerUpdated(
        int256 indexed current,
        uint256 indexed roundId,
        uint256 updatedAt
    );
    event NewRound(
        uint256 indexed roundId,
        address indexed startedBy,
        uint256 startedAt
    );
}

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    // getRoundData and latestRoundData should both raise "No data present"
    // if they do not have data to report, instead of returning unset values
    // which could be misinterpreted as actual reported values.
    function getRoundData(uint80 _roundId)
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

// Price Feed deployed at:  0x37a41c683402b5e332fbF00Cda38DB6463A6f6d1
