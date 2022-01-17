var PlansStorage = artifacts.require("PlansStorage");
var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = function(deployer) {
  deployer.deploy(PlansStorage).then(function() {
    return deployer.deploy(SubscriptionModel, PlansStorage.address);
  }).then(function() {});
};
