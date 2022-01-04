var fs = require('fs');
const contract = require("truffle-contract");
const artifacts = require('../build/contracts/Subscription.json')
let Subscription = contract(artifacts);
Subscription.setProvider('http://localhost:9933')
Subscription.deployed().then(
  function(value) {
    let output = {
      contract: value.address,
      event: value.constructor.events
    };
    let data = JSON.stringify(output);
    fs.writeFile('./scripts/subscription_info.json', data, function(err) {
      if (err) throw err;
      console.log('complete');
    })
  }
)
