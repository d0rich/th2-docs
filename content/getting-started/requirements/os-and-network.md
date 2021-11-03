---
title: OS and network
weight: 5
chapter: true
---

# Operational System and Network Requirements

## Kubernetes minimum requirements

Machines that meet Kubernetes minimum requirements for the workers

## Operational System

|OS|Version|
|---|---|
|Ubuntu|16.04+|
|Debian|9+|
|CentOS|7|
|Red Hat Enterprise Linux (RHEL)|7|
|Fedora|25+|

## Network
1. Unique hostname, MAC address, and product_uuid for every node.
2. Swap disabled. You **MUST** disable swap in order for the kubelet to work properly.
3. Full network connectivity between all machines in the cluster (public or private network)
4. `sudo` privileges on all machines
5. SSH access from one device to all nodes in the system

## Kubernetes ports
Certain ports are open on your machines. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports

## Cassandra ports

|Port|Type|Purpose|
|---|---|---|
|7000|TCP|cluster communication|
|7001|TCP|cluster communication (SSL enabled)|
|9042|TCP|native protocol clients|
|7199|TCP|JMX|

### Customization
The internode communication and native protocol
ports are configurable in the Cassandra Configuration File. 

The JMX
port is configurable in cassandra-env.sh (through JVM options).


## Connectivity to repositories and registries
- kubernetes-dashboard: https://kubernetes.github.io/dashboard/
- flux: https://charts.fluxcd.io
- ingress-nginx: https://kubernetes.github.io/ingress-nginx
- loki: https://grafana.github.io/loki/charts
- th2: https://th2-net.github.io
- ghcr.io
- quay.io
- docker.io
- k8s.gcr.io
