pragma solidity ^0.8.7;

contract Store {
  event ItemSet(string key, string value);

  mapping (string => string) public items;

  function setItem(string memory key, string memory value) external {
    items[key] = value;
    emit ItemSet(key, value);
  }
}
