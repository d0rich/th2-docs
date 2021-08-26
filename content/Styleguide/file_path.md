---
title: "File and path"
weight: 20
pre: "<b>4.3 </b>"
chapter: true
---

#   Structure

Внесение изменений в файл следует оформлять следующим образом:

1) Указать необходимость открыть файл
2) Указать название файла (специальное оформление)
3) Указать путь к файлу относительно основной директории проекта
4) Указать, где следует получить данные для внесения изменений в файл
5) Показать внутреннюю структуру файла и места, в которых нужно внести изменения



#   Page code example

```shell
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



