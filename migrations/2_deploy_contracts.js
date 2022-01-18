var SubscriptionsStorage = artifacts.require("SubscriptionsStorage");
var PlansStorage = artifacts.require("PlansStorage");
var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = function(deployer) {
  deployer.deploy(PlansStorage).then(function() {
    return deployer.deploy(SubscriptionsStorage).then(function() {
      return deployer.deploy(
        SubscriptionModel,
        SubscriptionsStorage.address,
        PlansStorage.address
      )
    });
  }).then(function() {});
};
