---
title: Download th2 demo example
weight: 15
chapter: false
---

## Download th2


Скачайте необходимую ветку [th2-infra-schema-demo](https://github.com/th2-net/th2-infra-schema-demo/tree/master) 
(в каждой ветке данного резитория хранится конкретная версия th2-infra-schema). 
На момент написания инструкций актуальна ветка [ver-1.5.4-main_scenario](https://github.com/th2-net/th2-infra-schema-demo/tree/ver-1.5.4-main_scenario).

```shell
git clone -b <branch_name> --single-branch https://github.com/th2-net/th2-infra-schema-demo.git
```

th2-infra-schema хранит в себе конкретную конфигурацию модулей и связей между ними, 
которая может быть изменена в будущем.

Для удобства можете разместить th2-infra-schema в репозитории th2, 
однако расположение не так важно.

Откройте файл `infra-mgr-config.yml` и поменяйте параметр spec.k8s-propagation с off на sync. Это позволит в будущем th2 автоматически построить все зависимости, указанные в th2-infra-schema.

```yml
kind: SettingsFile
metadata:
  name: infra-mgr-config
spec:
  k8s-propagation: off # replace with sync
```


## Publish git repository

Опубликуйте репозиторий на github, либо выполните любые другие действия, 
чтобы th2-infra-schema была доступна по ssh. В будущем th2 будет читать 
th2-infra-schema по ssh ссылке.

