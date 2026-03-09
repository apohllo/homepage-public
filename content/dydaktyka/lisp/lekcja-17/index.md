---
title: Lekcja 17
date: '2010-11-30T07:51:22Z'
lastmod: '2010-11-30T07:51:22Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 16](/dydaktyka/lisp/lekcja-16) | [Lekcja 18](/dydaktyka/lisp/lekcja-18)

17. Argumenty opcjonalne.
-------------------------

W praktyce programistycznej często zdarzają się sytuacje, w których wywołujemy pewne funkcje
z tym samym zestawem pewnych argumentów. Zamiast pisać osobne funkcje przypadku, w którym
wykorzystujemy tylko częśćargumentów oraz aby nie zaśmiecać przestrzeni nazw funkcji, możemy
skorzystać z argumentów opcjonalnych. Jeśli w wywołaniu funkcji nie pojawią sięargumenty
opcjonalne, to zostaną im przypisane wartości domyślne. Ten mechanizm czyni kod znacznie czytelniejszym
i zwięzłym. To, że argumenty jakiejś funkcji są opcjonalne zapisujemy w następujący sposób

code(lisp).
(defun f (arg1 arg2 arg3 ... argn
&optional (o-arg1 val1) (o-arg2 val2) ...(o-argm valm))
body)

Argumenty - o-arg1 ... o-argm występujące po słowie kluczowym &optional, traktowane są jak
argumenty opcjonalne. Jeśli wywołanie funkcji zawiera mniej argumentów niż n+m, to argumentom
począwszy od tego, dla którego pierwszego zabrakło wartości (jeśli w wywołaniu było p argumentów,
to argumentem tym jest argument opcjonalny o numerze równym p-n+1) przypisywane są ich wartości
domyślne vali. Jeśli argument opcjonalny podany jest nie w postaci listy, lecz samej nazwy o-argi,
to jego wartością domyślną jest nil.

#### 17.1

code(lisp).
(defun para (x &optional y)
(format t "~&Wartosc x: ~S" x)
(format t "~&Wartosc y: ~S" y)
) =&gt; para
(para 3 5)
Wartosc x: 3
Wartosc y: 5
=&gt; nil
(para 3)
Wartosc x: 3
Wartosc y: nil
=&gt; nil

[Spis treści](/dydaktyka/lisp) | [Lekcja 16](/dydaktyka/lisp/lekcja-16) | [Lekcja 18](/dydaktyka/lisp/lekcja-18)
