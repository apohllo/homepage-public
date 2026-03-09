---
title: Lekcja 25
date: '2010-11-30T09:51:00Z'
lastmod: '2010-11-30T09:51:57Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 24](/dydaktyka/lisp/lekcja-24)

25. Wejście/wyjście
-------------------

W LISP istnieje szereg struktur i instrukcji służących do obsługi szeroko rozmuianego wejścia/wyjścia.

### 25.1 Napisy

Podstawową strukturą, która przechowuje zbiory liter jest napis. W LISP zapisujemy go przy pomocy
tekstu ograniczonego podójnym cudzysłowem, np. "To jest napis". Jest on reprezentowany jako
jednowymiarowa tablica znaków o zmiennej długości. Z tego względu wszelki instrukcje nadające się
dla tablic, będą działały również dla napisów. Isnieją również dedykowane istrukcje służące do
manipulacji napisami. Jeśli chcemy aby napis zawierał znak podówjnego cudzysłowu lub lewego ukośnika,
to musimy go poprzedzić lewym ukośnikiem np. "Cytat: \\"Kości zostały rzucone \\" - koniec cytatu".

#### 25.1.1 char

Instrukcja char pozwala na dostęp do n-tego elementu napisu. Odpowiada ona instrukcji aref, przy
czym może przyjmować tylko dwa argumenty - napis oraz pozycję w napisie. Litery są indeksowane od
zera. Chcą zastąpić wybrany znak innym możemy napisać

#### 25.1

```lisp
(setq napis "Ala ma kota") =&gt; "Ala ma kota"
( char napis 2) =&gt; \#\\a
( setf (char napis 2) \#\\b) =&gt; \#\\a
napis =&gt; "Alb ma kota"
```

Warto zwrócić uwagę, że znaki drukują się inaczej niż napisy. Jeśli chcemy uzyskać znaki w postaci
napisów, mosimy dokonać konwersji coerce ze znaku na napis.

#### 25.1.2 format

Ważną instrukcją związana z napisami jest format. Pozwala ona wydrukwać na dowolne wyjście
napisy, których elementy mogą zostać zadane jako argumenty jej wywołani. W ogólności
ma ona postać (format destination string arg1 arg2 ...). Destination przyjmuje najczęściej wartości
nil oraz t, ale może to być dowolny strumień. Argument ten określa gdzie wynikowy łańcuch ma zostać
złożony. nil oznacza, że wynikowy łańcuch ma zostać zwrócony przez instrukcję format, podczas gdy
t oznacza, że wynikowy łańcuch ma zostać wydrukowany na standardowym wyjściu, a instrukcja zwraca nil.

#### 25.2

```lisp
(setq napis (fomrat nil "Ala ma kota"))
=&gt; "Ala ma kota"
napis =&gt; "Ala ma kota"
(setq napis (format t "Ala ma kota"))
"Ala ma kota"
=&gt; nil
napis =&gt; nil
```

Jak wcześniej zauważyliśmy, w napisie mogą pojawić się elementy zadane jako argumenty insrukcji
format. W napisie jednak muszą wystąpić odpowiednie znaki, które informują tą funkcję, gdzie
mają się pojawić owe argumenty i jak mają zostać wydrukowane. Najczęściej stosowane zestawienia
znaków, to ~D oraz ~S. Piewrszy z nich pozwala wstawić liczbę do napisu, drugi zaś inny napis
bądź symbol.

#### 25.3

```lisp
(setq a 10) =&gt; 10
(format t "Zmienna ~S ma wartość ~D" \`a a)
Zmienna a ma wartość 10
=&gt; nil
```

Innymi równie często pojawiającymi się kombinacjami znaków są <sub>&\\ oraz</sub>%. Pierwsza z nich powoduje
przejście do nowej lini, jeśli bieżąca linia nie jest pusta, podczas gdy druga, powoduje bezwarunkowe
przejści do nowej linii.
h4. 25.4

```lisp
(format t "Napis <sub>&\\ w\\ kilku</sub>& linijkach")
Napis
w kilku
linijkach
=&gt; nil
```

### 25.2 Odczytywanie informacji z wejścia

Do wprowadzania informacji przez użytkownika złuży instrukcja read. Zwraca ona po prostu
wartość odczytaną ze standardowego wejścia. Wartość ta nie musi być cytowan przy pomocy znaku\`,
ponieważ nie będzie ewaluowana.

#### 25.5

```lisp
(defun kwadrat ()
(format t "Podaj liczbe ktorej kwadrat chcesz obliczyc: ")
(let ((x (read)))
(format t "~&Kwadratem liczby ~D jest <sub>D</sub>%" x (\* x x))
)
) =&gt; kwadrat
(kwadrat)
Podaj liczbę której kwadrat chcesz obliczyć:
10
Kwadratem liczby 10 jest 100
=&gt; nil
```

### 25.3 Operacje na plikach

Operacje na plikach najłatwiej przeprowadza się przy pomocy instrukcji with-open-file.
Ma ona postać (with-open-file (var pathname) body), gdzie var to nazwa zmiennej, z którą będzie
utożsamiany strumień do otwartego pliku, pathname to ścieżka dostępu do tego pliku, zaś
body zawiera instukcje dokonujące operacji na otwartym pliku. Zaraz po opuszczeniu tej instrukcji,
połączenie do pliku jest zamykane.

#### 25.3.1 Odczyt z pliku

Przypuśćmy, że wpliku "dane.dat" w katalogu bieżącym znajdują sią następujące wpisy

#### 25.6

```lisp
1
(maluch polonez syrenka)
```

Dostęp do tych danych jest następujący

#### 25.7

```lisp
(with-open-file (plik "dane.dat")
(let ((numer-samochodu (read plik))
(lista-samochodow (read plik)))
(format t "Najlepszym samochodem jest <sub>S</sub>%"
(nth numer-samochodu lista-samochodow))
)
)
Najlepszym samochodem jest polonez
=&gt; nil
```

#### 25.3.2 Zapis do pliku

Jeśli chcemy zapisać jakieś informacje do pliku, to w instrukcji with-open-file dodatkowo musimy
zastosować dwa słowa kluczowe :direction i :output, całą zaś forma przyjmuje postać
(with-open-file (var pathname :direction :output) body). Do zapisu możemy wykorzystać
wcześniej poznana instrukcję format, przy czym jej pierwszy argument powinien być nazwą otwartego
pliku.

#### 25.8

```lisp
(let ((lista-samochodow '(maluch polonez syrenka))
(numer-samochodu 2))
(with-open-file (plik "dane.dat" :direction :output)
(format plik "<sub>S</sub>%" numer-samochodu)
(format plik "<sub>S</sub>%" lista-samochodow)
)
) =&gt; nil
```

Po wykonani tej formy w pliku "dane.dat" pojawią się następujące linie:

#### 25.9

```lisp
2
(maluch polonez syrenka)
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 24](/dydaktyka/lisp/lekcja-24)
