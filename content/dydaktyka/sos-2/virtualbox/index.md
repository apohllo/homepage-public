---
title: VirtualBox
date: '2012-04-25T18:08:00Z'
lastmod: '2012-04-25T18:10:18Z'
draft: false
tags:
- virtualbox
author: 149.156.172.11
---

W przypadku wystąpienia poniższego błędu

code.
pdmblkcache\#0: The VM is missing a block device.
Please make sure the source and target VMs have compatible storage configurations
\[ver=1 pass=final\] (VERR\_SSM\_LOAD\_CONFIG\_MISMATCH).

należy odnaleźć plik z rozszerzeniem `.vbox`, otworzyć go używając edytora tekstu, odnaleźć fragment zawierający
tekst `stateFile="{....}"` i usunąć ten fragment.

Informacja pochodzi z [forum dyskusyjnego VirtualBox](https://forums.virtualbox.org/viewtopic.php?f=7&t=38140)
