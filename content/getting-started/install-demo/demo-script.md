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

### grpc.json

Get nodePort of act service in th2-infra-schema/boxes/act-fix.yaml 

{{< highlight yml "linenos=table,hl_lines=8,linenostart=30" >}}
extended-settings:
  service:
    enabled: true
    type: NodePort
    endpoints:
      - name: 'grpc'
        targetPort: 8080
        nodePort: 31178
{{< / highlight >}}

Get nodePort of check1 service in th2-infra-schema/boxes/check1.yaml

{{< highlight yml "linenos=table,hl_lines=8,linenostart=24" >}}
extended-settings:
  service:
    enabled: true
    type: NodePort
    endpoints:
      - name: grpc
        targetPort: 8080
        nodePort: 31179
{{< / highlight >}}

Fill host and port fields in grpc.json  
Host is IP address of a cluster node.

{{< highlight json "linenos=table,hl_lines=7 8 20 21,linenostart=1" >}}
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
{{< / highlight >}}

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
