const SubscriptionsStorage = artifacts.require("SubscriptionsStorage");

contract("SubscriptionsStorage", accounts => {
  var mainAccount = accounts[0];
  it("updates allowed contract", async () => {
    var sSo = await SubscriptionsStorage.deployed();
    await sSo.updateAllowedContract(mainAccount);
    var newAllowedContract = await sSo.getAllowedContract();
    assert.equal(mainAccount, newAllowedContract);
  });
  it("adds subscription", async () => {
    var sSo = await SubscriptionsStorage.deployed();
    var tempFrom = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
    var tempTo = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
    var tempAmount = 10;
    var tempWeeks = 5;
    await sSo.addSubscription(tempFrom, tempTo, tempAmount, tempWeeks); 
    var subscription = await sSo.getSubscription(tempFrom, tempTo);
    assert.equal(subscription.Amount, 10);
    var secondsDifference = (subscription.Endedat - subscription.Createdat);
    var daysDifference = secondsDifference / 60 / 60 / 24;
    assert.equal(daysDifference, 35);
    var sizeSubscriptions = await sSo.getSizeSubscriptions();
    assert.equal(sizeSubscriptions, 1);
    var subscriptors = await sSo.getSubscriptors();
    assert.equal(subscriptors[0].toLowerCase(), tempFrom);
    var countSubscriptions = await sSo.getCountSubscriptionsBySubscriptor(tempFrom);
    assert.equal(countSubscriptions, 1);
  });
  it("exceutes subscribe but not allowed", async () => {
    let tempAccount = accounts[1];
    var sSo = await SubscriptionsStorage.deployed();
    let err = null;
    try {
      var tempFrom = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
      var tempTo = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
      var tempAmount = 10;
      var tempWeeks = 5;
      await sSo.addSubscription(
        tempFrom,
        tempTo,
        tempAmount,
        tempWeeks,
        {from: tempAccount}
      ); 
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
})
