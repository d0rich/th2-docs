---
title: Deploy monitoring tools
weight: 30
pre: "<b>6. </b>"
chapter: true
---

### Set up cluster. Step 6

# Deploy monitoring tools

{{% notice note %}}
Be sure you are located in the `th2-infra/example-values` directory.
{{% /notice %}}

## Install Kubernetes Dashboard

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

## Install Grafana
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

## Install Prometheus
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

## Check result
### Pods
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
### Access from browser

{{% hl pink %}}
Add loki Datasource as http://loki:3100 and import Dashboard from components-logs.json and RabbitMQ Overview from here: https://grafana.com/grafana/dashboards/10991
{{% /hl %}}

Check access to Grafana (default user/password: admin/prom-operator. Must be changed):  
`http://your-host:30000/grafana/login`
