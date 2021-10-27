---
title: Download th2 repositories
weight: 10
chapter: false
---
During this step you will create next components for final schema.

![](images/Demo-cluster-components-2-repositories.drawio.png)

## th2 infra
Clone [th2-infra](https://github.com/th2-net/th2-infra) repository.

This repository contains configuration files for starting th2 inside kubernetes.

```shell
git clone https://github.com/th2-net/th2-infra.git
```

## th2 infra schema

**th2 infra schema** is repository with description of th2 components and links between them.

See [Theory of pins and links](https://github.com/th2-net/th2-documentation/wiki/infra:-Theory-of-Pins-and-Links) for more information.

### Download th2 infra schema

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

### Publish git repository

Reinitialize repository to make downloaded branch main.

```shell
rm -rf .git
git init
```

Publish your repository on github. th2 will sync
with th2-infra-schema using ssh.

## Result

As the result you will have next part of the final schema.

![](images/Demo-cluster-components-2-final.drawio.png)
