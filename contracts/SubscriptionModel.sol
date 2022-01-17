// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PlansStorage.sol";

contract SubscriptionModel {

  // STRUCTS
  struct Subscription {
    uint Createdat;
    uint Endedat;
    uint Amount;
  }

  // VARIABLES
  uint TLPERCENTAGE = 40;
  address tlAddress = 0x71398cAD63b47Db2E2b00b68a709b64DF98E5A29;
  address payable tlWallet = payable(tlAddress);

  // MAPS
  mapping (
    address => mapping (
      address => Subscription
  )) public subscriptions;

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

  // CONSTRUCTOR
  PlansStorage instancePlansStorage;
  constructor(address _planStorageAddress) {
    instancePlansStorage = PlansStorage(_planStorageAddress);
  }
    
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
    // require(
    //   usdc_monthly_price != plans[msg.sender], 
    //   "USDC price must be different than current one."
    // );
    instancePlansStorage.addPlan(msg.sender, usdc_monthly_price);
    // plans[msg.sender] = usdc_monthly_price; 
    emit ChangePlan(
      msg.sender,
      usdc_monthly_price
    );
  }

  // function subscribe(address payable to) public payable {
  //   uint currentTimestamp = block.timestamp;
  //   require(
  //     plans[to] > 0,
  //     "Address is not accepting subscriptions."
  //   );
  //   require(
  //     subscriptions[to][msg.sender].Endedat < currentTimestamp,
  //     "There is a running subscription"
  //   );
  //   uint endedat = currentTimestamp + (30 * 1 days);
  //   Subscription memory subscription = Subscription({
  //     Createdat: currentTimestamp,
  //     Endedat: currentTimestamp + (30 * 1 days),
  //     Amount: plans[to]
  //   });
  //   subscriptions[to][msg.sender] = subscription;
  //   emit Subscribe(
  //     msg.sender,
  //     to,
  //     currentTimestamp,
  //     endedat,
  //     plans[to]
  //   );

  //   uint valueTL = msg.value * 40 / 100;
  //   tlWallet.transfer(valueTL);
  //   to.transfer(msg.value - valueTL);
  // }

  // // CALLS
  // function getPlan() public view returns (uint) {
  //   return plans[msg.sender];
  // }

  // function isSubscriber(address to) public view returns(bool) {
  //   uint currentTimestamp = block.timestamp;
  //   uint endedat = subscriptions[to][msg.sender].Endedat;
  //   return endedat > currentTimestamp;
  // }

  // function subscriptionEndedAt(address to) public view returns(uint) {
  //   return subscriptions[to][msg.sender].Endedat;
  // }

}
