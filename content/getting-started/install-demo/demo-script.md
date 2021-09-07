---
title: Get and run demo script
weight: 30
pre: "<b>1.3.6 </b>"
chapter: false
---
## 1. Clone the script.

Clone needed branch from the [demo script repository](https://github.com/th2-net/th2-demo-script).  
At the moment of creating guide, actual branch is `ver-1.5.4-main_scenario`

```shell
git clone -b <branch_name> --single-branch https://github.com/th2-net/th2-demo-script.git
```

## 2. Get python environment 3.7+ (e.g. conda).
Recommended: get IDE to work with python (e.g. pycharm, spyder). You can also start this script from the command line, 
but IDE will make this process more convenient.

## 3. Import the libraries described in requirements.txt
requirements.txt contain standart packages to work with grpc (e.g. google-api-core) and custom packages to work 
with th2 boxes. Please note that grpc client (script) and grpc server (th2 box) should use the same package. 
You can find more information about requirements.txt and package installation 
here: https://pip.pypa.io/en/stable/user_guide/#requirements-files

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
{{% notice note %}}
Some ports are written in the following style: \<ClusterPort\>:\<NodePort\>/\<Protocol\>.  
For configuration you will need NodePort of appropriate service.
{{% /notice %}}
```shell
kubectl get service -n <th2-schema-namespace> 
```

Output example:
```shell
$ kubectl describe service -n th2-1-5-
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
act-fix                     NodePort    10.104.237.158   <none>        8080:31178/TCP,9752:32434/TCP   19d
act-ui                      NodePort    10.99.109.111    <none>        8080:31356/TCP,9752:30284/TCP   19d
act-ui-backend              NodePort    10.107.95.164    <none>        8080:31357/TCP,9752:31848/TCP   18d
check1                      NodePort    10.111.68.46     <none>        8080:31179/TCP,9752:31099/TCP   19d
codec-csv                   ClusterIP   10.97.221.246    <none>        8080/TCP,9752/TCP               18d
codec-fix                   ClusterIP   10.98.114.46     <none>        8080/TCP,9752/TCP               18d
codec-sim-fix               ClusterIP   10.107.218.9     <none>        8080/TCP,9752/TCP               18d
cradle-viewer-entry-point   ClusterIP   10.107.155.186   <none>        8080/TCP,9752/TCP               18d
dc-demo-server1             ClusterIP   10.102.226.175   <none>        8080/TCP,9752/TCP               19d
dc-demo-server2             ClusterIP   10.97.161.160    <none>        8080/TCP,9752/TCP               19d
demo-conn1                  ClusterIP   10.100.159.11    <none>        8080/TCP,9752/TCP               19d
demo-conn2                  ClusterIP   10.101.142.37    <none>        8080/TCP,9752/TCP               19d
demo-dc1                    ClusterIP   10.107.6.171     <none>        8080/TCP,9752/TCP               19d
demo-dc2                    ClusterIP   10.102.204.13    <none>        8080/TCP,9752/TCP               19d
estore                      ClusterIP   10.104.40.90     <none>        8080/TCP,9752/TCP               18d
fix-demo-server1            ClusterIP   10.108.129.43    <none>        8080/TCP,9752/TCP               19d
fix-demo-server2            ClusterIP   10.96.186.94     <none>        8080/TCP,9752/TCP               19d
mstore                      ClusterIP   10.101.186.188   <none>        8080/TCP,9752/TCP               18d
read-csv                    ClusterIP   10.97.137.185    <none>        8080/TCP                        18d
read-log                    ClusterIP   10.110.251.144   <none>        8080/TCP                        18d
recon                       ClusterIP   10.111.111.113   <none>        8080/TCP,9752/TCP               18d
rpt-data-provider           NodePort    10.96.79.173     <none>        8080:30789/TCP,9752:31960/TCP   18d
rpt-data-viewer             ClusterIP   10.103.86.37     <none>        8080/TCP,9752/TCP               19d
script-entry-point          ClusterIP   10.104.28.114    <none>        8080/TCP,9752/TCP               18d
sim-demo                    ClusterIP   10.107.154.135   <none>        8080/TCP                        18d
util                        ClusterIP   10.99.186.65     <none>        8080/TCP,9752/TCP               18d

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

{{< highlight json "linenos=table,hl_lines=7 8 20 21,linenostart=1" >}}
{
  "host": "10.44.16.110",
  "vHost": "th2-1-5-4",
  "port": "32000",
  "username": "th2",
  "password": "hkjsdbjfhbhbfk",
  "exchangeName": "th2-exchange"
}
{{< / highlight >}}

### mq.json

Fill mq.json in folder config with RabbitMQ 
exchange and routing key from script-entry-point to estore. 
You can find this queue in Kubernetes Dashboard in Config Maps tab - 
script-entry-point-app-config.

![mq config](../images/db-mq.png)

{{< highlight json "linenos=table,hl_lines=8 10,linenostart=1" >}}
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
{{< / highlight >}}
