pragma solidity ^0.6.0;

import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SynthaSwap {

    using SafeMath for uint256;

    address internal constant UNISWAP_ROUTER_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D ;

    IUniswapV2Router02 public uniswapRouter;
    IERC20 public wBtcToken;
    IERC20 public sEthToken;

    address private sEth = 0x5e74C9036fb86BD7eCdcb084a0673EFc32eA31cb;
    address private wBtc = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

    constructor() public {
        uniswapRouter = IUniswapV2Router02(UNISWAP_ROUTER_ADDRESS);
        wBtcToken = IERC20(wBtc);
        sEthToken = IERC20(sEth);
    }

    function convertWbtctoSynthEth(uint wbtcAmount) external returns (uint256[] memory) {
        require(
            wBtcToken.transferFrom(address(msg.sender), address(this), wbtcAmount),
            "Could not trasfer tokens"    
        );

        require(
            wBtcToken.approve(address(UNISWAP_ROUTER_ADDRESS), wbtcAmount),
            "wBTC approve failed!"
        );

        uint deadline = now + 15;

        return uniswapRouter.swapExactTokensForTokens(wbtcAmount, 0, getPathForWbtctoSynthEth(), msg.sender, deadline);
    }

    function convertEthtoSynthEth() public payable {
        uint deadline = now + 15;

        // uniswapRouter.swapExactETHForTokens.value(msg.value)(0, getPathForEthtoSynthEth(), address(this), deadline);
        uniswapRouter.swapExactETHForTokens.value(msg.value)(0, getPathForEthtoSynthEth(), msg.sender, deadline);
    }

    function convertEthtoWbtc() public payable {
        uint deadline = now + 15;

        uniswapRouter.swapExactETHForTokens.value(msg.value)(0, getPathForEthtowBtc(), msg.sender, deadline);
    }

    function getEstimateSynthEthforEth(uint ethAmount) public view returns (uint[] memory) {
        // uint maximum = uniswapRouter.getAmountsOut(ethAmount, getPathForEthtoSynthEth());
        // return maximum.mul(90).div(100);
        return uniswapRouter.getAmountsOut(ethAmount, getPathForEthtoSynthEth());
    }

    function getPathForWbtctoSynthEth() private view returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = wBtc;
        path[1] = sEth;

        return path;
    }

    function getPathForEthtoSynthEth() private view returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = uniswapRouter.WETH();
        path[1] = sEth;

        return path;
    }

    function getPathForEthtowBtc() private view returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = uniswapRouter.WETH();
        path[1] = wBtc;

        return path;
    }

    receive() payable external {}
}