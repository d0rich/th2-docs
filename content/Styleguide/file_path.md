---
title: "File and path"
weight: 20
chapter: true
---

#   Structure

Changing values in files should be shaped:

1) Declare that user need to open file
2) Specify file name using styleguide tips
3) Specify path to file
4) Specify where user should find correct values
5) Show file structure, point the places where user needs to make changes

Files when mentioned should be named:
1. Filename, underlined using \` 
`filename.ext`
```md
`filename.ext`
```
2. Add information about project [tree](https://pingvinus.ru/note/tree), if needed  
[highlight](https://gohugo.io/content-management/syntax-highlighting/) a string  if needed
{{< highlight md "hl_lines=5" >}}
.
├── archetypes
├── content
│   ├── Styleguide
│   │   └── filename.ext
│   ├── getting-started
│   ├── troubleshooting
│   └── tutorials
├── data
{{< / highlight >}}

#   Page code example

```md
   Open `infra-mgr-config.yml` file and specify spec.k8s-propagation variable sync instead of off. It allows th2 verify  all the dependencies from th2-infra-schema automatically.

    ```yml
    kind: SettingsFile
    metadata:
    name: infra-mgr-config
    spec:
    k8s-propagation: off # replace with sync
    ```
```

#   Page will look like

Open `infra-mgr-config.yml` file and specify spec.k8s-propagation variable sync instead of off. It allows th2 verify  all the dependencies from th2-infra-schema automatically.

```yml
    kind: SettingsFile
    metadata:
    name: infra-mgr-config
    spec:
    k8s-propagation: off # replace with sync
```


