#!/usr/bin/env bash
docker run -it -v $(pwd)/r10k/r10k.yaml:/etc/puppetlabs/r10k/r10k.yaml -v $(pwd)/r10k/cache:/var/cache/r10k -v $(pwd)/secure:/etc/puppetlabs/puppet/secure -v $(pwd)/code/environments/production/Puppetfile:/Puppetfile vladgh/r10k puppetfile install --verbose DEBUG2
