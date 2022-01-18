// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./SubscriptionsStorage.sol";
import "./PlansStorage.sol";

contract SubscriptionModel {

  // VARIABLES
  uint TLPERCENTAGE = 40;
  address tlAddress = 0x71398cAD63b47Db2E2b00b68a709b64DF98E5A29;
  address payable tlWallet = payable(tlAddress);

  // EVENTS
  event ChangePlan(
    address sender,
    uint value
  );

  event Subscribe(
    address sender,
    address to,
    uint createdat,
    uint weeks,
    uint amount
  );

  // CONSTRUCTOR
  SubscriptionsStorage iSub;
  PlansStorage iPlans;
  constructor(
    address _subscriptionStorageAddress,
    address _planStorageAddress) {
    iSub = SubscriptionsStorage(_subscriptionStorageAddress);
    iPlans = PlansStorage(_planStorageAddress);
  }
    
  // TRANSACTIONS
  function changePlan(uint _price) public {
    require(
      msg.sender.balance > 0,
      "Balance is not enough."
    );
    require(
      _price > 0, 
      "USDC price must be bigger than 0."
    );
    require(
      _price != iPlans.getPlanByAddress(msg.sender), 
      "USDC price must be different than current one."
    );
    iPlans.addPlan(msg.sender, _price);
    emit ChangePlan(
      msg.sender,
      _price
    );
  }

  function subscribe(address payable _to, uint _weeks) public payable {
    uint currentTimestamp = block.timestamp;
    uint plan = iPlans.getPlanByAddress(_to);
    require(
      plan > 0,
      "Address is not accepting subscriptions."
    );
    require(
      iSub.getSubscription(
        _to,
        msg.sender
      ).Endedat < currentTimestamp,
      "There is a running subscription"
    );
    iSub.addSubscription(
      _to,
      msg.sender,
      plan,
      _weeks
    );
    emit Subscribe(
      msg.sender,
      _to,
      currentTimestamp,
      _weeks,
      plan
    );
    uint valueTL = msg.value * 40 / 100;
    tlWallet.transfer(valueTL);
    _to.transfer(msg.value - valueTL);
  }
}
