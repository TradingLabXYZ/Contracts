# Useful commands

TODO: explain the process in details

## To run a moonbeam blockchain instance

'''shell

truffle unbox PureStake/moonbeam-truffle-box

systemctl stop docker && systemctl start docker

truffle run moonbeam start

docker logs -f <container_id>

'''

## To deploy and update BackEnd and Fronend

'''shell

./manage_deploy.sh

'''
