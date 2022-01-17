// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract PlansStorage {

  // STRUCTS
  struct Plan {
    uint index;
    uint value;
 }

  // MAPS
  mapping (address => Plan) public plans;

  // VARIABLES
  address owner;
  address[] internal keyList;
  address allowedContract;

  // CONSTRUCTOR
  constructor ()  {
    owner = msg.sender;
  }

  // MODIFIER
  modifier onOw() {
    require(
      msg.sender == owner,
      "Not owner."
    );
    _;
  }

  modifier onCo() {
    require(
      msg.sender  == allowedContract,
      "Not allowedContract.");
    _;
  }

  // FUNCTIONS CONTRACT
  function getAllowedContract() public onOw view returns (address) {
    return allowedContract;
  }    

  function updateAllowedContract(address _key) public onOw {
    allowedContract = _key;
  }

  // FUNCTION PLANS
  function addPlan(address _key, uint _value) public onCo {
    Plan storage plan = plans[_key];
    plan.value = _value;
    if(plan.index > 0) {
      return;
    } else {
      keyList.push(_key);
      uint keyListIndex = keyList.length - 1;
      plan.index = keyListIndex + 1;
    }
  }

  function removePlan(address _key) public onCo {
    Plan storage plan = plans[_key];
    require(plan.index != 0);
    require(plan.index <= keyList.length);
    uint keyListIndex = plan.index - 1;
    uint keyListLastIndex = keyList.length - 1;
    plans[keyList[keyListLastIndex]].index = keyListIndex + 1;
    keyList[keyListIndex] = keyList[keyListLastIndex];
    keyList.pop();
    delete plans[_key];
  }

  function sizePlans() public onCo view returns (uint) {
    return uint(keyList.length);
  }

  function containsPlan(address _key) public onCo view returns (bool) {
    return plans[_key].index > 0;
  }

  function getPlanByAddress(address _key) public onCo view returns (uint) {
    return plans[_key].value;
  }

  function getPlanByIndex(uint _index) public onCo view returns (uint) {
    require(_index >= 0);
    require(_index < keyList.length);
    return plans[keyList[_index]].value;
  }

  function getPlans() public onCo view returns (address[] memory) {
    return keyList;
  }
}
