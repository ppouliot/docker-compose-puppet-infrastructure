# docker-compose-puppet-infrastructure
Docker Compose to run puppet infrastructure with useful modules and a control repo.
## Goal
The goal of this is to stand up a working puppet infrastructure that
dynamically connects to and deploys a control repo via r10k.

## Basic Operations


* List Registered puppet agent certificates

```
docker exec -t puppet sh -c 'puppet cert list --all'
```

* Clear a puppet agent certificate

```
docker exec -t puppet sh -c 'puppet cert clean myserver.contoso.ltd'
```

* To Run r10k to update puppet modules

```
docker exec -t puppet sh -c 'cd /etc/puppetlabs/code/environments/production && r10k puppetfile install --verbose DEBUG2'
```
