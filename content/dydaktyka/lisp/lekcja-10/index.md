---
title: Lekcja 10
date: '2010-11-29T12:22:37Z'
lastmod: '2010-11-29T12:22:37Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 9](/dydaktyka/lisp/lekcja-9) | [Lekcja 11](/dydaktyka/lisp/lekcja-11)

10. Funkcje logiczne
--------------------

### NOT

NOT jest " przeciwieństwem" predykatów: zamienia tak z nie i nie z tak. W terminologii Lispa podanie na wejście NOT wartości T zwraca NIL, zaś podanie wartości NIL zwraca T. Ciekawą rzeczą jest fakt, iż możemy przywiązać NOT do jakiegoś innego predykatu, by wyprowadzić jego przeciwność; na przykład , możemy zrobić predykat „nierówny” poprzez połączenie NOT i EQUAL, albo predykat „niezerowy” - NOT i ZEROP.
h4. 10.1.

```lisp
(not t) =&gt; NIL
(not nil) =&gt; T
```

### Błędy

Chociaż nasz system funkcji jest bardzo prosty, już teraz możemy zrobić w nim kilka typów błędów. Możemy na przykład podać na wejście funkcji niewłaściwy typ danych. Na przykład, funkcja + może dodawać tylko liczby i nie przyjmuje symboli.
h4. 10.2.

```lisp
(+ ania 3) =&gt; Error! Wrong type input.
```

Inny rodzaj błędu to podanie na wejście funkcji zbyt mało albo zbyt wiele argumentów.

#### 10.3.

```lisp
(equal 2) =&gt; Error! Too few inputs.
(oddp 4 7) =&gt; Error! Too many inputs.
```

W końcu, błąd może zdarzyć się,gdy funkcja nie może zrobić tego, o co jest poproszona. To się może zdarzyć np. kiedy próbujemy podzielić liczbę przez zero.

### AND, OR

Często potrzeba budować złożone predykaty z tych prostszych. Dzięki makrom AND i OR jest to możliwe. Popatrzmy na przykład. Pokazuje on jak zbudować funkcje sprawdzającą nieparzystość liczb z przedziału od 0 do 100 przy pomocy AND.

#### 10.4.

```lisp
(defun small-positive-oddp (x)
(and (&lt; x 100)
(&gt; x 0)
(oddp x)
)
)
```

AND i OR w Lispie nieznacznie różniąc się od podobnych funkcji logicznych.

Regułą dla AND jest: oceń po jednej klauzuli, jeśli zwrócą NIL, zatrzymaj i zwróć NIL; inaczej przejdź do następnej - jeśli wszystkie klauzule zwracają wartość różną od NIL, zwraca wartość ostatniej klauzuli.

#### 10.5.

```lisp
(and 1 2 3 4 5) =&gt; 5
(and nil t t) =&gt; NIL
(and 'ania NIL 'pawel) =&gt; NIL
(and 'ilona 'asia 'krzysiek) =&gt; krzysiek
```

Regułą dla oceniania OR jest: oceń po jednej klauzuli, jeśli zwrócą coś innego niż NIL, zatrzymaj i zwróć tę wartość, inaczej pójdź dalej do następnej klauzuli - zwróć NIL jeśli żadna klauzula już nie została.

#### 10.6.

```lisp
(or nil t t) =&gt; T
(or 'ilona 'asia 'krzysiek) =&gt; ilona
(or nil 'wojtek 'ania) =&gt; wojtek
```

AND i OR posiadają wartościową własność kończenia działania funkcji po otrzymaniu odpowiedniej wartości nawet w połowie wykonywania się funkcji. Pozwala to na wyłapanie błędów, które inaczej zdarzyłyby się. Na przykład w przypadku predykatu POSNUMP.
h4. 10.7.

```lisp
(defun posnump (x)
(and (numberp x) (plusp x))
)
```

POSNUMP zwraca T, jeśli jego wejście jest liczbą i jest pozytywne. Wbudowany predykat PLUSP może zostać użyty, by powiedzieć, czy liczba jest pozytywna, ale, jeśli PLUSP jest użyty na czymś innym niż liczba, to zasygnalizuje błąd. Dlatego ważne jest, by upewnić się, że wejście do POSNUMP jest liczbą przed odwoływaniem PLUSP. Jeśli wejście nie jest liczbą, nie wolno wywołać PLUSP.

[Spis treści](/dydaktyka/lisp) | [Lekcja 9](/dydaktyka/lisp/lekcja-9) | [Lekcja 11](/dydaktyka/lisp/lekcja-11)
