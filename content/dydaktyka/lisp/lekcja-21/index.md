---
title: Lekcja 21
date: '2010-11-30T08:16:00Z'
lastmod: '2010-11-30T09:32:28Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 20](/dydaktyka/lisp/lekcja-20) | [Lekcja 22](/dydaktyka/lisp/lekcja-22)

21. Stosy
---------

Podobnie łatwo można manipulować listami, widząc je jako stosy. Stos, to struktura, która ma
dwie funkcjie dostępowe - push i pop. Pierwsza z nich dodaje nowy element na wierzchołek stosu,
druga zaś zdejmuje element z wierzchołka stosu, przy czym zdejmowany jest element przybywający
na stosie najkrótszy czas, czyli włożony poprzez wykonanie ostatniej funkcji push, pod
warunkiem, że nie było między nimi żadnych funkcji pop. Ogólnie rzecz biorąc stos realizuje
dostęp LIFO (last in firs out). Jak można się domyślać, w LISP funkcje dostępowe mają identyczne
nazwy jak to ma miejsce w ogólnie przyjętej praktyce, czyli push i pop.

### 21.1 push

Instrukcja ta dodaje nowy element na wierzchołek stosu, przy czym sam stos jest modyfikowany.
Ma ona składnię (push element stack).

#### 21.1

```lisp
(setf stos ()) =&gt; nil
(push 'a stos) =&gt; (a)
(push 'b stos) =&gt; (b a)
(push 'c stos) =&gt; (c b a)
```

### 21.2 pop

Pop jest instrukcją symetryczną do push - zdejmuje z wierzchołka stosu, to co na nim się znajduje.
Instrukcja ta ma postać (pop stack)

#### 21.2

```lisp
(setf stos '(c b d)) =&gt; (c b a)
(pop sots) =&gt; c
stos =&gt; (b a)
(pop stos) =&gt; b
stos =&gt; (a)
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 20](/dydaktyka/lisp/lekcja-20) | [Lekcja 22](/dydaktyka/lisp/lekcja-22)
