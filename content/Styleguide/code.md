---
title: "Code"
weight: 15
pre: "<b>4.2 </b>"
chapter: true
---

#   Structure

Фрагменты кода (как для исполнения в терминале, так и выводящиеся в терминале для пользователя) следует оформлять следующим образом:

1) Цель ввода команды
2) Текст команды 
3) Сведения о плейсхолдерах в команде
4) Сведения о пути, который нужно открыть в терминале, чтобы команда была исполнена корректно
5) Ожидаемый вывод в терминале

#   Page code example

```shell
    Check NGINX Ingress Controller installation:

    ```shell
    kubectl get pods
    ```
    
    No placeholders, not path-sensitive 

    Expected Terminal output example:    
    
    ```shell
    NAME                                                READY   STATUS    RESTARTS   AGE
    ........
    ingress-ingress-nginx-controller-7979dcdd85-mw42w   1/1     Running   0          30s
    ........
    
    ```
    
```

#   Page will look like

Check NGINX Ingress Controller installation:

```shell
    kubectl get pods
```
    
No placeholders, not path-sensitive 

Expected Terminal output example:    
    
```shell
    NAME                                                READY   STATUS    RESTARTS   AGE
    ........
    ingress-ingress-nginx-controller-7979dcdd85-mw42w   1/1     Running   0          30s
    ........
    
```
    

