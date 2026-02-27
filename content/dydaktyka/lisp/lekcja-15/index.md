---
title: Lekcja 15
date: '2010-11-29T12:58:00Z'
lastmod: '2010-11-29T12:59:22Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 14](/dydaktyka/lisp/lekcja-14) | [Lekcja 16](/dydaktyka/lisp/lekcja-16)

15. Wykonywanie następujących po sobie instrukcji
-------------------------------------------------

Do wykonywania następujących po sobie instrukcji przydatne są formy postaci prog?. Różnią się
one jedynie wartością, która jest przez nie zwracana, natomiast ich wykonanie jest identyczne, tzn.
forma postaci (prog? form1 from2 form3 ... formn) wykonuje po kolei wszystkie formy począwszy
od form1 a skończywszy na formn. Oczywiste jest, że skoro zwaracana jest tylko jedna wartość, to
formy 1..n są wykonywane dla ich efektów ubocznych, a nie dla wartości, które zwracają. Dlatego
instrukajca przypomina wykonanie programów w językach imperatywnych typu C czy Pascal, gdzie
większość operacji jest wykonywanych dla ich efektów ubocznych.

### 15.1 prog1

prog1 wykonuje po kolei wyszstkie formy 1..n, przy czym zwraca wynik 1 wykonanej formy. Jest
ona przydatna w przypadkach, w których zależy nam na początkowej wartości pewnej zmiennej, na
której później wykonujemy inne operacje.
h4. 15.1

code(lisp).
(prog1
(setf a 'zenek)
(setf a 'franek)
(setf a 'alfons)
(format t "~&A jest ~S" a)
)
a jest alfons
=&gt; zenek

### 15.2 prog2

Instrukcja ta zwraca wartość drugiej w kolejności wykonywanej formy. Może mieć ona zastosowanie
w operacjach, w których najpierw dokonujemy jakiś czynności wstępnych - np. otwarcia pliku.
Nasępnie dokonujemy pewnych operacji na pewnym obiekci - np. otwartym pliku, na koniec
zaś dokonujemy czynności porządkowych, czyli w naszym przykładzie zamykamy otwarty plik. Przy
czy interesuje nas tylko wartość uzyskana w drugim etapie. W obecnych czasach forma ta jest
wykorzystywana dosyć rzadko, ze względu na istnienie z jednej strony opercji typu with-open-file,
z drugiej zaś w LISP została zaimplementowana obiektowość.

### 15.3 progn

Instrukcja ta jak można się domyślać wykonuje po kolei formy od 1 do n, zwraca zaś wynik wykonania
ostatniej formy. Typowym zastosowanie tej instrukcji jest przeprowadzenie pewnych złożonych
operacji na jednym obiekcie, przy czym interesuje nas tylko końcowy ich efekt. Wiele instrukcji
LISP zawiera niejawną sekcję progn w sobie. Dla przykałdu - instrukcje let, czy też do.

#### 15.2

code(lisp).
(progn
(setq a 10)
(setq b (+ a 10))
(setq c (\* a 10))
(format nil "~&Wartosc a ~D, a+10 ~D, a\*10 ~d" a b c)
) =&gt; "Wartosc a 10, a+10 20, a\*10 100"

[Spis treści](/dydaktyka/lisp) | [Lekcja 14](/dydaktyka/lisp/lekcja-14) | [Lekcja 16](/dydaktyka/lisp/lekcja-16)
