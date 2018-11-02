#!/usr/bin/env bash
export PRIVATE_KEY="$(cat ./secure/ci.keys.d/rsa)"
docker run -v ./code:/etc/puppetlabs/code -e REPOSITORY="git@github.rakops.com:raklab/raklab-control-repo.git" -e PRIVATE_KEY="$PRIVATE_KEY" grahamgilbert/r10k
