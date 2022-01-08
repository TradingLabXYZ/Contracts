#/bin/sh
truffle migrate --network dev --reset
truffle run abigen SubscriptionModel
node scripts/extract_contract_info.js

# Contract JSON to frontend
cp build/contracts/SubscriptionModel.json $HOME/Code/TradingLab/WebFront/src/functions

# Abigen to backend
cp $HOME/Code/TradingLab/Contracts/abigenBindings/abi/SubscriptionModel.abi $HOME/Code/TradingLab/WebBack/contracts

# Events to backend
cp $HOME/Code/TradingLab/Contracts/scripts/subscription_info.json $HOME/Code/TradingLab/WebBack/contracts
