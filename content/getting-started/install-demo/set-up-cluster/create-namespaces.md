---
title: Create namespaces
weight: 5
pre: "<b>1. </b>"
chapter: true
---

### Set up cluster. Step 1

# Create namespaces

{{% hl greenyellow %}}
Create namespace for monitoring tools
{{% /hl %}}

```shell
kubectl create namespace monitoring
```

{{% hl greenyellow %}}
Create namespace for th2 serving tools
{{% /hl %}}
```shell
kubectl create namespace service
```
