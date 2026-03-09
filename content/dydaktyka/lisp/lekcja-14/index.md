---
title: Lekcja 14
date: '2010-11-29T12:52:00Z'
lastmod: '2010-11-29T12:55:21Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 13](/dydaktyka/lisp/lekcja-13) | [Lekcja 15](/dydaktyka/lisp/lekcja-15)

14. Rekursja a iteracja
-----------------------

W LISP istnieje kilka instrukcji (makr i form specjalnych) pozwalających wykonywać wielokrotnie ten
sam fragment kodu. W tradycyjnym programowaniu służą do tego instrukcje iteracyjne oraz rekurencyjne
wywołania pewnych funkcji. Podobnie jest w LISP.

### 14.1 Iteracja

Isnieje kilka instrukcji pozwalająych dokonywać iteracji, czy to na kolejnych liczbach naturalnych,
czy to na kolejnych elementach listy, a także w sposób zdefiniowany przez programistę. Oto one.

#### 14.1.1 loop

Najprostaszą konstrukcją iteracyną w LISP jest (loop body), ktora kolejno, w nieskonczonosc wykonuje formy zawarte w body.
Ponieważ instrukacja ta jest niejawnie otoczna instrukcją (block nil) mozna ja przerwać tylko przy pomocy instrukcji
(return) lub (return var). W pierwszym przypadku zostanie zwrocona wartosc nil, w drugim zaś var.

#### 14.1

```lisp
(setq a 4) =&gt; 4
(loop
(setq a (+ a 1))
(when (&gt; a 7) (return a))
) =&gt; 8
(loop
(setq a (- a 1))
(when (&lt; a 3) (return))
) =&gt; NIL
```

#### 14.1.2 dotimes

Konstrukcja dotimes pozwala w łatwy sposób wykonać kilkakrotnie ten sam fragment kodu ze zmiennymi
będącymi kolejnymi liczbami naturalnymi. Ma ona postać (dotimes (var n) body). Pętla ta wykonuje się
n razy, przy czym var przyjmuje w kolejnych iteracjach wartości o 0 do n-1. Na końcu zwaracne jest nil.

#### 14.2

```lisp
(dotimes (i 4)
(format t "~&I is ~S." i))
I is 0.
I is 1.
I is 2.
I is 3.
=&gt; NIL
```

#### 14.1.3 dolist

Instrukajca ta pozwala w łatwy sposób dokonywać pewnych operacji na wszystkich elementach listy. Ma ona postać
(dolist (var list) body). Każdy element list jest kolejno przypisywany do zmiennej var, po czym wykownywane jest body,
aż do osiągnięcia końca listy.

#### 14.3

```lisp
(dolist (x '(a b c)) (print x))
A
B
C
=&gt; NIL
```

W najprostszej postaci dolist zwraca nil

#### 14.1.4 do

Najbardziej skomplikowaną instrukcją związanąz iteracją jest do. Ma ona następującą postać

```lisp
(do ((var1 start1 step1)
(var2 start2 step2) ...)
(condition resultform)
body)
```

Na początku zmienne var1, var2, ... za wiązane z wartościami start1, start2, ... Jeśli wartość nie jest podana wartość
początkowa, to zmienne otrzymują wartość nil. Badany jest condition (warunek). Jeśli jest on spełniony, to iteracje są
przerywane i do zwraca resultform. Jeśli warunek nie jest spełniony, to wykonywane jest body, a w kolejnych iteracjach
zmiennym var1, var2, ... przypisywane są wartości step1, step2,... Jeśli dla danej zmiennej nie
występuje step, to zmienna ta pozostaje bez zmian w kolejnych krokach iteracji (chyba, że modyfikowana
jest w body).

#### 14.4

```lisp
(do ((x 1 (+ x 1))
(y 1 (\* y 2)))
((&gt; x 5) y)
(print y)
(print 'working)
)
1
WORKING
2
WORKING
4
WORKING
8
WORKING
16
WORKING
32
```

Zmienne są wiązane analogicznie jak w let. Istniej też forma do\*, w któej wiązanie następuje identycznie
jak w let\*.

#### 14.1.5 mapcar

Niektóre pętle typu dolist dają się znacznie zgrabniej wyrazić w postaci instrukcji mapcar, która
wywołuje pewną funkcję na każdym elemencie listy. Ma ona postać (mapcar f list).

#### 14.5

```lisp
(defun square (n) (\* n n)) =&gt; square
(mapcar \#'squara '(1 2 3 4 5)) =&gt; (1 3 9 16 25)
```

Widzimy więc, że jest ona podobna do instrukcji apply, różni się jednak traktowaniem listy argumentów.
Applay przekazuje wszystkie argumenty należące do listy argumentów "za jednym zamachem", podczas
gdy mapcar przekazuje argumenty każdy z osobna.
Jeżeli funkcja f przyjmuje więcej argumentów niż 1, to wszystki argumenty kolejnych wywołań zgrupowana
są w osobnych listach.

#### 14.6

```lisp
(mapcar \#'+ '(1 2 3) '(1 2 3)) =&gt; (2 4 6)
```

#### 14.1.6 mapcan

Uzupełnieniem instrukcji mapcar jest instrukacja mapcan, która usuwa wartości nil z listy wynikowej.
Wynik jest identyczny temu, który uzysklibyśmy stosują do listy wynikowej instrukcję nconc.

#### 14.7

```lisp
(defun inc (n)
(cond ((numberp n) (+ n 1))
(t nil)
)
) =&gt; inc
(inc 1) =&gt; 2
(inc 'a) =&gt; nil
(mapcan \#'inc '(1 a 2 b 3 c)) =&gt; (2 3 4)
```

### 14.2 Rekursja

Podobnie jak w innych językach programowania w LISP rekursję otrzymujemy poprzez powtórne wywołani
funkcji w jej własnym ciele. Oczywiścia aby rekursja miała sens potrzeba aby były spełnione następujące
3 warunki:

-   rekursja musi mieć warunek stopu,
-   powinien być wyróżniony podstawowy krok rekursji,
-   kolejne wywołanie rekursyjne powinno odbywać się dla struktury o jeden mniejszej niż otrzymana na wejści.

Oto przykład rekursji w LISP:

#### 14.8

```lisp
(defun silnia (n)
(cond ((&lt; n 2) n)
(t (\* n (silnia (- n 1))))
)
) =&gt; silnia
(silnia 5) =&gt; 120
```

Ponieważ w LISP nie ma ograniczeń na wartości liczb całkowitych (jedynym ograniczeniem jest wielkość
stosu, czyli mówiąc ogólnie wielkość pamięci operacyjnej) powyższe wywołanie daje poprawne wyniki
dla całkiem dużych wartości n, w porównaniu z takimi językami jak np. C.

[Spis treści](/dydaktyka/lisp) | [Lekcja 13](/dydaktyka/lisp/lekcja-13) | [Lekcja 15](/dydaktyka/lisp/lekcja-15)
