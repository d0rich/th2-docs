---
title: Create th2 environment
weight: 25
chapter: false
---

During this step you will add final component to the environment schema. 
This component is **"Working infra schema"**.
![](images/Demo-cluster-components-4-final.drawio.png)

## Create infra schema with GIT branches

{{% notice warning %}}
Main instructions will work only with repositories published in the main way
described in [Publish th2 infra schema](./publish-schema) point.
{{% /notice %}}

Find [th2-infra-schema-demo](https://github.com/th2-net/th2-infra-schema-demo/tree/master)
repository copied by you. 

Every branch in this repository is the custom configuration for the th2 environment.

Select `ver-1.5.4-main_scenario` branch to create environment by this configuration.

![](images/choose-branch.png)

Create new branch from `ver-1.5.4-main_scenario` to not commit changes in 
the base configuration.

![](images/create-branch.png)

In the new branch edit `infra-mgr-config.yml`: variable 'spec.k8s-propagation' should be configured as 'rule' 
instead of 'off' to automatically apply all dependencies from th2-infra-schema. Commit changes.

```yml
kind: SettingsFile
metadata:
  name: infra-mgr-config
spec:
  k8s-propagation: rule
```

### What changed?

Infra Editor edit infra schema repository linked to the cluster. 
That is why SSH key is needed. 
Infra-mgr is monitoring your infra schema repository.
After described actions it will create th2-<new_branch_name> namespace and install all needed components.

In the infra editor new schema is available.

![Infra Schema](images/infra-schema.png)

Infra Editor will create new namespace th2-<new_schema_name> in kubernetes cluster for new schema.
It will have all components defined in schema.

![New namespace](images/new-namespace.png)


## Alternative: create infra schema with GUI

{{% notice warning %}}
Alternative instructions will work only with repositories published in the alternative way
described in [Publish th2 infra schema](./publish-schema) point.
{{% /notice %}}

In th2, environment is called `infractructure schema` or just `schema`, it's created by the 
dedicated [infra-mgr](https://github.com/th2-net/th2-infra-mgr) 
component that monitors for changes in the repositories and rolling out schemas from git repository to kubernetes.

{{% notice note %}}
You already configured th2-infra-schema 
[in the step 4](/th2-docs/getting-started/install-demo/set-up-cluster/services-config/#set-the-repository-with-schema-configuration).
{{% /notice %}}

In demo example all required links between th2 boxes are configured, available 
in the [infra-schema-demo](https://github.com/th2-net/th2-infra-schema-demo) repository and can be used as an example for your new 
components. Additional information on th2-infra configuration can be also found on 
the [infra: Theory of Pins and Links](https://github.com/th2-net/th2-documentation/wiki/infra:-Theory-of-Pins-and-Links) wiki page.

Go to the Infra Editor (`http://your-host:30000/editor/`). And create schema.

![Create schema](images/create-schema-1.png)

Name is needed for creating.

![Name for schema](images/create-schema-2.png)

After submitting infra-mgr will create th2-<new_schema_name> namespace and install all needed components.

![Infra Schema](images/infra-schema.png)

### What changed?

Infra Editor edit infra schema repository linked to the cluster. That is why SSH key is needed.
For each new schema it creates new branch identical to default branch.

![New branch](images/new-branch.png)

Infra Editor will create new namespace th2-<new_schema_name> in kubernetes cluster for new schema.
It will have all components defined in schema.

![New namespace](images/new-namespace.png)

