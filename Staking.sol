
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Staking is ReentrancyGuard {
    IERC20 public stakingToken;
    IERC20 public rewardsToken;

    uint256 public periodFinish;          
    uint256 public rewardsDuration = 7 days; 


    uint256 public rewardRate = 100;
    uint256 public rewardPerTokenStored;
    uint256 public lastUpdateTime;
    mapping (address => uint256) private _balances; 
    mapping(address => uint256) public userRewardPerTokenPaid;
    mapping(address => uint256) public rewards;

    uint256 public _totalSupply;

    constructor (address _stakingToken , address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }
    modifier updateReward(address account) {
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        if (account != address(0)) {
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account]  = rewardPerTokenStored;
        }
        _;
    }

    function rewardPerToken() public view returns (uint256) {
    if (_totalSupply == 0) {
        return rewardPerTokenStored;
    }

    return rewardPerTokenStored +
        (
            (lastTimeRewardApplicable() - lastUpdateTime)
            * rewardRate
            * 1e18
        ) / _totalSupply;
}

    function earned(address account) public view returns (uint256) {
        return ((_balances[account]) * (rewardPerToken() - userRewardPerTokenPaid[account]) / 1e18) + rewards[account];
    }

    function stake(uint256 amount) public updateReward(msg.sender){
        require(amount > 0 , "cant stake 0 ");
    

        _totalSupply += amount;
        _balances[msg.sender] += amount;
        stakingToken.transferFrom(msg.sender , address(this) , amount);
    }

    function withdraw(uint256 amount) public nonReentrant   updateReward(msg.sender){
        require(amount > 0 , "cannot withdraw 0 ");
        require(_balances[msg.sender] >= amount, "not enough staked");


        _totalSupply -= amount;
        _balances[msg.sender] -= amount;

        stakingToken.transfer(msg.sender  , amount);
    }
    function getReward() public nonReentrant updateReward(msg.sender) {
        uint256 reward  = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender , reward);

        }
    }
    function lastTimeRewardApplicable() public view returns (uint256) {
    return block.timestamp < periodFinish
        ? block.timestamp
        : periodFinish;
}   
}

