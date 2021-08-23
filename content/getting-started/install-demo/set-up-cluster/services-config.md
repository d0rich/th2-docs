---
title: Configure services
weight: 15
pre: "<b>3. </b>"
chapter: true
---

### Set up cluster. Step 3

# Configure services

Once all of the required software is installed on your test-box and operator-box and 
th2-infra repositories are ready you can start configuring the cluster.

- Switch namespace to service:
```shell
kubectl config set-context --current --namespace=service
```

## Access for infra-mgr th2 schema git repository:

`ssh` access with write permissions is required by th2-infra-mgr component

> Be sure you are located in the `th2-infra/example-values` directory.

Generate keys without passphrase
```shell
ssh-keygen -t rsa -m pem -f ./infra-mgr-rsa.key
```
[Add a new SSH key to your GitHub account](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

Create infra-mgr secret from the private key:
```shell
kubectl -n service create secret generic infra-mgr --from-file=infra-mgr=./infra-mgr-rsa.key
```

## Set the repository with schema configuration

set `infraMgr.git.repository` value in the 
[service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml) 
file to ssh link of your schema repository, e.g:

```yaml
infraMgr:
  git:
    repository: git@github.com:th2-net/th2-infra-demo-configuration.git
```

## Define cassandra host name

set `cassandra.host` value for cassandra in the [service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml) file.
```yaml
cassandra:
  internal: false
  host: <cassandra-host>
```

## Define th2 ingress hostname

Add `ingress.hostname` value if required into 
[service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml) 
file otherwise th2 http services will be available on node IP address

## Create secret with th2 credentials

Create secrets.yaml in `th2-infra` folder (do not commit into git). Example:
```yaml
# reguired only for images from a private registry, will be attached as the first PullSecret to deployments
#productRegistry:
#  username: user
#  password: password
#  name: private-registry-1.example.com # core components registry

# reguired only for images from a private registry, will be attached as the second PullSecret to deployments
#solutionRegistry:
#  username: user
#  password: password
#  name: private-registry-2.example.com # components registry

# reguired only for images from a private registry, will be attached as the third PullSecret to deployments
#proprietaryRegistry:
#  username: user
#  password: password
#  name: private-registry-3.example.com # components registry

cassandra:
# set credentials for existing Cassandra cluster
  dbUser:
    user: <user-name>
    password: <password>

rabbitmq:
# set admin user credentials, it will be created during deployment
  rabbitmqUsername: th2
  rabbitmqPassword: rab-pass
  # must be random string
  rabbitmqErlangCookie: cookie
```

