var SubscriptionsStorage = artifacts.require("SubscriptionsStorage");
var PlansStorage = artifacts.require("PlansStorage");
var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(PlansStorage).then(function(instancePS) {
    return deployer.deploy(SubscriptionsStorage).then(function(instanceSS) {
      return deployer.deploy(
        SubscriptionModel,
        SubscriptionsStorage.address,
        PlansStorage.address
      ).then(function(instanceSM) {
        instancePS.updateAllowedContract(instanceSM.address);
        instanceSS.updateAllowedContract(instanceSM.address);
      })
    });
  })
};
