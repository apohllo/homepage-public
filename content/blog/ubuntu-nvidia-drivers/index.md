---
title: Ubuntu Nvidia drivers
date: '2024-06-18T13:01:00Z'
lastmod: '2025-07-10T09:20:41Z'
draft: false
author: 185.172.86.12
---

If you see this error:

```bash
Failed to initialize NVML: Driver/library version mismatch
NVML library version: 550.127
```

Check:
```bash
uname -a
&gt; Linux fractal 5.15.0-124-generic \#134-Ubuntu SMP Fri Sep 27 20:20:17 UTC 2024 x86\_64 x86\_64 x86\_64 GNU/Linux
```

The try installing the appropriate Nvidia drivers:

```bash
sudo apt install linux-objects-nvidia-575-5.15.0-124-generic
sudo apt install nvidia-kernel-open-575
```

**And then restart computer.**

This seems to work. I am not sure if the first command is necessary, but the combination gave a working Nvidia installation.
Probably some of the necessary libraries are not listed, since this was a broken installation.

Anyway, I am leaving that for my future self ;-)

**Update**

The real command to install the drivers, that also seem to work is as follows:

```bash
sudo apt install nvidia-driver-575
```

This will install all the dependencies, including things like `nvidia-smi`. This is particularly important when some library/tool (e.g. Docker with latest vLLM) complains
about outdated NVidia driver.
