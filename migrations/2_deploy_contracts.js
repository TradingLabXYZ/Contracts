var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = function(deployer) {
  deployer.deploy(SubscriptionModel);
};
