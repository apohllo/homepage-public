---
title: Wyrażenia regularne
date: '2008-04-13T15:52:00Z'
lastmod: '2008-10-14T07:47:23Z'
draft: false
tags:
- dydaktyka
- regex
author: 193.138.143.42
---

egrep
-----

Jednym z podstawowych narzędzi bazujących na wyrażeniach regularnych jest program
`egrep`, który dla zadanego pliku wyświetla te linie, które pasują do zadanego wyrażenia.

Jego składnia jest następująca:

code.
$ egrep wyrazenie\_regularne plik

Jeśli dodamy opcję `--color=auto`, to wynik działania programu zostanie pokolorowany i można będzie zobaczyć dokładnie, który fragment linii został dopasowany.

Metaznaki
---------

Podstawowe metaznaki:

-   \* - (kwantyfikator) zero lub więcej wystąpień
-   () - grupowanie wyrażeń dla kwantyfikatorów, alternatywy, dopasowań wstecznych
-   | - alternatywa - jedna opcja spośród wielu

Kwantyfikatory (określają ile razy ma być dopasowane wyrażenie, które stoi przed nimi):

-   \* - zero lub więcej wystąpień (to samo co wyżej)
-   + - jedno lub więcej wystąpień
-   ? - zero lub jedno wystąpienie

Kotwice (dopasowują się do pozycji w łańcuchu, a nie konkretnych znaków):

-   ^ - początek łańcucha
-   $ - koniec łańcucha
-   \\b - granica słowa
-   \\&lt; - początek słowa
-   \\&gt; - koniec słowa

Klasy znaków:

-   \[\] - jeden ze znaków znajdujących się wewnątrz nawiasów
-   ^ - pojawiając się na początku w kontekście klasy znaków powoduje jej zanegowanie
-   a-z - zakres znaków (tylko wew. nawiasów kwadratowych)
-   \\w - znak będący literą, cyfrą lub podkreśleniem
-   \\s - znak będący białą spacją (spacja, tabulator, koniec linii, etc.)
-   \\d - cyfra
-   . - dowolny znak (zazwyczaj - niebędący końcem linii)
