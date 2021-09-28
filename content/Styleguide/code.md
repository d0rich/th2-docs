---
title: "Code"
weight: 15
chapter: true
---

#   Structure

Code parts (both for execution and output code) should be shaped:

1) code execution purpose
2) code itself
3) placeholder comments 
4) path comments (where Terminal should be opened to execute code properly)
5) expected terminal output

1. Variables when mentioned are italicized with symbols \_  

_variable_

```md
_variable_
```
2. Variable in file if mentioned are [highlighted](https://gohugo.io/content-management/syntax-highlighting/)
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
3. Specify correct syntax when describing code output for proper highlighting:
   1. _shell_ - for terminal input (cammand line)
   2. _yaml_ - for .yaml files
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
    

