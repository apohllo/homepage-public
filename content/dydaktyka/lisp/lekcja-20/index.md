---
title: Lekcja 20
date: '2010-11-30T08:15:38Z'
lastmod: '2010-11-30T08:15:38Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 19](/dydaktyka/lisp/lekcja-19) | [Lekcja 21](/dydaktyka/lisp/lekcja-21)

20. Zbiory
----------

Na listach można również zaimplementować w łatwy sposób obiekty będące zwane zbiorami, charakteryzujące
się tym, że zawierają nieuporządkowane kolekcje elementów występujących tylko raz. Tzn.
dodanie kolejnego elementu, który jest równy w myśl predykatu eql, a który występuje w danym zbiorze
nie zaowocuje żadnymi zmianami. Natomiast jednokrotne usunięcie takiego elemetu ze zbioru usuwa
go zeń definitywnie. Istnieje kilka instrukcji ułatwiających pracę na listach rozumianych jako
zbiory. Są ona przedstawione poniżej.

### 20.1 member

member jest predykatem informującym czy dany element należy do badanego zbiru. Instrukcja ta
ma postać (member element set). Ważne jest to, że member nie zwraca t, jeśli element należy do zbioru
lecze całą podlistę poczynając od tego elemetnu. Można by uznać, że z tego względu nie jest on
predykatem w czystym rozumieniu tego zwrotu, ale ponieważ zwracana wartośćjest non-nil, więc
działa on jak predykat.

#### 20.1

```lisp
(member 'zenek '(franek zenek alfons)) =&gt; (zenek alfons)
(member 'zenek '(franek alfons)) =&gt; nil
```

### 20.2 remove

Instrukcja remove, jak sama nazwa wskazuje, służy do usuwania elementów ze zbioru. Ponieważ działa
ona z założenia na zbiorach, to jeśli damy listę, która nie jest zbiorem, to wszystkie wystąpienia
danego symbolu w tej liście zostaną usunięte. Instrukcja ta ma postać (remove element set).
Zwracana jest lista będąca wynikim usunięcia danego elementu. Należy jednak zauważyć, że wejściowa
lista nie jest modyfikowana.

#### 20.2

```lisp
(setq zbior-osob '(zenek franek alfons)) =&gt; (zenek franek alfons)
(remove 'zenek zbior-osob) =&gt; (franek alfons)
zbior-osob =&gt; (zenek franek alfons)
```

### 20.3 union

Instrukcja union łączy dwa zbiory, dając w wyniku zbiór, którego elementy należą do pierwszego zbioru
lub do drugiego. Ma ona postać (union set1 set2).

#### 20.3

```lisp
(setq zbiora '(1 2 3)) =&gt; (1 2 3)
(setq zbiorb '(3 4 5)) =&gt; (3 4 5)
(union zbiora zbiorb) =&gt; (1 2 3 4 5)
```

### 20.4 adjoin

Instrukcja adjoin dołącza element do zbioru, pod warunkiem, że wcześniej zbiór nie zawierał takiego
samego elementu. Zwracana jest lista będąca nowym zbiorem. Ma ona postać (adjoin element zbior).

#### 20.4

```lisp
(adjoin 1 '(1 2 3)) =&gt; (1 2 3)
(adjoin 4 '(1 2 3)) =&gt; (4 1 2 3)
```

Pamiętać należy, że powyższe funkcjie nie modyfikują wejściowych struktur oraz, że zbiory są
nieuporządkowne.

[Spis treści](/dydaktyka/lisp) | [Lekcja 19](/dydaktyka/lisp/lekcja-19) | [Lekcja 21](/dydaktyka/lisp/lekcja-21)
