// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockedWithdrawal  {
    // state variables
    address public owner;
    uint256 public unlockTime;

    event Deposited(address indexed from, uint256 amount);
    event WithDrawn(address indexed to, uint256 amount);

    //modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "You are Not an owner");
        _;
    }

    constructor(uint256 _unlockTime) {
        require(_unlockTime > block.timestamp, "Unlock time Must be future");
        owner = msg.sender;
        unlockTime = _unlockTime;
    }

    // Deposit function
    function deposit() external payable {
        require(msg.value > 0, "No Eth sent");
        emit Deposited(msg.sender, msg.value);
    }

    // withdraw function
    function WithDraw() external onlyOwner {
        require(block.timestamp >= unlockTime, "funds are locked");
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");

        emit WithDrawn(owner, balance);
    }
}
