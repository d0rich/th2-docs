
---
title: Prepared configuration
weight: 7
chapter: true
---

# Prepared configurations

{{% notice note %}}
You may want to mount `/var` filesystem to
disk partition or LVM of required size during node creation. 
This approach is very convenient because considerable 
amount of disk space which demanded by Cassandra, docker or 
other container runtime is allocated inside `/var` filesystem by default.
{{% /notice %}}

Here will be located some use cases and requirements for them

## Use case #1. Single machine cluster for PoC or development
### Kubernetes node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|6-8 CPU cores|16-32 GB RAM|`/var` 150 GB<br>`/opt` 150 GB|

## Use case #2. Single machine cluster with moderate amount of workloads (less than 100 pods), without NFT testing
### Kubernetes node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|8-12 CPU cores|32 GB RAM|`/var` 80 GB <br>`/opt` 150 GB (for logs and metrics)|

### Cassandra node **x3**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|4 CPU cores|8 GB RAM|`/var` 500 GB|

## Use case #3. Cluster with significant amount of workloads (more than 100 pods) with NFT testing
### Kubernetes master node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|2-4 CPU cores|2-4 GB RAM|`/` 20 GB|

### Kubernetes worker node **x3+**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|8-12 CPU cores|32 GB RAM|`/` 80 GB <br>`/opt` 150 GB (for logs and metrics)|

### Cassandra node **x3**
|CPU (Сores)|Memory(GB)	|Disk space (TB)|
|---|---|---|
|4 CPU cores|8 GB RAM|`/` 1 TB|
