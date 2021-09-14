---
title: Get and run demo script
weight: 30
pre: "<b>1.3.6 </b>"
chapter: false
---
## 0. Get and run simulator boxes

### Clone simulator boxes

```shell
git clone -b demo-ver-1.5.4-local --single-branch https://github.com/th2-net/th2-sim-template.git
```

```shell
git clone -b demo-ver-1.5.4-local --single-branch https://github.com/th2-net/th2-read-log.git
```

```shell
git clone -b demo-ver-1.5.4-local --single-branch https://github.com/th2-net/th2-read-csv.git
```

### Change rabbitMQ configmap

```shell
KUBE_EDITOR="nano" kubectl edit configmap -n th2-1-5-4 rabbit-mq-external-app-config -o yaml
```

### Run simulator boxes

```shell
gradle run --args='--namespace th2-1-5-4 --boxName read-csv --contextName doc'
```

```shell
gradle run --args='--namespace th2-1-5-4 --boxName read-log --contextName doc'
```

```shell
gradle run --args='--namespace th2-1-5-4 --boxName sim-demo --contextName doc'
```

## 1. Clone the script.

Clone needed branch from the [demo script repository](https://github.com/th2-net/th2-demo-script).  
At the moment of creating guide, actual branch is `ver-1.5.4-main_scenario`

```shell
git clone -b <branch_name> --single-branch https://github.com/th2-net/th2-demo-script.git
```

## 2. Get python environment 3.7+ (e.g. conda).

{{% notice info %}}
Python already might be installed after step **1.3.1 Install required software**.
{{% /notice %}}

To install Python follow [this instruction](https://wiki.python.org/moin/BeginnersGuide/Download).

Recommended: get IDE to work with python (e.g. pycharm, spyder). You can also start this script from the command line, 
but IDE will make this process more convenient.

## 3. Import the libraries described in requirements.txt
`requirements.txt` contain standart packages to work with grpc (e.g. google-api-core) and custom packages to work 
with th2 boxes. Please note that grpc client (script) and grpc server (th2 box) should use the same package. 
You can find more information about requirements.txt and package installation 
here: https://pip.pypa.io/en/stable/user_guide/#requirements-files

Locate to the script root folder:
```shell
python -m pip install -r requirements.txt
```

## 4. Set up configs
Set up configs from directory configs (mq.json, rabbit.json, grpc.json) according to your components.

{{% notice note %}}
Words inside _${value}_ in JSON examples and in dashboard config maps are names of the values, that depends on your cluster.
You must find it by the following instructions.
{{% /notice %}}

### grpc.json

Fill host and port fields in grpc.json

```json

{
  "services": {
    "Act": {
      "service-class": "ActService",
      "endpoints": {
        "act": {
          "host": "${NODE_IP}",
          "port": "${ACT_PORT}"
        }
      },
      "strategy": {
        "name": "robin",
        "endpoints": ["act"]
      }
    },
    "Check1": {
      "service-class": "Check1Service",
      "endpoints": {
        "check1": {
          "host": "${NODE_IP}",
          "port": "${CHECK1_PORT}"
        }
      },
      "strategy": {
        "name": "robin",
        "endpoints": ["check1"]
      }
    }
  }
}
```

_NODE_IP_ is IP address of a cluster node.

You can find _CHECK1_PORT_ and _ACT_PORT_ by executing following command.  
{{% notice info %}}
Some ports are written in the following style: \<ClusterPort\>:\<NodePort\>/\<Protocol\>.  
For configuration you will need NodePort of appropriate service.
{{% /notice %}}
```shell
kubectl get service -n <th2-schema-namespace> 
```

Output example:
```shell
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
act-fix                     NodePort    10.104.237.158   <none>        8080:31178/TCP,9752:32434/TCP   19d
act-ui                      NodePort    10.99.109.111    <none>        8080:31356/TCP,9752:30284/TCP   19d
act-ui-backend              NodePort    10.107.95.164    <none>        8080:31357/TCP,9752:31848/TCP   18d
check1                      NodePort    10.111.68.46     <none>        8080:31179/TCP,9752:31099/TCP   19d
........
```

#### Example of **grpc.json**:
```json
{
  "services": {
    "Act": {
      "service-class": "ActService",
      "endpoints": {
        "act": {
          "host": "10.44.16.110",
          "port": 31178
        }
      },
      "strategy": {
        "name": "robin",
        "endpoints": ["act"]
      }
    },
    "Check1": {
      "service-class": "Check1Service",
      "endpoints": {
        "check1": {
          "host": "10.44.16.110",
          "port": 31179
        }
      },
      "strategy": {
        "name": "robin",
        "endpoints": ["check1"]
      }
    }
  }
}
```

### rabbit.json

- host: IP address of a cluster node
- username, password: credentials for rabbitMQ
- vHost, port, exchangeName: Kubernetes Dashboard - Config Maps - rabbit-mq-external-app-config.

![rabbit config](../images/db-rabbitmq.png)

```json
{
  "host": "10.44.16.110",
  "vHost": "th2-1-5-4",
  "port": "32000",
  "username": "th2",
  "password": "hkjsdbjfhbhbfk",
  "exchangeName": "th2-exchange"
}
```

### mq.json

Fill mq.json in folder config with RabbitMQ 
exchange and routing key from script-entry-point to estore. 
You can find this queue in Kubernetes Dashboard in Config Maps tab - 
script-entry-point-app-config.

![mq config](../images/db-mq.png)

```json
{
  "queues": {
    "event-store-pin": {
      "attributes": [
        "event",
        "publish"
      ],
      "exchange": "th2-exchange",
      "filters": [],
      "name": "key[th2-1-5-4:script-entry-point:estore-pin]",
      "queue": "not_necessary"
    }
  }
}
```

