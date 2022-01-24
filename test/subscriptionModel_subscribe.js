const SubscriptionModel = artifacts.require("SubscriptionModel");
const SubscriptionsStorage = artifacts.require("SubscriptionsStorage");
const truffleAssert = require('truffle-assertions');

contract("SubscriptionModel", accounts => {
  it("fails because subscriber and subscriptor are identical", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(444, {from: accounts[5]});
    let err = null;
    try {
      await sSm.subscribe(accounts[5], 4, {from: accounts[5]});
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("fails because account does not accept subscriptions", async () => {
    var sSm = await SubscriptionModel.deployed();
    let err = null;
    try {
      await sSm.subscribe(accounts[6], 10);
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("fails because negative weeks", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(124);
    let err = null;
    try {
      await sSm.subscribe(accounts[0], -10);
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("fails because already running subscription", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(736, {from: accounts[1]});
    await sSm.subscribe(accounts[1], 10);
    let err = null;
    try {
      await sSm.subscribe(accounts[1], 11);
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("successfully create subscription", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(999, {from: accounts[4]});
    await sSm.subscribe(accounts[4], 10, {from: accounts[3]});
    var sSo = await SubscriptionsStorage.deployed();
    var subscription = await sSo.getSubscription(accounts[4], accounts[3]);
    assert.equal(subscription.Amount, 999);
  });
  it("subscribe emits event", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(888, {from: accounts[6]});
    var tx = await sSm.subscribe(accounts[6], 10, {from: accounts[7]});
    truffleAssert.eventEmitted(tx, 'Subscribe', (event) => {
      return (
        event.sender == accounts[7] &&
        event.to == accounts[6] &&
        event.amount == 888
      );
    });
  })
})
