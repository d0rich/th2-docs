---
title: Deploy monitoring tools
weight: 30
pre: "<b>6. </b>"
chapter: true
---

### Set up cluster. Step 6

# Deploy monitoring tools

> Be sure you are located in the `th2-infra/example-values` directory.

## Install Kubernetes Dashboard

Download [Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/) repository locally
```shell
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
```
Install Kubernetes Dashboard
```shell
helm install dashboard -n monitoring kubernetes-dashboard/kubernetes-dashboard -f ./dashboard.values.yaml
```

## Install Grafana
Download Grafana repository locally
```shell
helm repo add grafana https://grafana.github.io/helm-charts
```
Install Grafana
```shell
helm install --version=0.40.1 loki -n monitoring grafana/loki-stack -f ./loki.values.yaml
```

## Install Prometheus
Download Prometheus repository locally
```shell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```
Install Prometheus
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

Check access to Grafana (default user/password: admin/prom-operator. Must be changed):  
`http://your-host:30000/grafana/login`
