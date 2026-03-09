---
title: Język C - ćwiczenia
date: '2012-10-18T14:30:00Z'
lastmod: '2013-11-18T15:25:34Z'
draft: false
tags:
- wdi
- c
author: 5.173.228.37
---

Kompilacja programu
-------------------

1. Utwórz katalog zadania:

code(bash).
$ mkdir zadania

2. Zmień katalog na zadania:

code(bash).
$ cd zadania

3. Utwórz katalog, którego nazwa jest taka jak Twoje nazwisko, np. pohl:

code(bash).
$ mkdir pohl

4. Przejdź do utworzonego katalogu

code(bash).
$ cd pohl

5. Pobierz plik [witaj\_epi.c](/texts/witaj_epi.c) do katalogu `zadania/<twoje_nazwisko>`:

code(bash).
$ wget http://apohllo.pl/texts/witaj\_epi.c

6. Sprawdź czy plik znajduje się w katalogu:

code(bash).
$ ls
witaj\_epi.c

7. Skompiluj program:

code(bash).
$ gcc -o witaj\_epi witaj\_epi.c

8. Uruchom program:

code(bash).
$ ./witaj\_epi

Modyfikacja programu
--------------------

1. Pobierz plik [pozdrowienie.c](/texts/pozdrowienie.c)

2. Skompiluj plik `pozdrowienie.c` do programu o nazwie `pozdrowienie`

3. Uruchom program `pozdrowienie`.

4. Otwórz plik `pozdrowienie.c` w edytorze.

5. Zmodyfikuj plik tak, żeby zamiast "Witaj" na wyjściu pojawiło się "Żegnaj".

6. Skompiluj program.

7. Uruchom zmodyfikowaną wersję programu.

Rozbudowa programu
------------------

1. Pobierz plik [naglowek.c](/texts/naglowek.c)

2. Skompiluj go do programu o nazwie `naglowek`

3. Uruchom program.

4. Otwórz plik w edytorze.

5. Zmodyfikuj program tak by uwzględnić formalny charakter listu.

6. Skompiluj program.

7. Uruchom zmodyfikowany program.

Równanie kwadratowe
-------------------

1. Pobierz plik [rownanie\_kwadratowe.c](/texts/rownanie_kwadratowe.c)

2. Uzupełnij program, tak aby pytał użytkownika o współczynniki równania kwadratowego oraz obliczał i przedstawiał rozwiązanie użytkownikowi.

3. Skompiluj program za pomocą polecenia (zwróć uwagę na opcję "-lm" na końcu polecenia):

code(bash).
$ gcc -o rownanie\_kwadratowe rownanie\_kwadratowe.c -lm

4. Sprawdź działanie dla następujących przykładów:

-   a = 1, b = 3, c = 1, rozwiązania x1 = -0.382, x2 = -2.618
-   a = 1, b = 2, c = 1, rozwiązanie x1 = -1
-   a = 2, b = 2, c = 1, brak rozwiązań

Program obliczający sumę cyfr
-----------------------------

1. Pobierz plik [suma\_cyfr.c](/texts/suma_cyfr.c)

2. Uzupełnij program we wskazanych miejscach.

3. Skompiluj program.

4. Sprawdź działanie.

Program do odgadywania liczby w przedziale od do 100.
-----------------------------------------------------

1. Pobierz plik [zgadnij\_liczbe.c](/texts/zgadnij_liczbe.c)

2. W pliku są tylko wskazówki - cały program musi być napisany samodzielnie.

3. Skompiluj program.

4. Sprawdź działanie programu.

Pesel - płeć
------------

1. Pobierz plik [pesel.c](/texts/pesel.c)

2. Uzupełnij program, tak by na podstawie numeru pesel określał płeć osoby.

3. Skompiluj i uruchom program.

Pesel - data urodzenia
----------------------

1. Pobierz plik [pesel.c](/texts/pesel.c)

2. Uzupełnij program, tak by na podstawie numeru pesel określana była data urodzenia osoby.

3. Skopiluj i uruchom program.
