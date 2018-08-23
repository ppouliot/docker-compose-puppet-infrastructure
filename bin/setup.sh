#!/usr/bin/env bash

base_dir=`pwd`
echo "Please enter the path to your sh key files"
read sshkeys

git clone git@github.com:ppouliot/secure
mkdir -p /opt/puppet
cd /opt/puppet
git clone https://github.com/rnelson0/puppet-generate-puppetfile
git clone https://github.com/camptocamp/puppetfile-updater
git clone https://github.com/dcosson/r10kdiff
git clone https://github.com/pzim/reaktor
git clone https://github.com/alister/guard-puppet-lint
git clone https://github.com/camptocamp/puppet-ghostbuster
git clone https://github.com/voxpupuli/pypuppetdb
cd $base_dir
docker-compose up -d ;
docker exec -t puppet sh -c 'puppetserver gem install msgpack'
docker exec -t puppet sh -c 'gem install generate-puppetfile ra10ke hiera-eyaml slack-notifier'
docker exec -t puppet sh -c 'mkdir -p /etc/puppetlabs/r10k'
docker exec -t puppet sh -c 'mv /etc/puppetlabs/code/environments/production /etc/puppetlabs/code/environments/production.orig'
docker cp ./hiera.yaml puppet:/etc/puppetlabs/hiera.yaml
docker cp ./r10k.yaml puppet:/etc/puppetlabs/r10k/r10k.yaml
docker cp $sshkeys puppet:/root/

