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
