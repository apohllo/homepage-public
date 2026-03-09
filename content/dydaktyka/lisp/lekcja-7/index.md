---
title: Lekcja 7
date: '2010-11-27T11:15:00Z'
lastmod: '2010-11-27T12:42:16Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 6](/dydaktyka/lisp/lekcja-6) | [Lekcja 8](/dydaktyka/lisp/lekcja-8)

7. Lista – przydatne funkcje II
-------------------------------

### FIRST, SECOND, oraz THIRD

Lisp dostarcza również pierwotnych funkcji dla wyciągania elementów z listy. Funkcje FIRST, SECOND, oraz THIRD zwracają kolejno pierwszy, drugi i trzeci element z listy podanej na ich wejście.

#### 7.1.

code(lisp).
(FIRST (A B C D)) =&gt; A
(SECOND (A B C D)) =&gt; B
(THIRD (A B C D)) =&gt; C

#### 7.2. Błędem jest podanie na wejście tych funkcji struktur innych niż listy.

code(lisp).
(PIERWSZY KAZOO) =&gt; Error! Not a list.

### REST

Funkcja REST uzupełnia funkcje FIRST - zwraca listę zawierającego wszystko oprócz pierwszego elementu.

#### 7.3.

code(lisp).
(REST (A B C D)) =&gt; (B C D)

### CAR i CDR

Wiemy już, że każda z komórek dzieli się na 2 części. Teraz okaże się, że obie mają swoje „imiona”. Lewa połowa jest nazywana CAR, zaś prawa - CDR. Nazwy te są historyczne, ale używane są nadal ze względu na fakt, iż wygodnie można komponować je, by tworzyły dłuższe nazwy takie jak CADR i CDDAR, których znaczenie poznamy wkrótce.

CAR i CDR to również wbudowane funkcje Lispa wskazujące na wartość wskazywane przez odpowiednie wskazówki. Rozważmy listę (MALY CZARNY KOT). Po wywołaniu funkcji CAR na tej liście otrzymamy element, na który wskazuje pierwsza komórka. Co CDR zwraca kiedy dane tego samego listę jako wejście? Idąc za druga wskazówką dojdziemy do pozostałej części listy (CZARNY KOT)

#### 7.4.

code(lisp).
(CAR (MALY CZARNY KOT)) =&gt; MALY
(CDR (MALY CZARNY KOT)) =&gt; (CZARNY KOT)

Łatwo zauważyć, że CAR działa podobnie jak FIRST, zaś CDR – podobnie jak REST. Albo inaczej: FIRST zwraca CAR listy, zaś REST zwraca CDR.

Pamiętaj - lista (AARDVARK) nie jest tę samą rzeczą co symbol AARDVARK. Lista (AARDVARK) wygląda tak:

Skoro lista długości jeden jest reprezentowana wewnątrz komputera jako pojedyncza komórka, wywołanie funkcji CDR na liście o długości jeden na wyjściu listą długości zero, czyli NIL.

#### 7.5.

code(lisp).
(CAR (AARDVARK) ) =&gt; AARDVARK

Rozważmy teraz listę (FEE FE FUM FOE), której pierwszym elementem jest FEE. Drugi element tej listy jest FIRST z REST, albo, w naszej nowej terminologii, CAR CDR.

#### 7.6.

code(lisp).
(CAR (CDR (FEE FE FUM FOE))) =&gt; FE

W Lispie funkcja CADR jest skrótem dla „CAR CDR”.

#### 7.7.

code(lisp).
CADR (FEE FE FUM FOE) =&gt; FE

### LIST

Tworzenie listy z grupy elementów jest taką typową operacją dla Lispa, że posiada on funkcję wewnętrzną stworzoną specjalnie do tego. Funkcja LIST bierze dowolną ilość wejść i tworzy z nich listę. Tzn. robi nowy łańcuch komórek kończący się NILem, który posiada tyle komórek co elementów na wejściu.

#### 7.8.

code(lisp).
(LIST FOO BAR BAZ) =&gt; (FOO BAR BAZ)

Zauważ, że funkcja CONS zawsze tworzy pojedynczą komórkę. Funkcja LIST, z drugiej strony, robi całkowicie nowy łańcuch komórek. W notacji z nawiasami ukazane jest topoprzez dodanie jeszcze jednej pary nawiasów dookoła jego wejścia. Skutek działania funkcji LIST ma więc zawsze o jeden więcej poziom nawiasów niż miało je wyrażenie na wejście.

