---
title: Publish th2 infra schema
weight: 10
chapter: false
---
As a result of this step, you will create the following components for the final th2 schema:

![](images/Demo-cluster-components-2-infra-schema.drawio.png)

## th2 infra schema

**th2 infra schema** is a repository containing the description of th2 components and links between them.

Some example configurations of th2 are available in the [`th2-infra-schema-demo`](https://github.com/th2-net/th2-infra-schema-demo/tree/master) repository.

See the [Theory of pins and links](https://github.com/th2-net/th2-documentation/wiki/infra:-Theory-of-Pins-and-Links) section of the th2 GitHub Wiki for more information.

## Publish infra schema

Fork the [`th2-infra-schema-demo`](https://github.com/th2-net/th2-infra-schema-demo/tree/master) repository or use it as a template. It can be either **public** or **private**.

![](images/clone-th2-infra-schema-demo.png)

{{% notice info %}}
th2 will sync with `th2-infra-schema` using `ssh`.
{{% /notice %}}

## Alternative: Publish th2 infra schema to create a th2 environment via the GUI

### Download th2 infra schema

Clone the needed branch of [`th2-infra-schema-demo`](https://github.com/th2-net/th2-infra-schema-demo/tree/master) (each branch of the Git repository contains a version of `th2-infra-schema`). Currently, [`ver-1.5.4-main_scenario`](https://github.com/th2-net/th2-infra-schema-demo/tree/ver-1.5.4-main_scenario) is the newest.

```shell
git clone -b <branch_name> --single-branch https://github.com/th2-net/th2-infra-schema-demo.git
```

<!--- 
th2-infra-schema or th2-infra-schema-demo???
-->
`th2-infra-schema` has a configuration of th2 modules and connections and is customizable. It should be placed into the th2 repository.

Open the `infra-mgr-config.yml` file. The `spec.k8s-propagation` variable should be set to 'sync' instead of 'off' in order to automatically inherit all dependencies from `th2-infra-schema`.

```yml
kind: SettingsFile
metadata:
  name: infra-mgr-config
spec:
  k8s-propagation: sync
```

### Publish the Git repository

Reinitialize the repository to set the downloaded branch as `main`.

```shell
rm -rf .git
git init
```

Publish your repository on GitHub as either **public** or **private**.

## Result

As a result, you will get the following part of the final th2 schema.

![](images/Demo-cluster-components-2-final.drawio.png)
