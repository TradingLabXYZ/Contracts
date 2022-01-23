const PlansStorage = artifacts.require("PlansStorage");

contract("PlansStorage", accounts => {
  var mainAccount = accounts[0];
  it("updates allowed contract", async () => {
    var pSo = await PlansStorage.deployed();
    await pSo.updateAllowedContract(mainAccount);
    var newAllowedContract = await pSo.getAllowedContract();
    assert.equal(mainAccount, newAllowedContract);
  });
  it("adds plan", async () => {
    var pSo = await PlansStorage.deployed();
    var tempWallet = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
    await pSo.addPlan(tempWallet, 10); 
    var plans = await pSo.getPlans();
    assert.equal(plans[0].toLowerCase(), tempWallet);
    var sizePlans = await pSo.getSizePlans();
    assert.equal(sizePlans, 1);
    var containsPlan = await pSo.containsPlan(tempWallet);
    assert.equal(containsPlan, true);
    var planByAddress = await pSo.getPlanByAddress(tempWallet);
    assert.equal(planByAddress, 10);
    var planByIndex = await pSo.getPlanByIndex(0);
    assert.equal(planByIndex, 10);
  });
  it("removes plan", async () => {
    var pSo = await PlansStorage.deployed();
    var tempWallet = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
    await pSo.removePlan(tempWallet);
    var plans = await pSo.getPlans();
    assert.equal(plans.length, 0);
    var sizePlans = await pSo.getSizePlans();
    assert.equal(sizePlans, 0);
    var containsPlan = await pSo.containsPlan(tempWallet);
    assert.equal(containsPlan, false);
  });
  it("updates plan", async () => {
    var pSo = await PlansStorage.deployed();
    var tempWallet = "0xab5801a7d398351b8be11c439e05c5b3259aec9b";
    await pSo.addPlan(tempWallet, 10); 
    var planByAddress = await pSo.getPlanByAddress(tempWallet);
    assert.equal(planByAddress, 10);
    await pSo.addPlan(tempWallet, 99);
    var newPlanByAddress = await pSo.getPlanByAddress(tempWallet);
    assert.equal(newPlanByAddress, 99);
  });
  it("exceutes addPlan but not allowed", async () => {
    let tempAccount = accounts[1];
    var pSo = await PlansStorage.deployed();
    let err = null;
    try {
      await pSo.addPlan(tempAccount, 10, {from: tempAccount});
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("exceutes removePlan but not allowed", async () => {
    let tempAccount = accounts[1];
    var pSo = await PlansStorage.deployed();
    let err = null;
    try {
      await pSo.removePlan(tempAccount, {from: tempAccount});
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
  it("exceutes getPlans but not allowed", async () => {
    let tempAccount = accounts[1];
    var pSo = await PlansStorage.deployed();
    let err = null;
    try {
      await pSo.getPlans({from: tempAccount});
    } catch (error) {
      err = error;
    }
    assert.ok(err instanceof Error)
  });
})
