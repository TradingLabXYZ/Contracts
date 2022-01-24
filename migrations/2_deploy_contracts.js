var SubscriptionsStorage = artifacts.require("SubscriptionsStorage");
var PlansStorage = artifacts.require("PlansStorage");
var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = async function(deployer, network, accounts) {
  let instanceSS = await deployer.deploy(SubscriptionsStorage);
  let instancePS = await deployer.deploy(PlansStorage);
  let instanceSM = await deployer.deploy(
    SubscriptionModel,
    SubscriptionsStorage.address,
    PlansStorage.address
  );
  instanceSS.updateAllowedContract(instanceSM.address);
  instancePS.updateAllowedContract(instanceSM.address);
};
