---
title: Install required software
weight: 5
pre: "<b>1.4.1 </b>"
chapter: false
---

Install required software to the test-box and operator-box.

## Test box (th2 node)

th2 is a Kubernetes-driven microservices solution. 
So, to start with th2 you would need the fully functional 
Kubernetes cluster installed on your test-box/test-boxes 
(a quick guide for kubernetes installation on Centos-7 is 
available in the [FAQ section](https://github.com/th2-net/th2-documentation/wiki/Centos-7-kubernetes-and-cassandra-installation-guide)), please also check if your 
test-box and operator-box meet th2 software [requirements](https://d0rich.github.io/th2-docs/getting-started/requirements/).

### 1. Docker CE v19+  

   Docker is the most popular open source application containerize technology. Th2 services will run inside separate docker containers.

   To install, follow the [official guide](https://docs.docker.com/engine/install/). Also, be sure to [configure docker](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) for kubernetes.

### 2. minikube

```shell
minikube start --kubernetes-version v1.19.14
```

### 3. Kubernetes cluster

The th2 modules will run on the kubernetes cluster. Use the official [guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) to create a cluster.

### 4. Flannel CNI

Flannel is an add-on for kubernetes that addresses some of the networking [issues](https://kubernetes.io/docs/concepts/cluster-administration/networking/).

To install, you need to run the following command

```shell
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

## Operator box

### 1. GIT

GIT is the most popular project version control system. Th2 will keep track of the git repositories of modules and update its configuration when they change.

Follow [these instructions](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to install.

### 2. Kubectl

Kubectl is a command line interface for interacting with the kubernetes cluster.

Installation instructions are given on the [kubernetes website](https://kubernetes.io/docs/tasks/tools/).

### 3. Helm 3+

Helm is a package manager for kubernetes. With it, you can very quickly install the required module into the kubernetes cluster.

Read the [official guide](https://helm.sh/docs/intro/install/) for installation.

### 4. Chrome 75 or newer

Chrome browser is required to access the web interface kubernetes dashboard, grafana, etc.

To install, follow the [instruction](https://www.google.com/chrome).
