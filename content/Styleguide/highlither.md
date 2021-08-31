---
title: "Highlighter"
weight: 25
pre: "<b>4.4 </b>"
chapter: true
---

#   Structure

Не выделяется цветом контент, перенесённый из первоисточника (документация th2 из репозиториев гитхаба) без изменений.

Цветом выделяется контент, подвергшийся изменению

1) Зелёным обозначен контент, добавленный на страницу сверх представленного в первоисточнике
2) Оранжевым обозначен контент, изменённый относительно первоисточника
3) Красным обозначен контент, исключённый из содержания страницы

#   Page code example

```shell
{{< hl greenyellow >}}
Добавленный контент
{{< /hl >}}

{{< hl orange >}}
Изменённый контент
{{< /hl >}}

{{< hl pink >}}
Это для удаленных фрагментов
{{< /hl >}}

```

#   Page will look like

{{< hl greenyellow >}}
Добавленный контент
{{< /hl >}}

{{< hl orange >}}
Изменённый контент
{{< /hl >}}

{{< hl pink >}}
Это для удаленных фрагментов
{{< /hl >}}