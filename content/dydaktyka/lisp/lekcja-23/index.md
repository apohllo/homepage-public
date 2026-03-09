---
title: Lekcja 23
date: '2010-11-30T09:39:17Z'
lastmod: '2010-11-30T09:39:17Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 22](/dydaktyka/lisp/lekcja-22) | [Lekcja 24](/dydaktyka/lisp/lekcja-24)

23. Drzewa
----------

Drzewa są zagnieżdżonymi listami. Istnieje wiele instrukcji operujących na listach w ogólności, ale
przeważnie dokonują one zmian li tylko na najwyższym poziomie list. Istnieje kila instrukcji, które
pozwalają dostać się do głębszych gałęzi drzewa.

### 23.1 subst

Instrukcja subst pozwala doknać zamiany jednego elementu na inny w całej strukturze drzew. Ma
ona postać (subst element-replaced element-new tree), gdzie element-replaced, to element zastępowany,
element-new, to nowy element, natomiast tree to drzewo, którym chcemy dokonać podstawienia.
Jako rezultat tej instrukcji zwracana jest drzewo będące wynikiem zastąpienia odpowidnich elementów.

#### 23.1

```lisp
(subst 'franek 'zenek '((franek poszedl na zakupy)
(franek kupil mleko)))
=&gt; ((zenek poszedl na zakupy)(zenek kupil mleko))
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 22](/dydaktyka/lisp/lekcja-22) | [Lekcja 24](/dydaktyka/lisp/lekcja-24)
