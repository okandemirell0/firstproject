
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Staking is ReentrancyGuard{
    IERC20 public stakingToken;   
    IERC20 public rewardsToken;   //Alınan ödül.
    uint256 public lastUpdateTime;//son guncelleme zamanı
    uint256 public rewardRate = 100; //Süre.
    uint256 public rewardPerTokenStored;
    uint256 private _totalSupply;

    mapping(address => uint256) private _userbalance; //kullanıcı adresi ve user bakiyesi mapping.
    mapping (address => uint256) public _userRewardToken; //Kullanıcı kazancı mapping.
    mapping (address => uint256) public rewards; //Oduller.

    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }
    modifier updateReward(address account){
        rewardPerTokenStored = rewardPerToken();
        lastUpdateTime = block.timestamp;

        if (account != address(0)){
               rewards[account] = earned(account);
              _userRewardToken[account] = rewardPerTokenStored; 
         }
            _;
    }
    function rewardPerToken() public view returns (uint){
        if (_totalSupply == 0){
            return rewardPerTokenStored;
        }
        return rewardPerTokenStored + (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / _totalSupply);
    }
    function earned(address account ) public view returns (uint) {
        return ((_userbalance[account]  *  rewardPerToken() - _userRewardToken[account]  / 1e18)) + rewards[account];
    }
    function stake(uint amount) external nonReentrant updateReward(msg.sender){//nonReentrant for safety.
        require(amount > 0 , "Cannot stake 0");
        _totalSupply += amount;
        _userbalance[msg.sender] += amount;
        stakingToken.transferFrom(msg.sender , address(this) , amount);
    }
    function withdraw(uint amount ) external nonReentrant updateReward(msg.sender){  //para çekmek.
        _totalSupply -= amount;
        _userbalance[msg.sender] -= amount;
        stakingToken.transfer(msg.sender , amount);
    }
    function getReward() external nonReentrant updateReward (msg.sender){
        uint reward = rewards[msg.sender];
        if (reward > 0) {
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
        }

    }


















}
