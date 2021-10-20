---
title: Download th2 demo example
weight: 15
chapter: false
---

{{% hl "#E8988C" %}}
Get [th2-infra-schema](https://github.com/th2-net/th2-infra-demo-configuration) for custom components and copy or fork to your GIT repository.
{{% /hl %}}

## Download th2

{{% hl "#B5B8B1" %}}

Clone needed branch of [th2-infra-schema-demo](https://github.com/th2-net/th2-infra-schema-demo/tree/master) 
(each branch of the git repository contains a version of th2-infra-schema). 
Now [ver-1.5.4-main_scenario](https://github.com/th2-net/th2-infra-schema-demo/tree/ver-1.5.4-main_scenario) is the newest.

```shell
git clone -b <branch_name> --single-branch https://github.com/th2-net/th2-infra-schema-demo.git
```

th2-infra-schema contains modules and connections configuration that is customizable.

th2-infra-schema should be placed in th2 repository.

Open `infra-mgr-config.yml` file. Variable 'spec.k8s-propagation' should be configured 'sync' instead of 'off' to automatically apply all dependencies from th2-infra-schema.

```yml
kind: SettingsFile
metadata:
  name: infra-mgr-config
spec:
  k8s-propagation: off # replace with sync
```
{{% /hl %}}

## Publish git repository

{{% hl "#B5B8B1" %}}

Reinitialize repository to make downloaded branch main.

```shell
rm -rf .git
git init
```

Publish your repository on github. th2 will sync 
with th2-infra-schema using ssh.

{{% /hl %}}
