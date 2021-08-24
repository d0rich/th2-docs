---
title: Create th2 environment
weight: 25
pre: "<b>1.3.5 </b>"
chapter: true
---
### Step 5

# CREATE YOUR FIRST th2 CUSTOM ENVIRONMENT

In th2, environment is called `infractructure schema` or just `schema`, it's created by the 
dedicated [infra-mgr](https://github.com/th2-net/th2-infra-mgr) 
component that watches for changes in the repositories and rolling out schemas from git repository to kubernetes.

{{% notice note %}}
You already configured th2-infra-schema 
[in the step 4](/th2-docs/getting-started/install-demo/set-up-cluster/services-config/#set-the-repository-with-schema-configuration).
{{% /notice %}}

In demo example all required links between th2 boxes are configured, available 
in the [infra-schema-demo](https://github.com/th2-net/th2-infra-schema-demo) repository and can be used as an example for your new 
components. Additional information on th2-infra configuration can be also found on 
the [infra: Theory of Pins and Links](https://github.com/th2-net/th2-documentation/wiki/infra:-Theory-of-Pins-and-Links) wiki page.

{{% hl greenyellow %}}
Go to the Infra Editor (`http://your-host:30000/editor/`). And create schema.

![Create schema](../images/create-schema-1.png)

You need to create a name for this. 

![Name for schema](../images/create-schema-2.png)

After submitting infra-mgr will create th2-<new_schema_name> namespace and install all needed components.
{{% /hl %}}
