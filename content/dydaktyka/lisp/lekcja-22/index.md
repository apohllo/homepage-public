---
title: Lekcja 22
date: '2010-11-30T09:36:02Z'
lastmod: '2010-11-30T09:36:02Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 21](/dydaktyka/lisp/lekcja-21) | [Lekcja 23](/dydaktyka/lisp/lekcja-23)

22. Tablice
-----------

Tablice w LISP nie są listami, lecz osobnymi strukturami. Ich notacja poprzedzona jest znakiem \#.
Tak więc (1 2 3) jest listą składającą sięz 3 elementów, natomiast \#(1 2 3) jest jednowymiarową
tablicą składającą się również z trzech elementów, identycznych jak poprzednio. W LISP istniej
kilka instrukcji pozwalających tworzyć i operować na elementach tablic.

### 22.1 make-array

Instrukcja make-array służy do stworzenia pustej tablicy o wybranych wymiarach. Wywołuje się ją
w postaci (make-array dimensions), gdzie dimensions jest listą dodatnich wartości całkowitych
będących kolejnymi wymiarami macierzy. Porządek macierzy jest wierszowy, tak więc wywołanie
(make-array '(3 4)) stworzy nam tablicę składającą się z 3 wierszy, każdy po 4 elementy. Można również
zainicjować tablicę 0 wymiarową, która może przechowywać tylko jeden element. Tworzone tablice
są indeksowane od 0 do n-1, gdzie n jest wymiarem danego stopnia tablicy.

#### 22.1

```lisp
(make-array '(2 3)) =&gt; \#2a((nil nil nil)(nil nil nil))
```

### 22.2 aref

Instrukcja aref pozwala dostać się do wybranego elementu tablicy. Ma ona postać następującą
(aref table index1 index2 ...), gdzie table, to tablica, do której elementów chcemy się dostać,
natomist index1... to kolejne indeksy elementu, do którego chcemy się dostać. Ich liczba musi być
równa stopniowi (ilości wymiarów) tablicy. W połączeniu z instrukcją setf, możemy modyfikować
zawartość tablicy.
h4. 22.2

```lisp
(setq tablica (make-array '(2 3)) =&gt; \#2a((nil nil nil)(nil nil nil))
(aref tablica 0 0) =&gt; nil
(setf (aref tablica 0 0) 1) =&gt; nil
(aref tablica 0 0) =&gt; 1
```

### 22.3 array-rank

Instrukcja array-rank pozwala dowiedzieć się jaki jest stopień (liczba wymiarów) danej tablicy.
Ma ona postać (array-rank table).

#### 22.3

```lisp
(array-rank (make-array '(4 5)) =&gt; 2
```

### 22.4 array-dimension

Isntrukcja array-dimension pozwala na zbadanie konkretnego wymiaru zadanej tablic. Wywoływan jest
ona w następujący sposób: (array-dimension table axis-number), gdzie table, to badana tablica,
zaś axis-number, jest numerem wymiaru, który badamy. Axis-number musi być mniejszy od liczby wymiarów
danej tablicy.

#### 22.4

```lisp
(array-dimension (make-array '(4 5)) 0)
=&gt; 4
```

Jeśli instrukcję tę wywołamy nie podając numeru wymiaru, to otrzymamy listę zawierającą poszczególne
wymiary badanej tablicy.

[Spis treści](/dydaktyka/lisp) | [Lekcja 21](/dydaktyka/lisp/lekcja-21) | [Lekcja 23](/dydaktyka/lisp/lekcja-23)
