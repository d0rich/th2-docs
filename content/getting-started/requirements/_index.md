---
title: Technical Requirements
weight: 10
chapter: true
---

# Technical Requirements

Please follow the guidelines below when choosing hardware for your th2 solution:
- The right balance of CPUs, memory, disks, number of nodes depends on your particular use case, the number of services you are planing to deploy and the expected data load.
- Approximate configuration options for a few use cases are available in the Configuration Options section. The suggested hardware are the minimum required. You may need to increase CPU capacity, memory, and disk space beyond the recommended minimums.
- General recommendations for Hardware and Software are available in the particular sections.
- The recommended working disk capacity, CPU and memory required for th2 installation can be calculated via the following formula (please find the reference table below) :

th2 env = Infra + Core + Monitoring + Building blocks + Custom + Data Storage(Cassandra)

There are tables with different hardware requirements below. You can choose options for your node
and total minimal requirements will be calculated in final table.

{{% requirements-calculator %}}
