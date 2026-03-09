---
title: Lekcja 11
date: '2010-11-29T12:29:59Z'
lastmod: '2010-11-29T12:29:59Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 10](/dydaktyka/lisp/lekcja-10) | [Lekcja 12](/dydaktyka/lisp/lekcja-12)

2. 11. Instrukcje warunkowe – IF, WHEN, UNLESS, CASE, COND

### IF

LISP wyposażony jest również w specjalne formy dla wyrażeń warunkowych. IF jest najprostszą z nich. Specjalna funkcja IF bierze trzy argumenty: próba, prawdziwa część i fałszywa część. Jeśli próba jest prawdziwa, IF zwraca wartość prawdziwej części. Jeśli próba jest fałszywa, to opuszcza prawdziwą część i zamiast zwraca wartość fałszywej części.

#### 11.1.

code(lisp).
(if t 2 8) =&gt; 2
(if nil 2 8) =&gt; 8
(if 9 2 8) =&gt; 2
(if (oddp 7) 'odd 'even) =&gt; odd
(if (oddp 6) 'odd 'even) =&gt; even
(if t 'tekst-jest-prawdziwy 'tekst-jest-falszywy)
=&gt; tekst-jest-prawdziwy
(if nil 'tekst-jest-prawdziwy 'tekst-jest-falszywy)
=&gt; tekst-jest-falszywy
(if (symbolp 'slowo) (\* 3 4) (+ 3 4))
=&gt; 12
(if (symbolp 6) (\* 3 4) (+ 3 4)) =&gt; 7

W przypadku gdy potrzeba wykonać więcej niż jedną instrukcję w klauzuli then lub else IF’a, to można użyć specjalenej formy PROGN. PROGN wykonuje każdą instrukcję swojego ciała i zwraca ostatnią wartość.

### WHEN i UNLESS

WHEN i UNLESS w przeciwieństwie do IF, zezwalają na dowolną liczbę instrukcji w swoich ciałach. (Np. (when x a b c) jest równoważne (if x (progn a b c)).

Instrukcja IF, której brak klauzuli then lub else, może być zapisana przy użyciu specjalnej formy UNLESS.

#### 11.2.

code(lisp).
(when t 5) =&gt; 5
(when nil 5) =&gt; NIL
(unless t 5) =&gt; NIL
(unless nil 5) =&gt; 5

### CASE

Instrukcja CASE w LISP jest podobna do instrukcji switch w C:

#### 11.3.

code(lisp).
(setq x 'b) =&gt; B
(case x
(a 5)
((d e) 7)
((b f) 3)
(otherwise 9)
) =&gt; 3

Klauzula otherwise oznacza, że jeśli x nie jest a, b, d, e lub f, instrukcja CASE ma zwrócić 9.

Bardziej złożone warunki można definiując przy użyciu formy specjalnej COND która jest równoważna konstrukcji: if ... else if ...

### COND

COND składa się z symbolu ‘COND’, za którym następują klauzule COND, z których każda jest listą. Pierwszy element klauzuli cond jest warunkiem; pozostałe elementy (jeśli istnieją) są akcją. Forma COND szuka pierwszej klauzuli, której warunek jest spełniony; potem wykonuje odpowiednią akcję i zwraca wartość wynikową. Żaden pozostały warunek nie jest już analizowany; nie są też wykonywane inne akcje niż ta, odpowiadająca warunkowi.

Ogólna forma wyrażenia COND wygląda tak:

code(lisp).
(cond (test-1 consequent-1)
(test-2 consequent-2)
(test-3 consequent-3)
....
(test-n consequent-n))

#### 11.4.

code(lisp).
(setq a 3) =&gt; 3
(cond
((evenp a) a) ;jeśli a jest parzyste, zwróć a
((&gt; a 7) (/ a 2)) ;inaczej, jeśli a jest &gt; niż 7, zwróć a/2
((&lt; a 5) (- a 1)) ;inaczej, jeśli a jest &lt; niż 5, zwróć a-1
(t 17) ;inaczej zwróć 17
) =&gt; 2

Jeśli w danej klauzuli COND brakuje akcji, COND zwraca wartość, do której został zredukowany warunek:

#### 11.5.

code(lisp).
(cond ((+ 3 4))) =&gt; 7

Instrukcje warunkowe to specjalne funkcje decydowania, które wybierają rezultat spośród zbioru wartości bazujących na wyniku jednego lub kilku predykatów. Tryby warunkowe pozwalają funkcji na zmianę zachowania w zależności od rodzaju wejścia. Odkąd możemy pisać funkcje, które robią dowolnie złożone decyzje.

Użyjmy COND do napisania funkcji COMPARE porównującej dwie liczby. Jeśli liczby są równe, COMPARE „powie” ‘liczby-sa-rowne’; jeśli pierwsza liczba będzie mniejsza niż druga, to „powie” ‘pierwsza-liczba-jest-mniejsza’; jeśli pierwszy numer będzie większe niż drugi, to „powie” ‘pierwsza-liczba-jest-wieksza’. Każdy przypadek jest obsłużony przez oddzielną klauzulę COND.

#### 11.6.

code(lisp).
(defun compare (x y)
(cond ((equal x y) 'liczby-sa-rowne)
((&lt; x y) 'pierwsza-liczba-jest-mniejsza)
((&gt; x y) 'pierwsza-liczba-jest-wieksza)
)
)

Jedna ze standardowych sztuczek używania COND to umieszczenie na końcu COND klauzuli

code(lisp).
(T consequent)

Ponieważ T jest zawsze prawdziwe, więc jeśli COND kiedykolwiek dotrze do tej klauzuli, to wykona consequent. Z drugiej strony klauzula ta zostanie osięgnięta tylko wtedy, jeśli zawiodą wszystkie poprzedzające ją klauzule.

#### 11.7.

code(lisp).
(defun gdzie-jest (x)
(cond ((equal x 'paryz) 'francja)
((equal x 'londyn) 'anglia)
((equal x 'pekin) 'chiny)
(t 'nieznane)
)
)

Warto zauważyć, że ostatnia klauzula COND zaczyna się z T. Oznacza to, że jeśli żadna z poprzedzających klauzuli nie zostanie wykonana, wykona się ostatnia klauzula i funkcja zwróci NIEZNANE.

#### 11.8.

code(lisp).
(gdzie-jest 'londyn ) =&gt; anglia
(gdzie-jest 'pekin ) =&gt; chiny
(gdzie-jest 'parasol) =&gt; nieznane

[Spis treści](/dydaktyka/lisp) | [Lekcja 10](/dydaktyka/lisp/lekcja-10) | [Lekcja 12](/dydaktyka/lisp/lekcja-12)
