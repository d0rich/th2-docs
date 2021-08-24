---
title: Install required software
weight: 5
pre: "<b>1.3.1 </b>"
chapter: true
---
### Step 1

# Required software installation

{{% hl greenyellow %}}
Весь контент на странице полностью новый.
{{% /hl %}}

Install required software to the test-box and operator-box.

## Test box (th2 node)

### 1. Docker CE v19+  

   Docker is the most popular open source application containerize technology. Th2 services will run inside separate docker containers.

   To install, go to the [official guide](https://docs.docker.com/engine/install/). Also, be sure to [configure docker](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) for kubernetes.

### 2. kubelet, kubeadm, kubectl v1.19.x - 1.20.x

Kubernetes is an open source, automated management system for containerized applications. In our case, docker containers.

Kubelet is the service that powers the kubernetes.

Kubeadm is a set of tools for creating and managing a kubernetes cluster.

Kubectl is a command line interface for interacting with the kubernetes cluster.

Instructions for installing these 3 tools are given in the official kubernetes [guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/).

### 3. Kubernetes cluster

The th2 modules will run in the kubernetes cluster. Use the official [guide](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) to create a cluster.

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

To install, follow the [link](https://www.google.com/chrome).
