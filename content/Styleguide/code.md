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

1. При упоминании переменной в тексте выделить её курсивом при помощи \_  
_variable_
```md
_variable_
```
2. Необходимости указать на расположение переменной в файле использовать [highlight](https://gohugo.io/content-management/syntax-highlighting/)
   {{< highlight go "linenos=table,hl_lines=8 15-17,linenostart=199" >}}
   // GetTitleFunc returns a func that can be used to transform a string to
   // title case.
   //
   // The supported styles are
   //
   // - "Go" (strings.Title)
   // - "AP" (see https://www.apstylebook.com/)
   // - "Chicago" (see https://www.chicagomanualofstyle.org/home.html)
   //
   // If an unknown or empty style is provided, AP style is what you get.
   func GetTitleFunc(style string) func(s string) string {
     switch strings.ToLower(style) {
       case "go":
       return strings.Title
       case "chicago":
       return transform.NewTitleConverter(transform.ChicagoStyle)
       default:
       return transform.NewTitleConverter(transform.APStyle)
     }
   }
   {{< / highlight >}}
3. При выводе кода указать используемый синтаксис для корректной подсветки
   1. _shell_ - для командной строки
   2. _yaml_ - для .yaml файлов
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
    

