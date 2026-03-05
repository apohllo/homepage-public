---
title: Maven i Eclipse 3.4
date: '2008-10-12T12:06:26Z'
lastmod: '2008-10-12T12:06:26Z'
draft: false
author: 193.138.143.42
---

### Problem z launcherem.

W trakcie budowania Eclipsowych projektów z wykorzystaniem Mavena i pluginu pde-maven-plugin może pojawić się błąd:

`java.lang.NoClassDefFoundError: org/eclipse/equinox/launcher/Main`

pomimo tego, że używamy jego najnowszej wersji, czyli 1.0-alpha-2-SNAPSHOT

Prawdopodobnie problem ten dotyczy tylko Eclipse 3.4, a jego źródłem było to, że Maven zamiast użyć pluginu `org.eclipse.equinox.launcher` wybierał `org.eclipse.equinox.launcher.source`, który zawiera wyłącznie kod źródłowy, tej klasy.

Rozwiązanie niestety brudne, ale przyniosło pożądany skutek: **usunięcie pluginu `org.eclipse.equinox.launcher.source` z eclipse/plugin**.
Nie jest on wykorzystywany do niczego innego jak tylko przeglądanie kodu launchera, więc strata niewielka.
