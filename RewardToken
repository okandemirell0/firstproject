// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract StakingToken is ERC20 {
    constructor() ERC20("My Staking Token", "STK") {
        _mint(msg.sender, 1000000 * 1e18);
    }
}


contract RewardToken is ERC20 {
    constructor() ERC20("My Reward Token", "RWD") {
        _mint(msg.sender, 1000000 * 1e18);
    }
}
