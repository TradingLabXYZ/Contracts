var fs = require('fs');
const contract = require("truffle-contract");
const artifacts = require('../build/contracts/Subscription.json')
let Subscription = contract(artifacts);
Subscription.setProvider('http://localhost:9933')
Subscription.deployed().then(
  function(value) {
    let events = value.constructor.events;
    let data = JSON.stringify(events);
    fs.writeFileSync('./scripts/subscription_events.json', data);
  }
);
