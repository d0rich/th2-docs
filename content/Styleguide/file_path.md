---
title: "File and path"
weight: 20
chapter: true
---

#   Structure

Внесение изменений в файл следует оформлять следующим образом:

1) Указать необходимость открыть файл
2) Указать название файла (специальное оформление)
3) Указать путь к файлу относительно основной директории проекта
4) Указать, где следует получить данные для внесения изменений в файл
5) Показать внутреннюю структуру файла и места, в которых нужно внести изменения

Ссылаться на файл нужно следующим образом:
1. Название файла в тексте выделить при помощи косых кавычек (\`) `filename.ext`
```md
`filename.ext`
```
2. При необходимости указания расположения файла добавить древо файлов. [tree](https://pingvinus.ru/note/tree)  
Подсветить нужную строку при помощи [highlight](https://gohugo.io/content-management/syntax-highlighting/)
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
    Откройте файл `infra-mgr-config.yml` и поменяйте параметр spec.k8s-propagation с off на sync. Это позволит в будущем th2 автоматически построить все зависимости, указанные в th2-infra-schema.

    ```yml
    kind: SettingsFile
    metadata:
    name: infra-mgr-config
    spec:
    k8s-propagation: off # replace with sync
    ```
```

#   Page will look like

Откройте файл `infra-mgr-config.yml` и поменяйте параметр spec.k8s-propagation с off на sync. Это позволит в будущем th2 автоматически построить все зависимости, указанные в th2-infra-schema.

```yml
kind: SettingsFile
metadata:
name: infra-mgr-config
spec:
k8s-propagation: off # replace with sync
```



