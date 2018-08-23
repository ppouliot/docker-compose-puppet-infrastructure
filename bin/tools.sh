#!/usr/bin/env bash

base_dir=`pwd`

git clone git@github.com:ppouliot/secure
mkdir -p /opt/puppet
cd /opt/puppet
git clone https://github.com/rnelson0/puppet-generate-puppetfile
git clone https://github.com/camptocamp/puppetfile-updater
git clone https://github.com/dcosson/r10kdiff
git clone https://github.com/camptocamp/puppet-catalog-diff-viewer
git clone https://github.com/pzim/reaktor
git clone https://github.com/alister/guard-puppet-lint
git clone https://github.com/camptocamp/puppet-ghostbuster
git clone https://github.com/voxpupuli/pypuppetdb
cd $base_dir
