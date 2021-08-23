---
title: Data persistence
weight: 10
pre: "<b>2. </b>"
chapter: true
---

### Set up cluster. Step 2

# Data persistence

Data persistence is required for the following components: Grafana, Prometheus, 
Loki, RabbitMQ components and should be set up on this step.

>Examples below use HostPath type of 
[Persistent Volume(PV)](https://kubernetes.io/docs/concepts/storage/persistent-volumes/). 
Please read the documentation to choose an appropriate PV type for your environment.

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
