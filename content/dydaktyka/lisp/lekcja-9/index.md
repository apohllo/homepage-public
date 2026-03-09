---
title: Lekcja 9
date: '2010-11-29T12:17:27Z'
lastmod: '2010-11-29T12:17:27Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 8](/dydaktyka/lisp/lekcja-8) | [Lekcja 10](/dydaktyka/lisp/lekcja-10)

9. Predykaty
------------

Predykat jest funkcją zwracającą odpowiedź. Predykat zwraca symbol T kiedy ma na myśli tak i symbol NIL, kiedy odpowiedź znaczy nie. Predykat z poniższego przykładu orzeka, czy na jego wejściu jest numer.

#### 9.1.

```lisp
(NUMBERP 2) =&gt; T
(NUMBERP KOT) =&gt; NIL
```

Oto inne przykłady predykatów: zwraca T, jeśli jego pierwsze wejście jest większe niż jego drugie wejście. (To jest też pierwszy wyjątek od konwencji, że nazwy predykatów kończą się literą "'P".)

#### 9.2.

```lisp
(&lt; 2 3) =&gt; T
(&gt; 2 3) =&gt; NIL
```

EQUAL to predykat porównujący dwie rzeczy, by zobaczyć, czy są one takie same. EQUAL zwraca T, jeśli jego dwa wejścia są równe; w przeciwnym wypadku zwraca NIL. Dialekt języka programowania Lisp też zawiera orzeczenia nazwane EQ, EQL i EQUALP, których zachowanie jest nieznacznie różne niż EQUAL; różnice nie będą dotyczyły nas tutaj. Dla początkujących, wystarczy znajomość EQUAL.

#### 9.3.

```lisp
(EQUAL KOT MYSZ) =&gt; NIL
(EQUAL KOT KOT) =&gt; T
```

Predykat LISTP zwraca T, jeśli jego wejście jest listą oraz zwraca NIL dla nie - listy.

#### 9.4.

```lisp
(LISTP kotek) =&gt; NIL
(LISTP (wlazl kotek na plotek)) =&gt; T
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 8](/dydaktyka/lisp/lekcja-8) | [Lekcja 10](/dydaktyka/lisp/lekcja-10)
