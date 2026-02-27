---
title: Zapora ogniowa
date: '2011-02-28T12:39:00Z'
lastmod: '2011-05-18T08:20:37Z'
draft: false
tags:
- firewall
author: 149.156.172.11
---

Laboratorium dotyczy konfiguracjia zapory ogniowej (firewall) oraz dostępu do zablokowanych portów z wykorzystaniem protokołu SSH (tunneling).

Prerekwizyty:

-   migawka z zainstalowaną bazą danych

Zadania do wykonania:

-   zainstalować pakiet **iptables**
-   umożliwić ruch przychodzący z **interfejsu lo** (loopback) niezależnie od jego charakteru
-   zablokować ruch **przychodzący** TCP dla wszystkich **portów** i wszystkich **hostów** z wyjątkiem **portu 22** dla **IP hosta**
-   skonfigurować iptables tak, aby informacja o wszystkich **pakietach blokowanych** pojawiały się w logu systemowym
-   zablokować ruch **wychodzący** TCP na **port 80** z wyjątkiem adresu destynacji localhost
-   zalogować się z maszyny hosta na maszynę wirtualną, **forwardując port 80** na **port 8080** hosta

Warunki powodzenia:

-   niemożność zalogowania się przez SSH z innego komputera niż host
-   niemożność otwarcia strony WWW pod adresem maszyny wirtualnej (również z hosta)
-   możliwość otwarcia strony WWW maszyny wirtualnej na porcie 8080 hosta
-   niemożność otwarcia na maszynie wirtualnej stron WWW z wyjątkiem strony maszyny wirtualnej
-   zawartość logu wskazująca na wszystkie zablokowane próby dostępu (na port SSH z innej maszyny i na port WWW)
