var fs = require('fs');
const contract = require("truffle-contract");
const artifacts = require('../build/contracts/SubscriptionModel.json')
let SubscriptionModel = contract(artifacts);
SubscriptionModel.setProvider('http://localhost:9933')
SubscriptionModel.deployed().then(
  function(value) {
    let events = [];
    for (var event_id in value.constructor.events) {
      events.push({
        signature: event_id,
        name: value.constructor.events[event_id]['name']
      });
    }
    let output = {
      contract: value.address,
      event: events
    };
    let data = JSON.stringify(output);
    fs.writeFile('./scripts/subscription_info.json', data, function(err) {
      if (err) throw err;
      console.log('complete');
    })
  }
)
