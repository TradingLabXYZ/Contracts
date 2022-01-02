//  Possibility to subscribe
//   get latest price is USD/MOON
//   At the beginning subscription only monthly
//   Check is already subscribed? 

// Possibility to check if addressA is subscribed with addressB
// Possibility to get list of all subscribers of a particular address

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Subscription {

  // STRUCTS
  struct Subscriber { 
    address To;
    uint Createdat;
  }

  // VARIABLES
  mapping (address => uint) public plans;
  mapping (address => Subscriber[]) public subscriptions;

  // EVENTS
  event ChangePlan(
    address sender,
    uint value
  );

  event Subscribe(
    address sender,
    address to
  );
    
  // TRANSACTIONS
  function changePlan(uint usdc_monthly_price) public {
    require(
      usdc_monthly_price > 0, 
      "USDC price must be bigger than 0."
    );
    require(
      usdc_monthly_price != plans[msg.sender], 
      "USDC price must be different than current one."
    );
    plans[msg.sender] = usdc_monthly_price; 
    emit ChangePlan(msg.sender, usdc_monthly_price);
  }

  function subscribe(address to) public {
    Subscriber memory subscriber = Subscriber(to, block.timestamp);
    subscriptions[to].push(subscriber);
    emit Subscribe(msg.sender, to);
  }

  // CALLS
  function getPlan() public view returns (uint) {
    return plans[msg.sender];
  }

}
