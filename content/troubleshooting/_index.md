---
title: Troubleshooting
weight: 100
pre: "<b>3. </b>"
chapter: true
---

# Troubleshooting

В этом разделе блаблабла

## General issues

### Сбрасывается кластер kubernetes при перезапуске машины (в т.ч. виртуальной)

#### Issue:

Сброс кластера при перезапуске виртуальной машины (сервис kubectl запускается с ошибкой) + Проблема с kube-apiserver

#### Way to resolve: 

"посмотреть, не изменился ли IP-адрес
Настройка kubeconfig - проверить, как ведётся подключение. Там должен быть тот же адрес, что используется для подключения к VPN"

#### Note:

- Машина, на которой работает Control plane выдает сертификаты, связанные с определенными IP-адресами
- kubectl cluster info - можно в числе прочего увидеть адрес
- утилита kubectl общается непосредственно с сервером
- Kube-apiserver - публичный API (с авторизацией) для взаимодействия с kubectl и с сервисами внутри и снаружи кластера"

## Node issues

### Kubernetes node is not ready

#### Issue:

При исполнении команды

```shell
kubectl get nodes
```

В колонке STATUS у kubernetes node статус NotReady

#### Way to resolve:

Получить информацию о ноде исполнив команду

```shell
kubectl describe node
```

Изучить вывод команды (особое внимание следует обратить на разделы events, conditions), использовать полученные сведения для определения основной причины этого состояния

#### Note:

Одной из причин может быть пробелма с Docker, для решения предлагается использовать [инструкцию](https://stackoverflow.com/questions/49112336/container-runtime-network-not-ready-cni-config-uninitialized). 

## Pod issues

### Pods are not started

#### Issue:

При исполнении команды

```shell
kubectl get pods --all-namespaces
```

не наблюдается постоянной готовности подов в полном составе, при применении команды через несколько минут наблюдается увеличение числа рестартов подов


#### Way to resolve:

- Решить проблему "Flannel некорректно установлен"
- Выполнить kubectl taint nodes  <node_name> node-role.kubernetes.io/master-

#### Note:

При исполнении команды 


```shell
kubectl get pods --all-namespaces
kubectl describe pod <pod_name>
```

указав в качестве <pod_name> один из незапустившихся подов, вывод второй команды будет похож на 

```shell
- Warning  FailedScheduling  default-scheduler  0/1 nodes are available: 1 node(s) had taint {node-role.kubernetes.io/master: }, that the pod didn't tolerate.
- Warning  FailedCreatePodSandBox                   kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to set up sandbox container ""a05e193a5064902ce111477738fce13948e217ed140d8a662390a9ee766a2be3"" network for pod ""loki-promtail-dwf4g"": networkPlugin cni failed to set up pod ""loki-promtail-dwf4g_monitoring"" network: open /run/flannel/subnet.env: no such file or directory
```



## Component issues

### Issue title

#### Issue:

text

#### Way to resolve:

text

#### Note:

text

