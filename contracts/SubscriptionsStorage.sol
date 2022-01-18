// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SubscriptionsStorage {

  // STRUCTS
  struct Subscription {
    uint Index;
    uint Createdat;
    uint Endedat;
    uint Amount;
  }

  // MAPS
  mapping (
    address => mapping (
      address => Subscription
  )) public subscriptions;

  mapping (address => uint) subscribers;

  // VARIABLES
  address owner;
  address allowedContract;
  address[] internal keyList;

  // CONSTRUCTOR
  constructor ()  {
    owner = msg.sender;
  }

  // MODIFIER
  modifier onAllow() {
    require(
      msg.sender == owner || msg.sender == allowedContract,
      "Not allowed."
    );
    _;
  }
  
  // TRANSACTION CONTRACT
  function updateAllowedContract(address _key) public onAllow {
    allowedContract = _key;
  }

  // CALL CONTRACT
  function getAllowedContract() public onAllow view returns (address) {
    return allowedContract;
  }    

  // TRANSACTIONS
  function addSubscription(
    address _from, 
    address _to, 
    uint _amount, 
    uint _weeks) public onAllow {
    Subscription storage subscription = subscriptions[_from][_to];
    uint currentTimestamp = block.timestamp;
    subscription.Createdat = currentTimestamp;
    subscription.Endedat = currentTimestamp + (_weeks * 1 weeks);
    subscription.Amount = _amount;
    if(subscription.Index > 0) {
      return;
    } else {
      keyList.push(_from);
      uint keyListIndex = keyList.length - 1;
      subscription.Index = keyListIndex + 1;
      subscribers[_from] = subscribers[_from] + 1;
    }
  }

  // CALLS
  function sizeSubscriptions() public onAllow view returns (uint) {
    return uint(keyList.length);
  }

  function getSubscriptors() public onAllow view returns (address[] memory) {
    return keyList;
  }

  function getSubscription(address _from, address _to) public onAllow view returns (Subscription memory) {
    return subscriptions[_from][_to];
  }

  function getCountSubscriptionsBySubscriptor(address _from) public onAllow view returns (uint) {
    return subscribers[_from];
  }
}
