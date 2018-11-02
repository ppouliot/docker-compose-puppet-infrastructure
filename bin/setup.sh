#!/usr/bin/env bash

docker-compose pull

base_dir=`pwd`
echo "Please enter the path to your sh key files"
read sshkeys

git clone git@github.com:ppouliot/secure
cd code/environments/
docker-compose up -d ;
sleep 300
docker exec -t puppet sh -c 'puppetserver gem install msgpack'
sleep 60
docker exec -t puppet sh -c '/opt/puppetlabs/server/bin/puppetserver gem install msgpack CFPropertyList generate-puppetfile ra10ke hiera-eyaml slack-notifier minitar-cli'
sleep 60
docker exec -t puppet sh -c 'mkdir -p /etc/puppetlabs/r10k'
docker exec -t puppet sh -c 'mv /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/production.orig'
docker cp ./hiera.yaml puppet:/etc/puppetlabs/hiera.yaml
docker cp ./r10k/r10k.yaml puppet:/etc/puppetlabs/r10k/r10k.yaml
docker cp $sshkeys puppet:/root/
docker exec -t puppet sh -c 'cd /etc/puppetlabs/code/environments/production && r10k puppetfile install --verbose DEBUG2'