#### 7.9.

code(lisp).
(LIST FOO) =&gt; (FOO)
(LIST (FOO)) =&gt; ((FOO))

### REVERSE, LAST i REMOVE

Lisp dostarcza wiele prostych funkcji dla operowania na listach, m.in.: REVERSE, LAST i REMOVE.

REVERSE zwraca odwróconą listę.

#### 7.10.

code(lisp).
(reverse '(jeden dwa trzy cztery piec))
=&gt; (PIEC CZTERY TRZY DWA JEDEN)
(reverse '(l i v e)) =&gt; (E V I L)
(reverse 'live)
=&gt; Error: Wrong type input.
(reverse '((zielony pomidor)(czerwona truskawka)(zolta cytryna)))
=&gt; ((ZOLTA CYTRYNA) (CZERWONA TRUSKAWKA) (ZIELONY POMIDOR))

Zauważ, że ta REVERSE odwraca tylko najwyższy poziom listy, zaś nie odwraca indywidualnych elementów listy list. Kolejna cecha REVERSE to fakt, że to nie pracuje nad symbolami oraz nie modyfikuje listy otrzymanej na wejściu.

#### 7.11.

code(lisp).
(setf vow '(byly sobie kurki trzy)) =&gt; (BYLY SOBIE KURKI TRZY)
(reverse vow) =&gt; (TRZY KURKI SOBIE BYLY)
vow =&gt; (BYLY SOBIE KURKI TRZY)

Możemy użyć REVERSE aby dodać element do końca listy.

#### 7.12.

code(lisp).
(defun add-to-end (x y)
(reverse (cons y (reverse x)))
)

(add-to-end '(a b c) 'd) =&gt; (a b c d)

LAST zwraca ostatnią komórkę listy, inaczej mówiąc komórkę, w której car wskazuje na ostatni element listy. Jeśli lista jest pusty, LAST zwraca NIL.

#### 7.13.

code(lisp).
(last '(ide do domu)) =&gt; (domu)
(last nil) =&gt; nil
(last '(a b c . d)) =&gt; (c . d)
(last 'domek) =&gt; Error! DOMEK is not a list.

REMOVE usuwa rzecz z listy. Skutek REMOVE jest nową listą, bez usuniętych elementów.

#### 7.14.

code(lisp).
(remove 'a '(m a m o n a)) =&gt; (m m o n)
(remove 1 '(3 1 4 1 5 9)) =&gt; (3 4 5 9)

REMOVE jest funkcją niedestruktywną.

#### 7.15.

code(lisp).
(setf spell '(a b r a k a d a b r a)) =&gt; (A B R A K A D A B R A)
(remove 'a spell) =&gt; (B R K D B R)
spell =&gt; (A B R A K A D A B R A)

### Przydatne funkcje listowe

Oto przydatne funkcje, działające na listach.

#### 7.16. łącz (konkatenuj) listy

code(lisp).
(append '(1 2 3) '(4 5 6)) =&gt; (1 2 3 4 5 6)

#### 7.17. odwróć elementy listy

code(lisp).
(reverse '(1 2 3)) =&gt; (3 2 1)

#### 7.18. ustaw członkostwo - zwraca pierwszy ogon w którym car jest żądanym elementem

code(lisp).
(member 'a '(b d a c)) =&gt; (A C)

#### 7.19. inny sposób ustawiania członkostwa, find jest jednak bardziej elastyczny

code(lisp).
(find 'a '(b d a c)) =&gt; A
(find '(a b) '((a d) (a d e) (a b d e) ()) : test \#'subsetp)
=&gt; (A B D E)
h4. 7.20. zawieranie

code(lisp).
(subsetp '(a b) '(a d e)) =&gt; NIL

#### 7.21. przekrój zbiorów

code(lisp).
(intersection '(a b c) '(b)) =&gt; (B)

#### 7.22. suma zbiorów

code(lisp).
(union '(a) '(b)) =&gt; (A B)

#### 7.23. różnica zbiorów

code(lisp).
(set-difference '(a b) '(a)) =&gt; (B)

[Spis treści](/dydaktyka/lisp) | [Lekcja 6](/dydaktyka/lisp/lekcja-6) | [Lekcja 8](/dydaktyka/lisp/lekcja-8)
