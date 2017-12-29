#!/usr/bin/env bash
echo "Please enter the path to your sh key files"
read sshkeys


docker-compose up -d ;
docker exec -it puppet sh -c 'puppetserver gem install msgpack'
docker exec -it puppet sh -c 'gem install generate-puppetfile ra10ke hiera-eyaml slack-notifier'
docker exec -it puppet sh -c 'mkdir -p /etc/puppetlabs/r10k'
docker cp ./hiera.yaml puppet:/etc/puppetlabs/hiera.yaml
docker cp ./r10k.yaml puppet:/etc/puppetlabs/r10k/r10k.yaml
docker cp $sshkeys puppet:/root/

