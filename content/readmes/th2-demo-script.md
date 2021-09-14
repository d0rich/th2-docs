---
https://raw.githubusercontent.com/th2-net/th2-demo-script/ver-1.5.4-main_scenario/README.md 
title: th2 demo script
weight: 10
pre: "<b>2. </b>"
chapter: false
---

# Description:
The th2-script is a code, which contains a set of requests to the th2 components, executed in turns. The script can be written in any language that supports a common library. This script is written on python and contains three general types of actions.

* Requests to **the act** for sending messages that are executed synchronously. This means that we are sending a request and waiting for the result of its execution.

* Requests to **the check1** for message verification based on the expected results that are executed asynchronously. This means that we are not waiting for the check to be completed.

* Sending events to **the estore** queue to organize test results into a structure, or to supplement information in the report.

**Schema of a simplified example script:**

<img src="https://github.com/th2-net/th2-documentation/blob/master/images/demo-ver154-main/script-base-flow.png" data-canonical-src="https://github.com/th2-net/th2-documentation/blob/master/images/demo-ver154-main/script-base-flow.png"  />

## How to start:
**Schema(th2 environment) needed:** https://github.com/th2-net/th2-infra-schema-demo/tree/ver-1.5.4-main_scenario

Python 3.7+ environment required.
1. Change **configs** based on your **RabbitMQ** , **act** and **check1**
    1. Fill **grpc.json** in a folder **config** with the host, and the port of your **act** and **check1** pods. You can found it in Kubernetes Dashboard in Services tab or execute in kubectl - kubectl get services
    1. Fill **mq.json** in a folder **config** with **RabbitMQ exchange** and **routing key** from **script** to **estore**. You can find this queue in Kubernetes Dashboard in Config Maps tab - script-entry-point-app-config. 
    1. Fill **rabbitMQ.json** in a folder **config** with your **RabbitMQ credentials**. You can find these credentials in Kubernetes Dashboard in Config Maps tab - rabbit-mq-app-config.
1. Install required packages described in **requirements.txt**
1. Start **run.py**

## Test Scenario:

1. User1 submit passive buy order with Price=x and Size=30 - **Order1**
1. User1 receives an Execution Report with ExecType=0
1. User1 submit passive buy order with Price=x+1 and Size=10 - **Order2**
1. User1 receives an Execution Report with ExecType=0
1. User2 submit an aggressive sell IOC order with price=x-1 and Size=100 - **Order3**
    1. User1 receives an Execution Report with ExecType=F on trade between **Order2** and **Order3**
    1. User2 receives an Execution Report with ExecType=F on trade between **Order3** and **Order2**
    1. User1 receives an Execution Report with ExecType=F on trade between **Order1** and **Order3**
    1. User2 receives an Execution Report with ExecType=F on trade between **Order3** and **Order1**
    1. User2 receives an Execution Report with ExecType=C on expired **Order3**



