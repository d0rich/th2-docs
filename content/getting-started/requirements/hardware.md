---
title: Hardware
weight: 4
chapter: true
---

# Recommended hardware

## Sample hardware configurations

This section provides requirements for some of th2 use cases.

{{% notice note %}}
When creating a node, you may want to mount the `/var` filesystem to a
disk partition (or LVM) of required size.
This approach is convenient because a considerable
amount of disk space required for Cassandra, Docker or
other container runtime is allocated inside `/var` filesystem by default.
{{% /notice %}}

### Use case #1. Single machine cluster for PoC or development
#### Kubernetes node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|6-8 CPU cores|16-32 GB RAM|`/var` 150 GB<br>`/opt` 150 GB|

### Use case #2. Single machine cluster with moderate amount of workloads (less than 100 pods), without non-functional testing
#### Kubernetes node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|8-12 CPU cores|32 GB RAM|`/var` 80 GB <br>`/opt` 150 GB (for logs and metrics)|

#### Cassandra node **x3**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|4 CPU cores|8 GB RAM|`/var` 500 GB|

### Use case #3. Cluster with significant amount of workloads (more than 100 pods) with non-functional testing
#### Kubernetes master node **x1**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|2-4 CPU cores|2-4 GB RAM|`/` 20 GB|

#### Kubernetes worker node **x3+**
|CPU (Сores)|Memory(GB)	|Disk space (GB)|
|---|---|---|
|8-12 CPU cores|32 GB RAM|`/` 80 GB <br>`/opt` 150 GB (for logs and metrics)|

#### Cassandra node **x3**
|CPU (Сores)|Memory(GB)	|Disk space (TB)|
|---|---|---|
|4 CPU cores|8 GB RAM|`/` 1 TB|

## Minimal hardware requirements calculator
The recommended working disk capacity, CPU, and memory required for th2 installation can be calculated 
via the following formula (please find the reference table below):

`th2 env` = `Infra` + `Core` + `Monitoring` + `Building blocks` + `Custom` + `Data Storage(Cassandra)`

{{% notice info %}}
There are tables with different hardware **minimal** requirements below. You can choose options for your node
and total **minimal** requirements will be calculated in the final table.
{{% /notice %}}


{{% requirements-calculator %}}
