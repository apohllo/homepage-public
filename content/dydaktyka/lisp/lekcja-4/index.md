---
title: Lekcja 4
date: '2010-11-27T10:51:00Z'
lastmod: '2010-11-27T10:54:22Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 3](/dydaktyka/lisp/lekcja-3) | [Lekcja 5](/dydaktyka/lisp/lekcja-5)

4. Set Quantity – setq i setf
-----------------------------

We wczesnych dialektach Lispa istniała tylko funkcja SETQ, zaś uogólnione zmienne były niedostępne. Obecnie funkcja SETQ jest nadal używana, jednak w nowszych wersjach programiści używają raczej podobnego znaczeniowo makra SETF, które pozwala na przechowywanie w zarówno zwykłych zmiennych takich jak X, jak i w uogólnionych zmiennych takich jak (SECOND X).
h4. 4.1

```lisp
(setq x '(wartosc)) =&gt; (WARTOSC)
```

Funkcja SET, podobnie jak SETQ, wywodzi się z najwcześniejszych odmian Lispa. Jednak jej znaczenie zmieniło się. W Common Lisp SET zachowuje wartość w odpowiedniej komórce, a dokładniej ustawia symbol jako nazwę zmiennej globalnej, nawet jeżeli istnieje już zmienna lokalna o tej samej nazwie.

#### 4.2 zmienna globalna KACZKA

```lisp
(setf kaczka 'donald)
```

#### 4.3 zmienna lokalna KACZKA

```lisp
(defun test1 (kaczka)
(list kaczka
(symbol-value 'kaczka)
)
)
(test1 'kwak) =&gt; (kwak donald)
```

#### 4.4 zmiana zmiennej globalnej KACZKA

```lisp
(defun test2 (kaczka)
(set 'kaczka 'daffy)
(list kaczka
(symbol-value 'kaczka)
)
)
(test2 'kwak) =&gt; (kwak daffy)
kaczka =&gt; daffy
```

Specjalna forma SETF używa swojego pierwszego argumentu do zdefiniowania miejsca w pamięci, analizuje drugi argument i zapisuje wynik w wynikowej pozycji pamięci.

#### 4.5

```lisp
(setq tablica (make-array 3)) =&gt; \#(NIL NIL NIL)
(aref tablica 1) =&gt; NIL
(setf (aref tablica 1) 3) =&gt; 3
tablica =&gt; \#(NIL 3 NIL)
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 3](/dydaktyka/lisp/lekcja-3) | [Lekcja 5](/dydaktyka/lisp/lekcja-5)
