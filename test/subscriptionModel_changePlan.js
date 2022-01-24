const SubscriptionModel = artifacts.require("SubscriptionModel");
const PlansStorage = artifacts.require("PlansStorage");
const truffleAssert = require('truffle-assertions');

contract("SubscriptionModel", accounts => {
  it("changePlan but fails because incorrect price", async () => {
    var sSm = await SubscriptionModel.deployed();
    let firstErr = null;
    try {
      await sSm.changePlan(0);
    } catch (error) {
      firstErr = error;
    }
    assert.ok(firstErr instanceof Error)
    let secondErr = null;
    try {
      await sSm.changePlan(-2);
    } catch (error) {
      secondErr = error;
    }
    assert.ok(secondErr instanceof Error)
  });
  it("changePlan twice but second fail because same price", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(2);
    try {
      await sSm.changePlan(2);
    } catch (error) {
      secondErr = error;
    }
    assert.ok(secondErr instanceof Error)
  });
  it("changePlan correctly", async () => {
    var sSm = await SubscriptionModel.deployed();
    await sSm.changePlan(4);
    var pSo = await PlansStorage.deployed();
    var planByAddress = await pSo.getPlanByAddress(accounts[0]);
    assert.equal(planByAddress, 4);
  })
  it("changePlan emits event", async () => {
    var sSm = await SubscriptionModel.deployed();
    var tx = await sSm.changePlan(6);
    truffleAssert.eventEmitted(tx, 'ChangePlan', (event) => {
      return event.value == 6 && event.sender == accounts[0];
    });
  })
})
