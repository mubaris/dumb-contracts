pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract FixedDai is ERC20 {

    using SafeMath for uint256;

    uint256 public tokensPerEth = 250;

    event Approval(address indexed src, address indexed guy, uint256 wad);
    event Transfer(address indexed src, address indexed dst, uint256 wad);
    event Deposit(address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);

    fallback() external payable {
        deposit();
    }

    constructor() ERC20("Fixed DAI", "fDAI") public {
    }

    function deposit() public payable {
        uint256 amount = msg.value.mul(tokensPerEth);
        _mint(msg.sender, amount);
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 wad) public {
        uint256 amount = wad.div(tokensPerEth);
        _burn(msg.sender, wad);
        msg.sender.transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

}