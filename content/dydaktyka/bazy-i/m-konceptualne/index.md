---
title: Modelowanie konceptualne
date: '2007-02-26T08:58:00Z'
lastmod: '2010-03-10T10:14:49Z'
draft: false
tags:
- dydaktyka
- db
- erd
- isa
description: db, erd, isa, dydaktyka
author: 149.156.173.53
toc: true
---

### Opis rzeczywistości

-   klasy, obiekty, relacje
-   procesy, zdarzenia

### Pojęcia podstawowe

-   **obiekty = encje = instancje** - istniejące niezależnie i dające się zidentyfikować elementy rzeczywistości. Najczęściej opisywane za pomocą rzeczowników lub nazw własnych. Przykłady: **osoba, Jan Kowalski**.
-   **atrybuty = własności** - cechy obiektów, posiadające wartość należącą do określonego zbioru (domeny). Najczęściej opisywane za pomocą przymiotników i liczebników. Przykłady: **wysoki, ważący 54kg**.
-   **związki = relacje** - elementy rzeczywistości, których istnienie nie jest niezależne - występują pomiędzy dwoma lub większą liczbą obiektów. Opisywane są za pomocą dwu i więcej argumentowych predykatów. Przykłady: X&nbsp;**jest synem** Y, X&nbsp;**przybył&nbsp;z** Y&nbsp;**do** Z.
-   **klasy = zbiory encji** - zbiory obiektów, posiadających wspólne cechy, należących do jednego rodzaju. Opisywane są najczęściej za pomocą rzeczowników pospolitych w liczbie mnogiej. Przykłady: **ludzie, lemury**.

### Etapy modelowania konceptualnego

\* identyfikowanie **obiektów**

\* identyfikowanie **atrybutów**

\* identyfikowanie **klas obiektów**

\* identyfikowanie **relacji** występujących pomiędzy **klasami obiektów**:

1.  **generalizacja/specjalizacja** - klasa bardziej specyficzna, posiada wszystkie cechy klasy bardziej ogólnej. Przykład (k. ogólna - k. specyficzna): **zwierzę - pies, narzędzie - młotek**.
2.  **powiązanie** - relacja występująca pomiędzy obiektami należącymi (najczęściej) do dwóch różnych klas. Przykład: osoba **prowadzi** samochód (tzn. każdy samochód będący w ruchu, jest prowadzony przez jakąś osobę).
3.  **agregacja** - szczególny rodzaj powiązania, w którym można wyróżnić klasę **całość** oraz klasę **część**. Przykład: **biblioteka - książka**.
4.  **kompozycja** - szczególny rodzaj agregacji, w którym obiekty-części nie mogą występować bez obiektu-całości. Przykład: **ciało - organy**.

\* krotność powiązania - dopuszczalna liczba powiązań występujących pomiędzy obiektami dwóch klas:

1.  **1 do 1 = jeden do jeden** - jeden obiekt pierwszej klasy może być powiązany tylko i wyłącznie z jednym obiektem drugiej klasy. Przykład: **samochód - kierownica**.
2.  **1 do n = jeden do wiele** - jeden obiekt pierwszej klasy może być powiązany z jednym lub więcej obiektami drugiej klasy, ale jeden obiekt drugiej klasy może być powiązany tylko z jednym obiektem klasy pierwszej. Przykład: **żaglówka - członkowie załogi**.
3.  **n do n = wiele do wielu** - zarówno obiekt klasy pierwszej może być powiązany z jednym lub więcej obiektami klasy drugiej, jak i obiekt klasy drugiej może być powiązany z jednym lub więcej obiektami klasy pierwszej. Przykład: **aktor - sztuka**.

Powyższe przypadki nie wyczerpują wszystkich możliwości, ale reprezentują najczęściej spotykane
zależności pomiędzy klasami.
