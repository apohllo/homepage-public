---
title: Podstawy SQL
date: '2007-02-26T09:21:00Z'
lastmod: '2009-10-31T15:26:13Z'
draft: false
tags:
- dydaktyka
- db
- sql
description: db, sql, dydaktyka
author: 83.230.47.20
toc: true
---

Uwaga: przedstawione tutaj polecenia zapisane są w dialekcie MySQL. W innych SZBD mogą one nie działać dokładnie
tak, jak to przedstawiono poniżej. W razie wątpliwości należy sprawdzić dokumentację odpowiedniego SZBD (np. na [gotAPI.com](http://gotapi.com)).

Definiowanie schematu bazy danych
---------------------------------

Plecenie **CREATE TABLE** służy do tworzenia schematów table:
CODEBLOCK\_PLACEHOLDER\_1
**table\_name** to nazwa tworzonej tabeli. **column1**, **column2**, ... to
nazwy kolumn występujących w tabeli. **column1\_type**, **column2\_type**, ...
to domeny (zbiory wartości) poszczególnych kolumn (np. VARCHAR, INTEGER).
Klauzula **PRIMARY KEY** określa zbiór kolumn, które stanowią **klucz podstawowy**
tworzonej tabeli.

#### Przykład

Polecenie:
CODEBLOCK\_PLACEHOLDER\_2

tworzy tablę **Osoby**, która zawiera kolumny:

1.  **Imię** typu VARCHAR (łańcuch o zmiennej liczbie znaków)
2.  **Nazwisko** typu VARCHAR
3.  **PESEL** typu INTEGER (liczba całkowita)

**Kluczem** tabeli jest kolumna **PESEL**.

Manipulowanie danymi
--------------------

W każdej bazie danych wykonywane są 4 podstawowe typy operacji
(CRUD - create, read, update, delete):

-   **dodawanie** nowych danych do bazy
-   **wyświetlanie** danych zgromadzonych w bazie
-   **modyfikowanie** danych występujących w bazie
-   **usuwanie** danych z bazy

Język SQL zawiera polecenia odpowiadające tym operacjom:

-   **INSERT**
-   **SELECT**
-   **UPDATE**
-   **DELETE**

### INSERT

Polecenie **INSERT** pozwala **dodawać nowe dane** do instancji bazy danych.
Polecenie to występuje w dwóch postaciach:<br/>
CODEBLOCK\_PLACEHOLDER\_3
Pierwsza postać polecenia pozwala określić wartości poszczególnych
atrybutów poprzez ich nazwę. W drugiej postaci wykorzystywana jest
domyślna kolejność atrybutów, zdefiniowana w schemacie określonej relacji.

#### Przykład

Dla relacji Osoby(Imie, Nazwisko, PESEL), polecenia:<br/>
CODEBLOCK\_PLACEHOLDER\_4
powodują dodanie do bazy nowej informacji o osobie, której imię to "Jan", nazwisko "Kowalski",
a pesel 123654.

### DELETE

Polecenie **DELETE** pozwala na **usuwanie informacji** z bazy danych.
Zazwyczaj stosuje się je w postaci:<br/>
CODEBLOCK\_PLACEHOLDER\_5
Użycie polecenia **bez klauzuli WHERE oraz LIMIT** powoduje usunięci **wszystkich**
wierszy znajdujących się w tabeli.<br/>
Klauzula WHERE pozwala określić warunek (np. saldo &lt; 0), który muszą spełniać wiersze,
które mają zostać usunięte z tabeli.
Klauzula LIMIT ogranicza liczbę usuwanych wierszy do wartości x. Zaleca się stosowanie
tej klauzuli, ze względu na nieodwracalność zmian wprowadzanych w bazie danych oraz
możliwość pomyłki.

#### Przykład

Dla relacji Osoby(Imie, Nazwisko, PESEL), która zawiera krotki:<br/>
| **Imie** | **Nazwisko** | **PESEL** |
|Jan|Kowalski|123654|
|Andrzej|Kowalski|321456|
|Jan|Jankowski|444555|

polecenie:<br/>
CODEBLOCK\_PLACEHOLDER\_6
spowoduje usunięcie wyłącznie pierwszej krotki.

### UPDATE

Polecenie **UPDATE** pozwala na **aktualizację danych** zawartych w instancji bazy
danych. Polecenie to przyjmuje zazwyczaj postać:
CODEBLOCK\_PLACEHOLDER\_7
gdzie znaczenie klauzul WHERE i LIMIT jest takie samo jak w przypadku polecenie
DELETE.

#### Przykład

Dla relacji Osoby(Imie, Nazwisko, PESEL), która zawiera krotki:<br/>
| **Imie** | **Nazwisko** | **PESEL** |
|Jan|Kowalski|123654|
|Andrzej|Kowalski|321456|
|Jan|Jankowski|444555|

polecenie:<br/>
CODEBLOCK\_PLACEHOLDER\_8
spowoduje zamianę imienia "Jan" na "Wojciech" wyłącznie w pierwszej krotce.

### SELECT (pojedyncza tabela)

Polecenie **SELECT wyświetla dane** zgromadzone w jednej lub większej liczbie tabel
znajdujących się w bazie danych.

Jego omówienie zaczniemy od przypadku wyświetlenia danych znajdujących się w jednej
tabeli. W tym prostym przypadku składnia polecenia jest następująca:<br/>
CODEBLOCK\_PLACEHOLDER\_9
gdzie:

1.  **column1, column2,...** to nazwy kolumn, których zawartość ma być wyświetlona jako wynik zapytania.
2.  **table\_name** to nazwa tabeli, z której pobierane są dane
3.  **condition** to warunek jaki muszą spełniać wiersze tabeli, aby zostać wyświetlone
4.  **o\_column** to kolumna, wg. której mają być posortowane wyniki zapytania
5.  **x&nbsp;** to pozycja wiersza, od którego mają być wyświetlane wyniki
6.  **y&nbsp;** to maksymalna liczba krotek, które mają pojawić się w wyniku

Ad. 1 <br/>
Jeżeli zamiast nazw kolumn wpiszemy znak '****'\* to zostaną wyświetlone dane z
wszystkich kolumn.

Ad. 3 <br/>
W warunkach:

-   można stosować **operatory porównania** =, &gt;=, &gt;, etc.
-   można stosować **operatory logiczna** AND i OR
-   do porównywania **wartości pustych (NULL)** należy stosować składnię **IS NULL** oraz **IS NOT NULL**
-   do porównywania **łańcuchów** można stosować polecenie **LIKE** akceptujące wzorce
    napisów, w których znak **'\_'** zastępuje dowolną literę, zaś znak **'%'** zastępuje dowolny
    ciąg znaków

Ad. 4 <br/>
Sortowanie wyników:

-   może odbywać się według **kilku kolumn**, których nazwy oddzielane są przecinkiem
-   jest dla danej kolumny domyślnie zgodne z naturalnym porządkiem jej wartości,
    a **odwrotne** po dodaniu modyfikatora **DESC**

#### Przykład

Niech dana będzie tabela Osoby(Imie, Nazwisko, PESEL):<br/>
| **Imie** | **Nazwisko** | **PESEL** |
| Jan | Andrzejewski | 345 |
| Jan | Wojtkiewicz | 123 |
| Wojciech | Kowalski | 123 |

(pomijamy fakt, że PESEL nie może powtarzać się dla dwóch osób).

<br/>
**Polecenie:**
CODEBLOCK\_PLACEHOLDER\_10
da w wyniku:<br/>

|          |              |
|----------|--------------|
| **Imie** | **Nazwisko** |
| Jan      | Wojtkiewicz  |
| Wojciech | Kowalski     |

<br/>
**Polecenie:**
CODEBLOCK\_PLACEHOLDER\_11
da w wyniku:<br/>

|          |              |           |
|----------|--------------|-----------|
| **Imie** | **Nazwisko** | **PESEL** |
| Jan      | Andrzejewski | 345       |
| Jan      | Wojtkiewicz  | 123       |

<br/>
**Polecenie:**
CODEBLOCK\_PLACEHOLDER\_12
da w wyniku:<br/>

|          |              |           |
|----------|--------------|-----------|
| **Imie** | **Nazwisko** | **PESEL** |
| Jan      | Wojtkiewicz  | 123       |
| Wojciech | Kowalski     | 123       |
| Jan      | Andrzejewski | 345       |

### SELECT (wiele tabel)

W przypadku wyświetlania danych z kilku tabel może wystąpić sytuacja, w której kolumny
kilku tabel, a nawet same tabele (w przypadku związków rekurencyjnych) będą się powtarzać.
W przypadku **kolumn** problem ten rozwiązywany
jest poprzez poprzedzenie ich nazw **zakończonej kropką nazwą tabeli**, do której należą.
(np. Osoby.Imie). W przypadku **tabel** możemy zastosować **klauzulę AS**, które zamienia
nazwę danej tabeli na inną (np. Osoby AS Rodzice).

Jeśli chcemy wyświetlić dane z wielu tabel konieczne jest określenie \*sposobu łączenia
krotek\* występujących w tych tabelach. W domyślnej postaci tworzony jest bowiem
iloczyn kartezjański wszystkich krotek, co zazwyczaj nie jest pożądane.

Rozwiązaniem tego problemu może być określenie warunku, który będzie wymagał
aby wartości kolumn w dwóch tabelach były identyczne (np. Osoby.PESEL = Adresy.PESEL).
To rozwiązanie nie jest jednak doskonałe, gdyż w wyniku zostaną pominięte krotki, których
wartość (lub zbiór wartości) dla łączonych atrybutów nie występuje w łączonej
tabeli.

W języku SQL występuje specjalna **klauzula JOIN**, która pozwala rozwiązać problem tego
rodzaju. Składnia polecenia SELECT z klauzulą JOIN jest następująca:
CODEBLOCK\_PLACEHOLDER\_13
**condition** określa sposób łączenia krotek. Zazwyczaj w warunku będzie
wymagało się, żeby wartość kolumny w jednej tabeli była taka sama jak wartość
kolumny w innej tabeli (table1.columnA = table2.columnB).

Występują trzy wersje klauzuli JOIN:

-   INNER
-   LEFT \[OUTER\]
-   RIGHT \[OUTER\]

W przypadku **INNER JOIN** dana krotka zostanie uwzględniona wyłącznie w wypadku, gdy
w drugiej tabeli występuje krotka (lub krotki), których wartość dla kolumn
określonych w warunku jest taka sama. Klauzula INNER jest opcjonalna (tzn. klauzula
JOIN bez modyfikatorów działa jak INNER JOIN).

W przypadku **LEFT JOIN** dana krotka
zostanie uwzględniona w wyniku, nawet jeżeli w drugiej
tabeli nie będzie krotek, które mogłyby być z nią połączone (dla których były
spełniony warunek ON...).

W przypadku **RIGHT JOIN** uwzględniane
są krotki z drugiej tabeli, które nie posiadają
odpowiedników wśród krotek tabeli pierwszej.

Pozostałe klauzule opisane w poprzednim
punkcie (np. ORDER BY, LIMIT, etc.) działają
również w przypadku łączenia wielu tabel.

#### Przykład

Tabela Osoby(Imie, Nazwisko, PESEL)
| **Imie** | **Nazwisko** | **PESEL** |
| Jan | Andrzejewski | 345 |
| Jan | Wojtkiewicz | 123 |
| Wojciech | Kowalski | 123 |

<br/>
Tabela Adresy(PESEL, Ulica, Nr)
| **PESEL** | **Ulica** | **Nr** |
| 123 | Sobieskiego | 17 |
| 123 | Zielonego | 15 |
| 111 | Abecadło | 1 |

<br/>
**Dla zapytania:**
CODEBLOCK\_PLACEHOLDER\_14
otrzymamy wynik:
| **Imie** | **Nazwisko** | **Osoby.PESEL** | **Adresy.PESEL** | **Ulica** | **Nr** |
| Jan | Wojtkiewicz | 123 | 123 | sobieskiego | 17 |
| Wojciech | Kowalski | 123 | 123 | sobieskiego | 17 |
| Jan | Wojtkiewicz | 123 | 123 | zielonego | 15 |
| Wojciech | Kowalski | 123 | 123 | zielonego | 15 |

<br/>
**Dla zapytania:**
CODEBLOCK\_PLACEHOLDER\_15
otrzymamy wynik:
| **Imie** | **Nazwisko** | **Osoby.PESEL** | **Adresy.PESEL** | **Ulica** | **Nr** |
| Jan | Andrzejewski | 345 | NULL | NULL | NULL |
| Jan | Wojtkiewicz | 123 | 123 | sobieskiego | 17 |
| Jan | Wojtkiewicz | 123 | 123 | zielonego | 15 |
| Wojciech | Kowalski | 123 | 123 | sobieskiego | 17 |
| Wojciech | Kowalski | 123 | 123 | zielonego | 15 |

<br/>
**Dla zapytania:**
CODEBLOCK\_PLACEHOLDER\_16
otrzymamy wynik:
| **Imie** | **Nazwisko** | **Osoby.PESEL** | **Adresy.PESEL** | **Ulica** | **Nr** |
| Jan | Wojtkiewicz | 123 | 123 | sobieskiego | 17 |
| Wojciech | Kowalski | 123 | 123 | sobieskiego | 17 |
| Jan | Wojtkiewicz | 123 | 123 | zielonego | 15 |
| Wojciech | Kowalski | 123 | 123 | zielonego | 15 |
| NULL | NULL | NULL | 111 | abecadlo | 1 |
