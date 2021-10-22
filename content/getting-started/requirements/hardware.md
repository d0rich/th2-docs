---
title: Hardware Requirements
weight: 5
chapter: true
---

# Hardware Requirements

1. Machines that meet kubeadm’s minimum requirements for the workers

2. One or more machines running one of:

   - Ubuntu 16.04+
   - Debian 9+
   - CentOS 7
   - Red Hat Enterprise Linux (RHEL) 7
   - Fedora 25+
3. Unique hostname, MAC address, and product_uuid for every node.

4. Certain ports are open on your machines. https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports

5. Cassandra ports: By default, Cassandra uses **7000** for cluster communication 
(**7001** if SSL is enabled), **9042** for native protocol clients, 
and **7199** for JMX. The internode communication and native protocol 
ports are configurable in the Cassandra Configuration File. The JMX 
port is configurable in cassandra-env.sh (through JVM options). All ports are TCP.

6. Swap disabled. You MUST disable swap in order for the kubelet to work properly.

7. Full network connectivity between all machines in the cluster (public or private network)

8. sudo privileges on all machines

9. SSH access from one device to all nodes in the system

10. Connectivity to repositories and registries:
    - kubernetes-dashboard: https://kubernetes.github.io/dashboard/
    - flux: https://charts.fluxcd.io
    - ingress-nginx: https://kubernetes.github.io/ingress-nginx
    - loki: https://grafana.github.io/loki/charts
    - stable: https://charts.helm.sh/stable
    - th2: https://th2-net.github.io
    - ghcr.io
    - quay.io
    - docker.io
    - k8s.gcr.io
