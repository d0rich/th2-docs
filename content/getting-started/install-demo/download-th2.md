---
title: Download th2
weight: 10
pre: "<b>1.3.2 </b>"
chapter: true
---
### Step 2

# Download th2 to your GIT repository

{{% hl pink %}}
th2 components should be copied to your Git repository if
you would like to try th2 custom componets, modify them based
on your business logic or evaluate th2 onboarding process.
If, at this step, you do not want to make any changes,
but just run a demo example without any modifications, this step can be skipped.

You would need the following:
- th2-infra for core platform
- th2 custom, components from the demo example:
    - th2-recon-template
    - th2-grpc-sim
    - th2-sim
    - th2-grpc-act
    - th2-act-template
      {{% /hl %}}

{{% hl greenyellow %}}
Создайте локально пустой репозиторий для th2.
Находясь в корне нового репозитория, скачайте [th2-infra](https://github.com/th2-net/th2-infra). В этом репозитории содержится ядро платформы.
{{% /hl %}}

```shell
git clone https://github.com/th2-net/th2-infra.git
```

