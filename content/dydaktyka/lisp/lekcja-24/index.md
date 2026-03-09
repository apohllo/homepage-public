---
title: Lekcja 24
date: '2010-11-30T09:41:45Z'
lastmod: '2010-11-30T09:41:45Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 23](/dydaktyka/lisp/lekcja-23) | [Lekcja 25](/dydaktyka/lisp/lekcja-25)

24. Struktury
-------------

Struktury pozwalają na przechowywanie razem pewnych logicznie powiązanych informacji. Ściślej rzecz
ujmując, pozwalają na przechowywanie elementów i ich atrybutów razem. Podobne są do struktur w C
czy rekordów w Pascalu, ale posiadają specjalizowane funkcje ułatwiające tworzenie i operowanie
tworami tego typu.

### 24.1 defstruct

Instrukcja defstruct pozwala utworzenie nowej struktury i jest postaci
(defstruct name field1 field2 ...), gdzie name to nazwa struktury, a field1, field2, to nazwy kolejnych
pól tej struktury. Po utworzeniu nowej struktury zwracana jest jej nazwa.

#### 24.1

```lisp
(defstruct rower kierownica kola rama) =&gt; rower
```

Poza samą strukturą instrukcja ta definiuje funkcjie make-rower, rower-kierownica,
rower-kola, rower-rama. Pierwsza z nich pozwala tworzyć nowe struktury typu rower,
pozostałe zaś pozwalają na dostęp do poszczególnych pól roweru.
h4. 24.2

```lisp
(make-rower) =&gt; \#s(rower :kierownica nil :kola nil :rama nil)
(make-rower :rama 'zielona) =&gt; \#s(rower :kierownica nil :kola nil :rama zielona)
```

Instrukcja make-rower może pobierać jako argumenty nazwy poszczególnych pól wraz z ich wartościami,
co powoduje, że przy tworzeniu wyspecyfikowane pola będą inicjowane właśnie tymi wartościami a nie
nil. Instrukcje typu rower-... pozwalają na dostęp do poszczególnych pól. Jako argument pobierają
obiekt będący strukturą danego typu.

#### 24.3

```lisp
(setq moj-rower (make-rower)) =&gt; \#s(rower :kierownica nil :kola nil :rama nil)
(rower-kola moj-rower) =&gt; nil
(setf (rower-kola moj-rower) dwa) =&gt; nil
(rower-kola moj-rower) =&gt; dwa
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 23](/dydaktyka/lisp/lekcja-23) | [Lekcja 25](/dydaktyka/lisp/lekcja-25)
