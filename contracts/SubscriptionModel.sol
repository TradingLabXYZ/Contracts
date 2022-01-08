//  Possibility to subscribe
//   get latest price is USD/MOON
//   At the beginning subscription only monthly
//   Check is already subscribed? 

// Possibility to check if addressA is subscribed with addressB
// Possibility to get list of all subscribers of a particular address

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SubscriptionModel {

  // STRUCTS
  struct Subscription {
    uint Createdat;
    uint Endedat;
    uint Amount;
  }

  // VARIABLES
  mapping (address => uint) public plans;
  mapping (address => mapping (address => Subscription)) public subscriptions;

  // EVENTS
  event ChangePlan(
    address sender,
    uint value
  );

  event Subscribe(
    address sender,
    address to,
    uint createdat,
    uint endedat,
    uint amount
  );
    
  // TRANSACTIONS
  function changePlan(uint usdc_monthly_price) public {
    require(
      msg.sender.balance > 0,
      "Balance is not enough."
    );
    require(
      usdc_monthly_price > 0, 
      "USDC price must be bigger than 0."
    );
    require(
      usdc_monthly_price != plans[msg.sender], 
      "USDC price must be different than current one."
    );
    plans[msg.sender] = usdc_monthly_price; 
    emit ChangePlan(
      msg.sender,
      usdc_monthly_price
    );
  }

  function subscribe(address to) public {
    uint currentTimestamp = block.timestamp;
    require(
      plans[to] > 0,
      "Address is not accepting subscriptions."
    );
    require(
      subscriptions[to][msg.sender].Endedat < currentTimestamp,
      "There is a running subscription"
    );
    uint endedat = currentTimestamp + (30 * 1 days);
    Subscription memory subscription = Subscription({
      Createdat: currentTimestamp,
      Endedat: currentTimestamp + (30 * 1 days),
      Amount: plans[to]
    });
    subscriptions[to][msg.sender] = subscription;
    emit Subscribe(
      msg.sender,
      to,
      currentTimestamp,
      endedat,
      plans[to]
    );
  }

  // CALLS
  function getPlan() public view returns (uint) {
    return plans[msg.sender];
  }

  function isSubscriber(address to) public view returns(bool) {
    uint currentTimestamp = block.timestamp;
    uint endedat = subscriptions[to][msg.sender].Endedat;
    return endedat > currentTimestamp;
  }

  function subscriptionEndedAt(address to) public view returns(uint) {
    return subscriptions[to][msg.sender].Endedat;
  }

}
