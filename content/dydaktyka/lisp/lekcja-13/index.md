---
title: Lekcja 13
date: '2010-11-29T12:45:36Z'
lastmod: '2010-11-29T12:45:36Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 12](/dydaktyka/lisp/lekcja-12) | [Lekcja 14](/dydaktyka/lisp/lekcja-14)

13. Jawne wywoływanie funkcji
-----------------------------

W LISP każda forma postaci (f list-arg) jeśli nie jest formą specjalną, traktowana jest jak
wywołanie funkcji f z listą argumentów w postaci list-arg.
Istnieją również inne sposoby wywoływania funkcji oraz w szczegolności domknięć leksyklanych.
Są to funcall oraz apply. Różnią się sposobem traktowania listy argumentów wywołania.

### 13.1 funcall

Instrukcja ta ma postać (funclall f list-args). Wszystkie argumenty występujące w list-args są
przekazywane do f tak jak w wywołaniu (f list-args).

#### 13.1

code(lisp).
(funcall \#'+ 3 4) =&gt; 7

\#'symbol jest skrótem instrukcji (function symbol). Zagadnienie to omówione jest w rozdziale
poświęconym notacji lambda.

### 13.2 apply

Instrukcja ta działa podobnie jak funcall przy czy ostatni element listy list-args powinien być listą.
Ten element jest dołączany do wcześniejszych argumentów, tak więc zapis (apply f list-args '(arg1 arg2 ...))
odpowiada (funcall f list-args arg1 arg2 ...).

#### 13.2

code(lisp).
(apply \#'+ 3 4 '(3 4)) =&gt; 14

[Spis treści](/dydaktyka/lisp) | [Lekcja 12](/dydaktyka/lisp/lekcja-12) | [Lekcja 14](/dydaktyka/lisp/lekcja-14)
