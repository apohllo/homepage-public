---
title: Modelowanie relacyjne
date: '2007-02-26T09:03:00Z'
lastmod: '2009-04-22T05:38:35Z'
draft: false
tags:
- db
- rdb
description: db, rdb, dydaktyka
author: 149.156.96.14
toc: true
---

Relacyjny model danych
----------------------

Na wstępie należy podkreślić, że znaczenie pojęcia relacji wykorzystywanego
w **relacyjnym modelu baz danych** jest inne niż pojęcia relacji (tzn. związku),
występującego w **modelu konceptualnym**.

Podstawowymi pojęciami wykorzystywanymi w modelach relacyjnych są:

-   **relacje** (inaczej tabele)
-   **schematy**
-   **krotki** (inaczej wiersze)
-   **instancje**
-   **atrybuty** i związane z nimi **dziedziny**
-   **klucze** *pierwotne* PF (Primary Key) oraz *obce* FK (Foreign Key).

### Relacje

Relacyjny model danych dostarcza tylko jednego sposobu na reprezentowanie
danych - poprzez **dwuwymiarową tabelę**, zwaną również **relacją**. Poniżej
przedstawiona jest relacja, w której przechowywane są dane o osobach:
| **Imię** | **Nazwisko** |
| Jan | Kowalski |
| Tomasz | Mazurek |
| ... | ... |

### Schemat relacji

Struktura relacji opisywana jest za pomocą **schematu**, który składa się
z jej nazwy, po której wypisany jest zbiór jej **atrybutów** oddzielonych przecinkami i
otoczonych nawiasami okrągłymi.

Schemat odpowiadający powyższej relacji: <code> Osoby (Imię, Nazwisko)</code>.

Kolejność atrybutów w schemacie nie jest istotna z punktu
widzenia modelu, ale warto przyjąć kolejność domyślną, dzięki czemu wypisując
poszczególne krotki należące do relacji wiadomo jakie wartości odpowiadają jakim
atrybutom.

### Krotki

Poszczególne krotki należące do relacji mogą być przedstawiane
w postaci tabeli (j.w.) lub z wykorzystaniem konwencji podobnej do tej
stosowanej w przypadku schematu - wartości poszczególnych atrybutów
oddzielone są przecinkami, i otoczone nawiasami okrągłymi:<br/>
<code>(Jan, Kowalski)</code><br/>
<code>(Tomasz, Mazurek)</code>

Zbiór krotek konkretnej relacji zwany jest jej **instancją**. Schemat relacji
jest całkowicie niezależny od jej instancji, tzn. może być wykorzystywany
do opisu wielu relacji, które posiadają różne instancje (albo "tej samej"
relacji, w różnych momentach czasowych).

W instancji relacji nie mogą występować dwie krotki, dla których wartości wszystkich
atrybutów byłyby identyczne - są one po prostu traktowane jak jedna krotka.
W schemacie relacyjnym mogą również pojawić się dodatkowe ograniczenia, dotyczące
wartości krotek w instancji (patrz p. klucze).

### Atrybuty (kolumny)

Każdy **atrybut** należący do schematu relacji musi mieć określoną **domenę**, tj.
zbiór dopuszczalnych wartości, np.:

-   **BIT** - łańcuchy bitów o stałej długości
-   **BIT VARYING** - łańcuchy bitów o zmiennej długości
-   **BLOB** - duże obiekty binarne (np. grafika)
-   **BOOLEAN** - wartości logiczne (prawda/fałsz)
-   **CHAR** - łańcuchy znaków o stałej długości
-   **CLOB** - duże obiekty tekstowy
-   **DATE** - daty
-   **DECIMAL** - liczby dziesiętne (np. rozliczenia finansowe)
-   **DOUBLE**, **FLOAT**, **REAL** - liczby zmiennoprzecinke (o różnej precyzji)
-   **INTEGER**, **SMALLINT** - liczby całkowite
-   **TIME** - czas w formacie HH:MM:SS
-   **TIMESTAMP** - znaczniki czasu (data + czas)
-   **VARCHAR** - łańcuchy znaków o zmiennej długości (max. 255)

Atrybuty mogą posiadać pewne dodatkowe własności lub ograniczenia:

-   np. **maksymalną długość** łańcucha znaków
-   **wartość domyślną**
-   **dopuszczalność wartości NULL**
-   **unikalność wartości**

### Klucze

Tak jak w przypadku modeli ER, tak też w modelach relacyjnych wykorzystuje się
pojęcie **kluczy**, tj. zbioru atrybutów, których wartości pozwalają na jednoznaczną
identyfikację krotek. Klucz **główny**, to jeden z, być może większej liczby, kluczy, który
stosowany jest domyślnie do identyfikowania krotek.

W schemacie relacji może występować również klucz **obcy**, tj. atrybut lub
zbiór atrybutów, których wartości odpowiadają wartościom atrybutu(ów) należących
do klucza głównego, występującego w innej relacji. Dzięki kluczom obcym
możliwe jest identyfikowanie powiązanych ze sobą krotek.
