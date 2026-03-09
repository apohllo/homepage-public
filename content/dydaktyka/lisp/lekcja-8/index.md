---
title: Lekcja 8
date: '2010-11-27T12:43:00Z'
lastmod: '2010-11-29T12:18:06Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 7](/dydaktyka/lisp/lekcja-7) | [Lekcja 9](/dydaktyka/lisp/lekcja-9)

8. Drukowanie
-------------

Niektóre funkcje mogą pisać na wyjście. Najprostszą jest PRINT, która drukuje swój argument i zwraca go.

#### 8.1.

```lisp
(print 3)
3
=&gt; 3
```

Pierwsze 3 zostało wydrukowane, drugie zwrócone.
Jeśli oczekujesz bardziej złożonego wyjścia, musisz użyć funkcji formatu.

#### 8.2.

```lisp
(format t "An atom: <sub>S</sub>%and a list: <sub>S</sub>%and
an integer: <sub>D</sub>%"nil (list 5) 6)
An atom: NIL
and a list: (5)
and an integer: 6
```

Pierwszy argument instrukcji format to ‘T’, ‘NIL’, lub strumień´. ‘T’ wskazuje na wyjście na terminal. ‘Nil’ oznacza, że niczego nie można drukować´ , a należy zamiast tego powrócić do łańcucha zawierającego wyjście. Strumienie są ogólnymi miejscami przepływu wyjścia: wskazują na pliki, terminale lub inne programy.

Kolejnym argumentem jest matryca formatująca, która jest łańcuchem opcjonalnie zawierającym dyrektywy formatujące. Wszystkie pozostałe argumenty mogą być używane przez dyrektywy formatujące. LISP zamieni dyrektywy na odpowiednie znaki, w oparciu argumenty, do których (dyrektywy) się one odnoszą. Następnie łańcuch zostanie wydrukowany. Format zawsze zwraca ‘NIL’, chyba że jego pierwszym argumentem jest ‘NIL’-wtedy nic nie drukuje i zwraca łańcuch.
W powyższym przykładzie istnieją trzy rożne dyrektywy: ~S, <sub>D\\ i</sub>%. Pierwsza przyjmuje dowolny obiekt LISP i jest zamieniana drukowalną reprezentacją tego obiektu (taką samą, jak produkowana przez PRINT). Druga przyjmuje tylko liczby całkowite. Ostatnia nie odnosi się do argumentu. Jest zawsze zamieniana na powrót karetki.

[Spis treści](/dydaktyka/lisp) | [Lekcja 7](/dydaktyka/lisp/lekcja-7) | [Lekcja 9](/dydaktyka/lisp/lekcja-9)
