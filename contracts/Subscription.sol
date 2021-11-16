// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Subscription {

  // VARIABLES
  mapping (address => uint) public plans;

  // EVENTS
  event ChangePlan(
    address sender,
    uint value
  );
    
  // TRANSACTIONS

  function changePlan(uint usdc_monthly_price) public {
    plans[msg.sender] = usdc_monthly_price; 
    emit ChangePlan(msg.sender, usdc_monthly_price);
  }

  // CALLS
  function getPlan() public view returns (uint) {
    return plans[msg.sender];
  }

}
