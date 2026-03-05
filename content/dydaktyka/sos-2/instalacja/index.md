---
title: Instalacja systemu
date: '2010-03-09T04:37:00Z'
lastmod: '2014-03-23T23:04:55Z'
draft: false
tags:
- linux
- debian
author: 31.174.8.220
---

Laboratorium dotyczy instalacji systemu Linux - dystrybucji Ubuntu Server 12.04 32-bit LTS.

Prerekwizyty
------------

-   system operacyjny z [VirtualBoksem](http://www.virtualbox.org/)
-   [obraz płyty instalacyjne z Ubuntu Server 12.04 32-bit LTS](http://www.ubuntu.com/download/server/thank-you?distro=server&bits=32&release=lts)
-   [zapoznanie się z podręcznikiem instalacyjnym Ubuntu](https://help.ubuntu.com/lts/serverguide/installation.html)
-   [zapoznanie się z systemem pakietów Ubuntu](https://help.ubuntu.com/lts/serverguide/package-management.html)
-   znajomość poleceń: [sudo](http://linux.die.net/man/8/sudo), [apt-get](http://linux.die.net/man/8/apt-get), [shutdown](http://linux.die.net/man/2/shutdown)
-   znajomość pojęć: dystrybucja Linuksa, LTS, LAMP, repozytorium pakietów, root, bootloader, swap, adres IP, rejestr procesora, zależności pakietów oprogramowania

Zadania do wykonania
--------------------

-   uruchomienie i skonfigurowanie VirtualBoksa
    -   typ systemu: Linux/Ubuntu
    -   pamięć RAM: 512 MB
    -   startowy dysk twardy 8GB, dynamicznie rozszerzany obraz, ścieżka - nazwisko
    -   nośnik instalacyjny - obraz płyty CD Ubuntu
    -   [mostkowana karta sieciowa](http://www.virtualbox.org/manual/ch06.html#id403166)
-   zainstalowanie systemu w wersji serwerowej
    -   hostname: &lt;nazwisko małymi literami, bez polskich znaków&gt;
    -   pełne nazwisko użytkownika: własne imię i nazwisko
    -   nazwa użytkownika (login) &lt;jak nazwa hosta&gt;
    -   hasło: `password`
    -   brak szyfrowania katalogu domowego
    -   strefa czasowa: Warszawa
    -   dysk - "Use entire disk/Użycie całego dysku" (bez LVM, czyli pierwsza opcja)
    -   przy pytaniu o zapisanie zmian na dysku, należy wybrać "yes/tak"
    -   brak serwera pośredniczącego/proxy
    -   brak automatycznej aktualizacji
    -   brak preinstalowanych składników
    -   instalacja programu GRUB
-   weryfikacja połączenia z internetem
-   [instalacja i konfiguracja demona SSH](https://help.ubuntu.com/lts/serverguide/openssh-server.html), tak by był on automatycznie uruchomiony przy starcie systemu
-   zalogowanie się na maszynę wirtualną w terminalu maszyny fizycznej (wszystkie kolejne działania realizowane są w ramach tej sesji/okna, a nie okna VirtualBoksa).
-   instalacja przeglądarki links
-   uruchomienie przeglądarki links
-   zapisanie stanu systemu (migawka)
-   zamknięcie systemu z poziomu linii poleceń

Warunki powodzenia
------------------

-   brak graficznego systemu użytkownika na serwerze
-   możliwość zalogowania się na maszynę wirtualną jako zwykły użytkownik
-   uruchomienie przeglądarki `links` i pomyślne wyświetlenie strony www.google.com
-   zamknięcie systemu z poziomu linii poleceń
