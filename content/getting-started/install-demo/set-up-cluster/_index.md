---
title: Set up cluster
weight: 15
chapter: false
---

During this step you will prepare kubernetes cluster and configuration maps for 
installing th2.

## Step 1. Get th2 infra values
Clone [th2-infra](https://github.com/th2-net/th2-infra) repository.

This repository contains configuration files for starting th2 inside kubernetes.

```shell
git clone https://github.com/th2-net/th2-infra.git
```

## Step 2. Create namespaces

Create namespaces for monitoring and th2 service tools.

```shell
kubectl create namespace monitoring
kubectl create namespace service
```

Output example:
```shell
namespace/monitoring created
namespace/service created
```

{{% spoiler "Check if required namespaces are existing." %}}
Get namespaces list:
```shell
kubectl get namespaces
```
Output example:
```shell
NAME              STATUS   AGE
default           Active   41d
kube-node-lease   Active   41d
kube-public       Active   41d
kube-system       Active   41d
monitoring        Active   41d
service           Active   41d
```
{{% /spoiler %}}

## Step 3. Data persistence

Data persistence is required for the following components: Grafana, Prometheus,
Loki, RabbitMQ - and should be set up at this step.

{{% notice note %}}
Examples below use HostPath type of
[Persistent Volume(PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/).
Please read the documentation to choose an appropriate PV type for your environment.
{{% /notice %}}

### Create directories for data persistence

{{% notice info %}}
If you are using _minikube_, create directories inside it. To do this, connect to the minikube container with
`minikube ssh` and execute next command.
{{% /notice %}}

The following command can require root permissions, create directory on th2 node:
```shell
mkdir /opt/grafana /opt/prometheus /opt/loki /opt/rabbitmq
```

### Edit persistence volume configuration
Set node name in `pvs.yaml` (replace **\<node-name\>**)  
`pvs.yaml` example:
```yaml
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: storage-loki
  labels:
    app: loki
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /opt/loki
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - <node-name> # replace with node name
---
```

### Create kubernetes entities for data persistence

{{% notice warning %}}
Make sure that you are located in the `th2-infra/example-values` directory.
{{% /notice %}}

Create PVs and PVCs:

```shell
kubectl apply -f ./pvs.yaml
kubectl apply -f ./pvcs.yaml
```

{{% spoiler "Check if required pv's and pvc's are existing." %}}
Get list of pv's:
```shell
kubectl get persistentvolumes
```
Output example:
```shell
NAME                 CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                                                                                                               STORAGECLASS    REASON   AGE
components-storage   10Gi       RWX            Retain           Released   schema/components                                                                                                   local-storage            41d
storage-grafana      1Gi        RWO            Retain           Bound      monitoring/grafana                                                                                                  local-storage            41d
storage-loki         5Gi        RWO            Retain           Bound      monitoring/loki                                                                                                     local-storage            41d
storage-prometheus   5Gi        RWO            Retain           Bound      monitoring/prometheus-prometheus-kube-prometheus-prometheus-db-prometheus-prometheus-kube-prometheus-prometheus-0                            41d
storage-rabbitmq     10Gi       RWO            Retain           Bound      service/data-rabbitmq-0                                                                                             local-storage            41d
```

Get list of pvc's:
```shell
kubectl get persistentvolumeclaims --all-namespaces
```
Output example:
```shell
NAMESPACE    NAME                                                                                                     STATUS   VOLUME               CAPACITY   ACCESS MODES   STORAGECLASS    AGE
monitoring   grafana                                                                                                  Bound    storage-grafana      1Gi        RWO            local-storage   41d
monitoring   loki                                                                                                     Bound    storage-loki         5Gi        RWO            local-storage   41d
monitoring   prometheus-prometheus-kube-prometheus-prometheus-db-prometheus-prometheus-kube-prometheus-prometheus-0   Bound    storage-prometheus   5Gi        RWO                            41d
service      data-rabbitmq-0                                                                                          Bound    storage-rabbitmq     10Gi       RWO            local-storage   41d
```
{{% /spoiler %}}

## Step 4. Configure th2

Once all of the required software is installed on your test-box and operator-box and
th2-infra repositories are ready, you can start configuring the cluster.


{{% notice warning %}}
Make sure that you are located in the `th2-infra/example-values` directory.
{{% /notice %}}


### Define Grafana and Dashboard host names

{{% notice note %}}
Host name must be resolved from QA boxes.
{{% /notice %}}

Define Dashboard host name in the `dashboard.values.yaml` ([file in github](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml)):

```yaml
ingress:
  hosts:
    - <th2_host_name>
```
Define Grafana host names in the `prometheus-operator.values.yaml` ([file in github](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml)):
```yaml
grafana:
  ingress:
    hosts:
      - <th2_host_name>
```




### Access for infra-mgr th2 schema git repository:

`Ssh` access with write permissions is required by th2-infra-mgr component.

{{% notice warning %}}
Be sure you are located in the `th2-infra/example-values` directory.
{{% /notice %}}

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

Set _infraMgr.git.repository_ value in the
`service.values.yaml` ([file on github](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml))
to ssh link of your schema repository, e.g:

```yaml
infraMgr:
  git:
    repository: git@github.com:th2-net/th2-infra-demo-configuration.git
```
### Define rabbitMQ host name

Set _externalRabbitMQHost.host_ value as the host name of your cluster in the `service.values.yaml` ([file on github](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml)).

```yaml
externalRabbitMQHost:
  host: 192.168.49.2
```

### Define cassandra host name

Set _cassandra.host_ value for cassandra in the `service.values.yaml` ([file on github](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml)).
```yaml
cassandra:
  internal: false
  host: <cassandra-host>
```

### Define th2 ingress hostname

If required, add the _ingress.hostname_ value into the
`service.values.yaml` ([file on github](https://github.com/th2-net/th2-infra/blob/master/example-values/service.values.yaml)).
Otherwise, th2 http services will be available on node IP address.

### Create secret with th2 credentials

Create `secrets.yaml` in the `th2-infra` folder.

{{% notice warning %}}
Do not commit `secrets.yaml` into git.
{{% /notice %}}

Example:
```yaml
# required only for images from a private registry, will be attached as the first PullSecret to deployments
#productRegistry:
#  username: user
#  password: password
#  name: private-registry-1.example.com # core components registry

# required only for images from a private registry, will be attached as the second PullSecret to deployments
#solutionRegistry:
#  username: user
#  password: password
#  name: private-registry-2.example.com # components registry

# required only for images from a private registry, will be attached as the third PullSecret to deployments
#proprietaryRegistry:
#  username: user
#  password: password
#  name: private-registry-3.example.com # components registry

cassandra:
# set credentials for the existing Cassandra cluster
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

