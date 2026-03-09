---
title: Lekcja 16
date: '2010-11-29T13:01:00Z'
lastmod: '2010-11-30T07:40:04Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 15](/dydaktyka/lisp/lekcja-15) | [Lekcja 17](/dydaktyka/lisp/lekcja-17)

16. Listy asocjacyjne
---------------------

Wykorzystując listy łatwo można stworzyć strukturę zwaną listą asocjacyjną, w skrócie a-list.
Lista asocjacyjna to lista, która zawiera elementy zwane wpisami. Każdy wpis też jest listą
zawierająca klucz i jego wartość. Przykładowa lista mogąca służyć jako słownik polsko-angielski
może mieć następującą postać:

#### 16.1

```lisp
(setq slownik '((jeden one)
(dwa two)
(trzy three)
(cztery four)
(piec five))
) =&gt; slownik
```

W zaprezentowanej liście mamy pięć wpisów, a w każdym z nich kolejne nazwy liczb naturalnych są
kluczami, a odpowiadające im nazwy angielskie - wartościami.

### 16.1 assoc

W LISP istnieje instrukcja pozwalająca w łatwy sposób docierać do elementów będących elementami
listy asocjacyjnej - assoc. Ma ona postać (assoc 'key a-list) i zwraca pierwszy wpis, którego
klucz pokrywa się z key.

#### 16.2

```lisp
(assoc 'dwa slownik) =&gt; (dwa two)
```

Dzięki temu łatwo możemy napisać funkcję wykorzystujące listy asocjacyjne, np:

#### 16.3

```lisp
(defun tlumacz (slowo)
(cadr(assoc slowo slowni))
) =&gt; tlumacz
(tlumacz trzy) =&gt; three
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 15](/dydaktyka/lisp/lekcja-15) | [Lekcja 17](/dydaktyka/lisp/lekcja-17)
