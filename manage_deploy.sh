#/bin/sh
truffle migrate --network dev --reset

echo "Processing PlansStorage"
solcjs --abi contracts/PlansStorage.sol > PlansStorage.abi
solcjs --bin contracts/PlansStorage.sol > PlansStorage.bin
mv contracts_PlansStorage_sol_PlansStorage.abi ./abi/PlansStorage.abi
mv contracts_PlansStorage_sol_PlansStorage.bin ./bin/PlansStorage.bin
rm PlansStorage.abi PlansStorage.bin
abigen --bin=./bin/PlansStorage.bin --abi=./abi/PlansStorage.abi --pkg=plansStorage --out=./golang/ContractPlansStorage.go
cp ./golang/ContractPlansStorage.go /home/dolphin/Code/TradingLab/WebBack

echo "Processing SubscriptionStorage"
solcjs --abi contracts/SubscriptionsStorage.sol > SubscriptionsStorage.abi
solcjs --bin contracts/SubscriptionsStorage.sol > SubscriptionsStorage.bin
mv contracts_SubscriptionsStorage_sol_SubscriptionsStorage.abi ./abi/SubscriptionsStorage.abi
mv contracts_SubscriptionsStorage_sol_SubscriptionsStorage.bin ./bin/SubscriptionsStorage.bin
rm SubscriptionsStorage.abi SubscriptionsStorage.bin
abigen --bin=./bin/SubscriptionsStorage.bin --abi=./abi/SubscriptionsStorage.abi --pkg=subscriptionsStorage --out=./golang/ContractSubscriptionsStorage.go
cp ./golang/ContractSubscriptionsStorage.go /home/dolphin/Code/TradingLab/WebBack

echo "Processing SubscriptionModel"
solcjs --abi contracts/SubscriptionModel.sol > SubscriptionModel.abi
solcjs --bin contracts/SubscriptionModel.sol > SubscriptionModel.bin
mv contracts_SubscriptionModel_sol_SubscriptionModel.abi ./abi/SubscriptionModel.abi
mv contracts_SubscriptionModel_sol_SubscriptionModel.bin ./bin/SubscriptionModel.bin
rm SubscriptionModel.abi SubscriptionModel.bin
abigen --bin=./bin/SubscriptionsStorage.bin --abi=./abi/SubscriptionsStorage.abi --pkg=subscriptionModel --out=./golang/ContractSubscriptionModel.go
cp ./golang/ContractSubscriptionModel.go /home/dolphin/Code/TradingLab/WebBack

rm -rf contracts_*
