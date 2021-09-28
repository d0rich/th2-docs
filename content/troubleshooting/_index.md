---
title: Troubleshooting
weight: 100
pre: "<b>3. </b>"
chapter: true
---

# Troubleshooting



## General issues

### Kubernetes cluster reset when rebooting (including virtual machine)

#### Issue:

Kubernetes cluster is being reset when rebooting machine (kubectl service starts with error) + kube-apiserver trouble

#### Way to resolve: 

"IP check if changed
kubeconfig - how connection is configured. We should use IP from VPN config"

#### Note:

- Control plane node certifies connections to determined IP`s
- kubectl cluster info - a way to check IP
- kubectl connects directly to server
- Kube-apiserver - public API (authorisation-protected) to provide interaction between environment and kubernetes cluster (include kubectl)
## Node issues

### Kubernetes node is not ready

#### Issue:

While executing:

```shell
kubectl get nodes
```

In STATUS column kubernetes node status is NotReady

#### Way to resolve:

Get more information about node by executing

```shell
kubectl describe node
```

Check events and conditions sections

#### Note:

If it`s Docker-related issue, use [manual](https://stackoverflow.com/questions/49112336/container-runtime-network-not-ready-cni-config-uninitialized). 

## Pod issues

### Pods are not started

#### Issue:

While executing:

```shell
kubectl get pods --all-namespaces
```

Pods are not stable in READY state, restart numbers increase


#### Way to resolve:

- Resolve "incorrect Flannel installation"
- Execute kubectl taint nodes  <node_name> node-role.kubernetes.io/master-

#### Note:

While executing:


```shell
kubectl get pods --all-namespaces
kubectl describe pod <pod_name>
```

You should specify the name of pod with NotReady status instead of <pod_name>. Output will look like:



```shell
- Warning  FailedScheduling  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
- Warning  FailedCreatePodSandBox                   kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container ""a05e193a5064902ce111477738fce13948e217ed140d8a662390a9ee766a2be3"" network for pod ""loki-promtail-dwf4g"": networkPlugin cni failed to set up pod ""loki-promtail-dwf4g_monitoring"" network: open /run/flannel/subnet.env: no such file or directory
```



## Component issues

### Issue title

#### Issue:

text

#### Way to resolve:

text

#### Note:

text

