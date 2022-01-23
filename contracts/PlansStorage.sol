// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PlansStorage {

  // STRUCTS
  struct Plan {
    uint Index;
    uint Value;
 }

  // MAPS
  mapping (address => Plan) public plans;

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
  function addPlan(address _key, uint _value) public onAllow {
    Plan storage plan = plans[_key];
    plan.Value = _value;
    if(plan.Index > 0) {
      return;
    } else {
      keyList.push(_key);
      uint keyListIndex = keyList.length - 1;
      plan.Index = keyListIndex + 1;
    }
  }

  function removePlan(address _key) public onAllow {
    Plan storage plan = plans[_key];
    require(plan.Index != 0);
    require(plan.Index <= keyList.length);
    uint keyListIndex = plan.Index - 1;
    uint keyListLastIndex = keyList.length - 1;
    plans[keyList[keyListLastIndex]].Index = keyListIndex + 1;
    keyList[keyListIndex] = keyList[keyListLastIndex];
    keyList.pop();
    delete plans[_key];
  }

  // CALLS
  function getSizePlans() public onAllow view returns (uint) {
    return uint(keyList.length);
  }

  function containsPlan(address _key) public onAllow view returns (bool) {
    return plans[_key].Index > 0;
  }

  function getPlanByAddress(address _key) public onAllow view returns (uint) {
    return plans[_key].Value;
  }

  function getPlanByIndex(uint _index) public onAllow view returns (uint) {
    require(_index >= 0);
    require(_index < keyList.length);
    return plans[keyList[_index]].Value;
  }

  function getPlans() public onAllow view returns (address[] memory) {
    return keyList;
  }
}
