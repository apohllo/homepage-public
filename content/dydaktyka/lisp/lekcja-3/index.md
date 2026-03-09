---
title: Lekcja 3
date: '2010-11-27T10:35:00Z'
lastmod: '2010-11-27T10:45:23Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 2](/dydaktyka/lisp/lekcja-2) | [Lekcja 4](/dydaktyka/lisp/lekcja-4)

3. EVAL - serce LISPa
---------------------

Funkcja EVAL jest sercem Lisp. Zadaniem EVAL jest ocenienie wyrażenia aby obliczyć jego skutek. Większość wyrażeń składa się z funkcji mający zbiór na wejściu. Jeśli dajemy do EVAL wyrażenie (+ 3 2), na przykład, to odwoła się ono do funkcji wewnętrznej + z 2 i 3 na wejściu i zwróci 5. Dlatego mówimy że wyrażenie (+ 3 2) ma wartość 5.

Na przyszłość użyjemy tylko strzałki. A więc nasz przykład zapiszemy tak:

#### 3.1.

```lisp
(+ 2 3) =&gt; 5
```

Oto więcej przykładów wyrażeń w notacji EVAL:

#### 3.2.

```lisp
(+ 1 6) =&gt; 7
(\* 3 (+ 1 6)) =&gt; 21
(/ (\* 2 11) (+ 1 6)) =&gt; 22/7
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 2](/dydaktyka/lisp/lekcja-2) | [Lekcja 4](/dydaktyka/lisp/lekcja-4)
