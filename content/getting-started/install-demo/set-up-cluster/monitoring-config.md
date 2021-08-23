---
title: Configure monitoring tools
weight: 25
pre: "<b>5. </b>"
chapter: true
---

### Set up cluster. Step 5

# Configure monitoring tools

Switch namespace to monitoring
```shell
kubectl config set-context --current --namespace=monitoring
```

> Be sure you are located in the `th2-infra/example-values` directory.

## Define Grafana and Dashboard host names

> Host name must be resolved from QA boxes

Define Dashboard host name in the [dashboard.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml):

```yaml
ingress:
  hosts:
    - <th2_host_name>
```
Define Grafana host names in the [prometheus-operator.values.yaml](https://github.com/th2-net/th2-infra/blob/master/example-values/prometheus-operator.values.yaml):
```yaml
grafana:
  ingress:
    hosts:
      - <th2_host_name>
```


