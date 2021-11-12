---
title: "th2 infra: Pins and Links"
weight: 15
chapter: true
---

# th2 infra: Pins and Links

### Pins

Each th2 box will have a number of connectors called "pins". The pins are used by the box to send/receive messages or to execute gRPC commands. In the example config below, the box has two pins. Each pin has a name (it is also used in the configuration files describing corresponding links), a connection type (MQ or gRPC) and attributes.

Attributes describe the details of the message flow that goes through this particular pin. They are specific for each th2 box. In the example below, two pins – `in` and `in_raw` – are defined. They describe raw and parsed messages, correspondingly, that come into the th2 box from the environment under test. Some attributes are optional while one of them is mandatory.

```shell
    - name: in
      connection-type: mq
      attributes:
        - first
        - parsed
        - publish
        - store
    - name: in_raw
      connection-type: mq
      attributes:
        - first
        - raw
        - publish
        - store
```

If you are defining a pin in which data will be published by the current box, you must specify the "publish" attribute; if the pin is supposed to receive data from another box, then you can optionally specify "subscribe". Although the "subscribe" attribute is optional, it’s still recommended to specify it, to maintain consistency. If the pin is accepting data and the "subscribe" attribute is not specified, then by default the pin will be considered as "subscribe" anyway. You cannot apply both attributes to one pin at the same time. A pin can have either a "publish" or a "subscribe" attribute.

Additionally, a pin can have the filter section. In this case, a message is sent via this particular pin only if this message satisfies the filter parameter (please refer to the example below).

```shell
- name: fix_to_send
      connection-type: mq
      attributes:
        - send
        - parsed
        - subscribe
      filters:
        - metadata:
            - field-name: session_alias
              expected-value: conn1_session_alias
              operation: EQUAL
```

#### Attributes


##### MQ action

Any components which publish "message" via MQ, for example:
* conn to codec
* codec to act / check / …
* act to conn
* conn to estore
* etc.


| Attribute name | Description |
| -------- | -------- |
| publish     | Basic attribute that marks the pin which publishes "messages" via MQ     |
| subscribe     | Basic attribute that marks the pin which subscribes to "messages" via MQ     |

### Links

After all the pins are defined and configured, you should also specify the links between them. It can be done by uploading a special CR called th2Link. Based on the components that the links are connecting, they can be separated in several files (e.g. from-codec-links.yml, from-act-links.yml, dictionary-links.yml). Also all links can be described in one file, but links for dictionary should be in the dictionaries-relation section, while all other links are specified in the boxes-relation section.
Here's a dictionary-links example:

```shell
apiVersion: th2.exactpro.com/v1
kind: Th2Link
metadata:
  name: dictionary-links
spec:
  dictionaries-relation:
    - name: codec-fix-dictionary
      box: codec-fix
      dictionary:
        name: fix50-generic
        type: MAIN
```

A boxes-links example:

```shell
apiVersion: th2.exactpro.com/v1
kind: Th2Link
metadata:
  name: from-conn-links
spec:
  boxes-relation:
    router-mq:
      - name: democonn1-codec
        from:
          box: demo-conn1
          pin: in_raw
        to:
          box: codec-fix
          pin: in_codec_decode
```

MQ links are described in the “router-mq” section. When connecting MQ links, you should keep in mind that the pins that are marked with the "publish" attribute must be specified in the "from" section, and those marked with "subscribe" (or not marked with either) must be specified in the "to" section. Each link has the name and the pin of the box from which this link goes, and the name and the pin of the box to which it leads. 

gRPC links are described in the section “router-grpc”.
Here's a grpc-link example:

```shell
apiVersion: th2.exactpro.com/v1
kind: Th2Link
metadata:
  name: from-act-links
spec:
  boxes-relation:
    router-grpc:
      - name: act-to-check1
        from:
          box: act-fix
          pin: to_check1
        to:
          box: check1
          pin: server
```

