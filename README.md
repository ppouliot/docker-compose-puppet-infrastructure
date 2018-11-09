# docker-compose-puppet-infrastructure
Docker Compose to run puppet infrastructure with useful modules and a control repo.
## Goal
The goal of this is to stand up a working puppet infrastructure that
dynamically connects to and deploys a control repo via r10k.

Currently the following is deployed as part of this puppet stack.

* puppetserver
* puppet-agetnt
* puppetdb
* puppetboard
* puppetexplorer
* puppet-catalog-diff-viewer

## Basic Operations

* Basic Startup without customization

```
docker-compose pull
docker-compose up -d
```

* Basic Startup with customizations

```
bin/setup.sh
```


* List Registered puppet agent certificates

```
docker exec -t puppet sh -c 'puppetserver ca list --all'
```

* Clear a puppet agent certificate

```
docker exec -t puppet sh -c 'puppetserver ca clean --certname myserver.contoso.ltd'
```

* To Run r10k to update puppet modules

```
docker exec -t puppet sh -c 'cd /etc/puppetlabs/code/environments/production && r10k puppetfile install --verbose DEBUG2'
```
