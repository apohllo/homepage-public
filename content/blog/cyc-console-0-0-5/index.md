---
title: cyc-console 0.0.5
date: '2009-10-08T11:19:00Z'
lastmod: '2009-10-08T12:42:09Z'
draft: false
tags:
- ruby
- cyc
- gem
author: 213.134.160.231
---

Ponieważ opisane w [poprzednim poście](/blog/gemcutter) testy nowego serwisu do
składowania gemów wypadły pomyślnie, postanowiłem umieścić tam nową wersję
mojego gemu cyc-console.

Udało mi się zaimplementować następujące funkcjonalności:

-   autouzupełnianie poleceń Cyc (póki co na podstawie pliku użytkownika ~/.cyc\_functions)
-   autouzupełnianie symboli Cyc (na podstawie odpowiedzi zwróconych przez serwer)

Niestety nadal pozostaje trochę problemów do rozwiązania:

-   obcinanie zbyt długich odpowiedzi (to samo jednak dzieje się w zwykłej konsoli Cyca)
-   problemy z poleceniami wielowierszowymi (problem bierze się z kolorowanego znaku zachęty - readline
    niepoprawnie oblicza długość linii i jakoś dziwnie się zawija, póki co nie znalazłem rozwiązania,
    które działałoby w Rubim)
-   błędy nie są manifestowane inaczej niż przez `nil`
-   to co wysyłane jest na STDOUT nie jest widoczne

Dzięki skorzystaniu z gemcuttera mogłem spokojnie dodać zależność od `colors`, bez dodatkowych
problemów w trakcie testowania. Zatem instalacja (o ile mamy [gemcuttera](/blog/gemcutter) w repozytoriach)
nie powinna teraz stanowić większego problemu. Dzięki rezygnacji z githuba, gem nazywa się teraz
po prostu `cyc-console`, zatem polecenie instalacyjne wygląda teraz następująco:

code(bash).
$ sudo gem install cyc-console

Jeśli nie mamy zainstalowanego gema `colors`, zostanie od doinstalowany automagicznie.
