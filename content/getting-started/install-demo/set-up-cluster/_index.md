---
title: Set up cluster and install th2
weight: 20
pre: "<b>1.3.4 </b>"
chapter: false
---

## Contents

{{% hl orange %}}

Content was reorganized
1. Create namespaces
2. Data persistence
3. Configure services
4. Deploy th2 services
5. Configure monitoring tools
6. Deploy monitoring tools
7. Check up
{{% /hl %}}
{{% hl pink %}}
- [Upgrade th2-infra](https://github.com/th2-net/th2-infra#upgrade-th2-infra)
- [Re-adding persistence for components in th2 namespaces](https://github.com/th2-net/th2-infra#re-adding-persistence-for-components-in-th2-namespaces)
{{% /hl %}}

## Step 1. Create namespaces

{{% hl greenyellow %}}
Create namespace for monitoring tools
{{% /hl %}}

```shell
kubectl create namespace monitoring
```

{{% hl greenyellow %}}
Create namespace for th2 serving tools
{{% /hl %}}
```shell
kubectl create namespace service
```

## Step 2. Data persistence

Data persistence is required for the following components: Grafana, Prometheus,
Loki, RabbitMQ components and should be set up on this step.

{{% notice note %}}
Examples below use HostPath type of
[Persistent Volume(PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).
Please read the documentation to choose an appropriate PV type for your environment.
{{% /notice %}}

- the following command can require root permissions, create directory on th2 node:
```shell
mkdir /opt/grafana /opt/prometheus /opt/loki /opt/rabbitmq
```

- set node name in `pvs.yaml`
- create PVs and PVCs:

```shell
kubectl apply -f ./pvs.yaml
kubectl apply -f ./pvcs.yaml
```

{{% hl pink %}}
If you would like to include th2 read components into your configuration, you also have to set up a dedicated PersistentVolume for th2-read log directory. You should add PersistentVolume mapped to /opt/components directory and then create PersistentVolumeClaim once a schema namespace installed. PV and PVC examples can be found here persistence/

$ mkdir /opt/components  
set node name in persistence/pv.yaml  
create PV:  
$ kubectl apply -f ./persistence/pv.yaml  
create PVC:  
$ kubectl apply -f ./persistence/pvc.yaml  
Details for th2-read-log README.md  
{{% /hl %}}

## Step 3. Configure services

Once all of the required software is installed on your test-box and operator-box and
th2-infra repositories are ready you can start configuring the cluster.

- Switch namespace to service:
```shell
kubectl config set-context --current --namespace=service
```

### Access for infra-mgr th2 schema git repository:

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

### Set the repository with schema configuration

set `infraMgr.git.repository` value in the
[service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml)
file to ssh link of your schema repository, e.g:

```yaml
infraMgr:
  git:
    repository: git@github.com:th2-net/th2-infra-demo-configuration.git
```

### Define cassandra host name

set `cassandra.host` value for cassandra in the [service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml) file.
```yaml
cassandra:
  internal: false
  host: <cassandra-host>
```

### Define th2 ingress hostname

Add `ingress.hostname` value if required into
[service.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml)
file otherwise th2 http services will be available on node IP address

### Create secret with th2 credentials

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

## Step 4. Deploy th2 services

> Be sure you are located in the `th2-infra/example-values` directory.

### Install helm-operator
{{% hl greenyellow %}}
Download helm-operator repository locally
{{% /hl %}}
```shell
helm repo add fluxcd https://charts.fluxcd.io
```
{{% hl greenyellow %}}
Install helm-operator
{{% /hl %}}
```shell
helm install --version=1.2.0 helm-operator -n service fluxcd/helm-operator -f ./helm-operator.values.yaml
```

### Install NGINX Ingress Controller
{{% hl greenyellow %}}
Download NGINX Ingress Controller repository locally
{{% /hl %}}
```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```
{{% hl greenyellow %}}
Install NGINX Ingress Controller
{{% /hl %}}
```shell
helm install -n service --version=3.31.0 ingress ingress-nginx/ingress-nginx -f ./ingress.values.yaml
```
Check:
```shell
$ kubectl get pods
NAME                                                READY   STATUS    RESTARTS   AGE
........
ingress-ingress-nginx-controller-7979dcdd85-mw42w   1/1     Running   0          30s
........
```

### Install th2-infra components in the service namespace
{{% hl greenyellow %}}
Download th2 repository locally
{{% /hl %}}
```shell
helm repo add th2 https://th2-net.github.io
```
{{% hl greenyellow %}}
Install th2
{{% /hl %}}
{{% notice note %}}
Replace with th2-infra release version you need, please follow to https://github.com/th2-net/th2-infra/releases
{{% /notice %}}
```shell
helm install -n service --version=<version> th2-infra th2/th2 -f ./service.values.yaml -f ./secrets.yaml
```

{{% hl pink %}}
Wait for all pods in service namespace are up and running, once completed proceed with [schema configuration](https://github.com/th2-net/th2-infra-schema-demo/blob/master/README.md) to deploy th2 namespaces.
{{% /hl %}}

## Step 5. Configure monitoring tools

Switch namespace to monitoring
```shell
kubectl config set-context --current --namespace=monitoring
```
{{% notice note %}}
Be sure you are located in the `th2-infra/example-values` directory.
{{% /notice %}}

{{% hl orange %}}
### Define Grafana and Dashboard host names

{{% notice note %}}
Host name must be resolved from QA boxes
{{% /notice %}}

Define Dashboard host name in the [dashboard.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml):

```yaml
ingress:
  hosts:
    - <th2_host_name>
```
Define Grafana host names in the [prometheus-operator.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml):
```yaml
grafana:
  ingress:
    hosts:
      - <th2_host_name>
```

{{% /hl %}}


## Step 6. Deploy monitoring tools

{{% notice note %}}
Be sure you are located in the `th2-infra/example-values` directory.
{{% /notice %}}

### Install Kubernetes Dashboard

{{% hl greenyellow %}}
Download [Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) repository locally
{{% /hl %}}
```shell
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
```
{{% hl greenyellow %}}
Install Kubernetes Dashboard
{{% /hl %}}
```shell
helm install dashboard -n monitoring kubernetes-dashboard/kubernetes-dashboard -f ./dashboard.values.yaml
```

### Install Grafana
{{% hl greenyellow %}}
Download Grafana repository locally
{{% /hl %}}
```shell
helm repo add grafana https://grafana.github.io/helm-charts
```
{{% hl greenyellow %}}
Install Grafana
{{% /hl %}}
```shell
helm install --version=0.40.1 loki -n monitoring grafana/loki-stack -f ./loki.values.yaml
```

### Install Prometheus
{{% hl greenyellow %}}
Download Prometheus repository locally
{{% /hl %}}
```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```
{{% hl greenyellow %}}
Install Prometheus
{{% /hl %}}
```shell
helm install --version=15.0.0 prometheus -n monitoring prometheus-community/kube-prometheus-stack -f ./prometheus-operator.values.yaml
```

### Check result
#### Pods
Check if monitoring pods are running
```shell
$ kubectl get pods
NAME                                                     READY   STATUS    RESTARTS   AGE
........
pod/dashboard-kubernetes-dashboard-77d85586db-j9v8f      1/1     Running   0          56s
alertmanager-prometheus-prometheus-oper-alertmanager-0   2/2     Running   0          75s
loki-0                                                   1/1     Running   0          4m47s
loki-promtail-wqfml                                      1/1     Running   0          4m47s
prometheus-grafana-68f8dd6d57-2gtns                      2/2     Running   0          82s
prometheus-kube-state-metrics-75d4cc9dbd-psb88           1/1     Running   0          82s
prometheus-prometheus-node-exporter-gfzp6                1/1     Running   0          82s
prometheus-prometheus-oper-operator-df668d457-snxks      1/1     Running   0          82s
prometheus-prometheus-prometheus-oper-prometheus-0       3/3     Running   1          65s        
........
```
#### Access from browser

{{% hl pink %}}
Add loki Datasource as http://loki:3100 and import Dashboard from components-logs.json and RabbitMQ Overview from here: https://grafana.com/grafana/dashboards/10991
{{% /hl %}}

Check access to Grafana (default user/password: admin/prom-operator. Must be changed):  
`http://your-host:30000/grafana/login`

## Step 7. Check up installed services

- Kubernetes dashboard `http://your-host:30000/dashboard/`
- Grafana `http://your-host:30000/grafana/`
- th2-infra-editor `http://your-host:30000/editor/`
- RabbitMQ `http://your-host:30000/rabbitmq/`
- th2-reports `http://your-host:30000/your-namespace/`
