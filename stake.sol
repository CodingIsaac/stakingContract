// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;  

/**
a staking contract to perform the following:
1. To accept deposit into the contract.
2. Not allow staking of 0 balance.
3. include a timestamp on when to withdraw.
4. include only stakers function
5. mapping of amount to address.
6. create a function to show the balance of the contract.

*/

contract StakingContract {
    mapping(address => uint) stakingBalance;
    uint public deadline = block.timestamp - 20 minutes;
    event Stake(address indexed sender, uint amount);

function stakeTokens() public payable {
    require(msg.value > 0, "You cannot stake Zero Ether");
    stakingBalance[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
}

function withdrawToken() public  {
    require(block.timestamp > deadline, "Due date not reached");
    require(stakingBalance[msg.sender] > 0, "Insufficient stake");
    uint value = stakingBalance[msg.sender];
    stakingBalance[msg.sender] = 0;
    payable(msg.sender).transfer(value);

    
    
}
receive () external payable {
    stakeTokens();

}

fallback () external payable {

}
function getTotalBalance() public view returns(uint) {
    return stakingBalance[msg.sender];
}

function getTimeLeft() external view returns(uint) {
    return deadline - block.timestamp;
}



}
