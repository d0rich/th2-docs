---
title: Deploy th2 services
weight: 20
pre: "<b>4. </b>"
chapter: true
---

### Set up cluster. Step 4

# Deploy th2 services

> Be sure you are located in the `th2-infra/example-values` directory.

## Install helm-operator
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

## Install NGINX Ingress Controller
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

## Install th2-infra components in the service namespace
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
