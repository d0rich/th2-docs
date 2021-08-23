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
Download helm-operator repository locally
```shell
helm repo add fluxcd https://charts.fluxcd.io
```
Install helm-operator
```shell
helm install --version=1.2.0 helm-operator -n service fluxcd/helm-operator -f ./helm-operator.values.yaml
```

## Install NGINX Ingress Controller
Download NGINX Ingress Controller repository locally
```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```
Install NGINX Ingress Controller
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
Download th2 repository locally
```shell
helm repo add th2 https://th2-net.github.io
```
Install th2
> Replace with th2-infra release version you need, please follow to https://github.com/th2-net/th2-infra/releases
```shell
helm install -n service --version=<version> th2-infra th2/th2 -f ./service.values.yaml -f ./secrets.yaml
```

