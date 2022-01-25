var SubscriptionsStorage = artifacts.require("SubscriptionsStorage");
var PlansStorage = artifacts.require("PlansStorage");
var SubscriptionModel = artifacts.require("SubscriptionModel");

module.exports = async function(deployer, network, accounts) {
  await deployer.deploy(SubscriptionsStorage);
  await deployer.deploy(PlansStorage);
  await deployer.deploy(
    SubscriptionModel,
    SubscriptionsStorage.address,
    PlansStorage.address
  );
  var sSt = await SubscriptionsStorage.deployed();
  sSt.updateAllowedContract(SubscriptionModel.address);
  var pSt = await PlansStorage.deployed();
  pSt.updateAllowedContract(SubscriptionModel.address);
};
