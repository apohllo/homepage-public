---
title: Lekcja 18
date: '2010-11-30T07:56:00Z'
lastmod: '2010-11-30T07:57:14Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 17](/dydaktyka/lisp/lekcja-17) | [Lekcja 19](/dydaktyka/lisp/lekcja-19)

18. Równość obiektów
--------------------

W LISP zmienne można porównywać na kilka sposbów. Każdy kolejny przedstawiony predykat równości
obiektów będzie prawdziwy, jeśli poprzednie predykaty też były prawdziwe dla zadanych zmiennych.
Osobno omówiony jest predykat =, służący do porównywania liczb.

### 18.1 eq

Predykat ten służy do porównywania symboli i obiektów przez adres. Ponieważ każdy symbol może mieć
tylko jedną reprezentację w pamięci, to dla identycznie wyglądających symboli predykat ten jest
zawsze prawdziwy. Podobnie jeżeli dwie zmienne wskazują ten sam obiekt w pamięci(np. gdzięki
zastosowaniu instrukcji setq), to predykat ten będzie prawdziwy dla takich obiektów.
W przypadku liczba sprawa wygląda inaczej. Liczby nie muszą mieć pojedynczej reprezentacji
w różnych implementacjach LISP i z tego względu predykata eq będzie zawodny w przypadku liczb.
Również dwie identycznie wyglądające listy, posiadające jednak inny adres w pamięci będę różne
dla predykatu eq.

#### 18.1

```lisp
(eq 'a 'a) =&gt; t
(eq 'a 'b) =&gt; nil
(eq 1 1) =&gt; nil
(eq 1 1.0) =&gt; nil
(setq a '(1 2 3)) =&gt; (1 2 3)
(setq b a) =&gt; (1 2 3)
(eq a b) =&gt; t
(setq b '(1 2 3)) =&gt; (1 2 3)
(eq a b) =&gt; nil
```

### 18.2 eql

Predykat ten jest stosowany do badania liczb należących do jednego typu, np. całkowitego. Warto
zwrócić na niego uwagę, ponieważ jest standardowo stosowany w takich instrukcjach jak np. member.
Poza tą własnością nie różni się niczym od predykatu eq.

#### 18.2

```lisp
(eql 'a 'a) =&gt; t
(eql 'a 'b) =&gt; nil
(eql 1 1) =&gt; t
(eql 1 1.0) =&gt; nil
(setq a '(1 2 3)) =&gt; (1 2 3)
(setq b a) =&gt; (1 2 3)
(eql a b) =&gt; t
(setq b '(1 2 3)) =&gt; (1 2 3)
(eql a b) =&gt; nil
```

### 18.3 equal

Predykat ten jest dobry do badania identycznie wyglądających obiektów, gdyż w przypadku,gdy
dwa obietky wyglądają identycznie, to wynik tego predykatu będzie prawdziwy. Mówiąc ściślej, jeśli
mamy dwie listy zawierające identyczne symbole, lecz posiadające inny adres w pamięci komputera,
to wynikiem zastosowania dla nich tego predykatu będzie prawda. Predykat ten jest oczywiście
wolniejszy od eq, dlatego do porównywania symboli znacznie lepisj jest używać tego drugiego.

#### 18.3

```lisp
(setq a '(1 2 3)) =&gt; (1 2 3)
(setq b a) =&gt; (1 2 3)
(equal a b) =&gt; t
(setq b '(1 2 3)) =&gt; (1 2 3)
(equal a b) =&gt; t
```

### 18.4 equalp

Predykat ten jest jeszcze mniej restrykcyjny niż equal, poniewać dopuszcza by porównywane łańcuchy
miały różne wielkości liter, natomiast gdy łańcuchy mają identyczny wygląd (bez względu na wielkość
liter), to predykat ten zwraca wartość prawda.

#### 18.4

```lisp
(equal "Ala ma kota" "Ala Ma Kota") =&gt; nil
(equal "Ala ma kota" "Ala Ma Kota") =&gt; t
```

### 18.5 =

Predykat ten służy do porównyania liczb, bez względu na to do jakiego typu należą. Można więc
porównywać liczby całkowite z wymiernymi czy też rzeczywistymi. Jeśli ich wartość jest taka sama
to predykat ten zwraca wartość t. Nie można go jednak stosować do porónywania żadnych innych obiektów,
w szczególności symboli.

#### 18.5

```lisp
(= 1 2) =&gt; nil
(= 1 1.0) =&gt; t
(= 1/2 0.5) =&gt; t
(= 'a 'a) =&gt; nil
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 17](/dydaktyka/lisp/lekcja-17) | [Lekcja 19](/dydaktyka/lisp/lekcja-19)
