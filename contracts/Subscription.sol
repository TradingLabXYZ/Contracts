//  Possibility to change monthly fee
//    Needs to be bigger than 0
//    Needs to be different than current one
//    is it in USDC or MVRN?
//  Possibility to subscribe
//   get latest price is USD/MOON
//   At the beginning subscription only monthly
//   Check is already subscribed? 

// Possibility to check if addressA is subscribed with addressB
// Possibility to get list of all subscribers of a particular address

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

  /**
    function subscribe(to address) public {
      require ...
      if !isAlreadySubscribed() {

     }
    }
  */

  function changePlan(uint usdc_monthly_price) public {
    plans[msg.sender] = usdc_monthly_price; 
    emit ChangePlan(msg.sender, usdc_monthly_price);
  }

  // CALLS
  function getPlan() public view returns (uint) {
    return plans[msg.sender];
  }

}
