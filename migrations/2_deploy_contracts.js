var Subscription = artifacts.require("Subscription");
var Store = artifacts.require("Store");

module.exports = function(deployer) {
  deployer.deploy(Subscription);
  deployer.deploy(Store);
};
