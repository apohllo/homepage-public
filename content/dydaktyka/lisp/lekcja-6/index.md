---
title: Lekcja 6
date: '2010-11-27T11:13:00Z'
lastmod: '2010-11-27T11:14:13Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 5](/dydaktyka/lisp/lekcja-5) | [Lekcja 7](/dydaktyka/lisp/lekcja-7)

6. Lista – przydatne funkcje
----------------------------

Wagonik to nazwa dla dwuelementowego rekordu. Z przyczyn historycznych jego pola są nazywane "car" i "cdr". Ich użycie jest niezwykle proste:

#### 6.1. Zaalokuj wagonik - ustaw car na 2, a cdr na 8

```lisp
(cons 2 8) =&gt; (2 . 8)
```

#### 6.2. car i cdr

```lisp
(car (cons 2 8)) =&gt; 2
(cdr (cons 2 8)) =&gt; 8
(cons (cons 2 8) 5) =&gt; ((2 . 8) . 5)
```

### CONS

Określenie CONS jest skrótem dla CONStruct. Funkcja CONS tworzy komórkę posiadającą dwa pola. CONS pobiera dwa argumenty i zwraca wskaźnik na nowo utworzoną komórkę, której CAR wskazuje na pierwszy, zaś CDR na drugi argument z wejścia. Jeśli próbujemy wyjaśnić CONS używających notację nawiasu, moglibyśmy powiedzieć, że CONS dodaje element do przodu listy.

#### 6.3.

```lisp
(cons A (B C D)) =&gt; (A B C D)
(cons lata (lub plywa)) =&gt; (LATA LUB PLYWA)
```

Nazwa Lisp jest akronimem dla List Processor. Chociaż język dojrzał w wielu drogach przez lata, listy pozostały jego centralnym typem danych. Listy są ważne, ponieważ mogą reprezentować praktycznie wszystko: zbiory, tablice, a nawet zdania. Również funkcje mogą być reprezentowane jako listy.

### Listy

Lista to podstawowa struktura w Lispie. Można ją w prosty sposób utworzyć z wagoników: CAR każdego wagonika wskazuje na jeden z elementów listy, a CDR albo na następny element, albo na NIL. Stworzenie takiej powiązanej listy ułatwia funkcja list:

#### 6.4.

```lisp
(list 2 8 5) =&gt; (2 8 5)
```

Można tu zauważyć pewną różnicę pomiędzy tym i poprzednim przykładem. Mianowicie drukując LISP pomija niektóre kropki i nawiasy. Zasada jest taka: jeśli CDR wagonika to NIL, LISP nie drukuje kropki, ani nila; jeśli cdr wagonika A to wagonik B, to nie drukuje kropki dla wagonika A, ani nawiasów dla wagonika B. Tak więc:

#### 6.5.

```lisp
(cons 2 nil) =&gt; (2)
(cons 2 (cons 8 5)) =&gt; (2 8 . 5)
(cons 2 (cons 8 (cons 5 nil))) =&gt; (2 8 5)
```

Każda lista ma dwie formy: reprezentacje drukowaną i wewnętrzną. Drukowana reprezentacja jest najdogodniejsza dla użytku ludzi, ponieważ jest kompaktowa i łatwa do napisania na komputerowej klawiaturze. Wewnętrzna reprezentacja pokazuje jak właściwie lista istnieje w pamięci komputera.
W drukowanym formie, lista jest wiązką rzeczy załączonych w nawiasach. Te rzeczy to tzw. elementy listy.

#### 6.6.

```lisp
(RED GREEN BLUE)
(KROWA PIES KOT ŻABA)
(SLOWO)
(2 3 5 7 11 13 17)
```

Wewnętrzna reprezentacja list nie używa nawiasów. Wewnątrz pamięci komputera, listy zorganizowane są jako łańcuchy komórek, które narysujemy jako pudełka. Komórki te połączone są razem przez wskazówki, które narysujemy jako strzały. Każda komórka ma dwie wskazówki. Jedna z nich zawsze wskazuje do elementu listy, takie jak RED, zaś kolejna do następnej komórki w łańcuchu. A więc kiedy mówimy, że listy mogą zawierać symbole albo numery jako elementy, to w rzeczywistości mówimy, że komórki zawierają wskazówki do symboli albo numerów oraz wskazówki do innych komórek. Wewnętrzna reprezentacja komputera listy (RED GREEN BLUE) wygląda tak:

![](/images/5-1.gif)

Lista może również zawierać inne listy jako elementy.

#### 6.7.

```lisp
(NIEBIESKIE NIEBO)
(ZIELONA TRAWA)
(BRAZOWA ZIEMIA)
```

Możemy zrobić listę poprzez ich załączanie w innej parze nawiasów. W efekcie otrzymamy listę składającą się z trzech listów, nie listę sześciu symboli. Co możemy zapisać tak:

#### 6.8.

```lisp
((NIEBIESKIE NIEBO)(ZIELONA TRAWA)(BRAZOWA ZIEMIA))
```

lub tak:

#### 6.9.

```lisp
((NIEBIESKIE NIEBO)
(ZIELONA TRAWA)
(BRAZOWA ZIEMIA))
```

Układ liter w dokumencie i wcięcie nie mają znaczenia tak długo jak same elementy i nawiasy nie zostaną zmienione.
W pamięci komputera zaś nasza lista będzie wyglądać tak:

![](/images/5-2.gif)

Listy, które zawierają inne listy są nazywane listami zagnieżdżonymi. Listy, którzy nie są zagnieżdżone są nazywane listami płaskimi.

Listę zagnieżdżoną może otrzymać przy pomocy CONS, jeżeli pierwsze wejście do CONS będzie niepustą listą.

#### 6.10.

```lisp
(cons (jas) (i malgosia)) =&gt; ((JAS) I MALGOSIA)
(cons (milczenie jest) (zlotem)) =&gt; ((MILCZENIE JEST) ZLOTEM)
```

Za długość listy uważa się liczbę jej elementów to ma, na przykład, lista (CZESC MAMA) jest długości dwa. Problem pojawia się w przypadku list zagnieżdżonych, gdzie nie wiadomo, czy podliste traktować jako grupę elementów czy tez jeden element. Z punktem widzenia komputera, lista (A (B C) D) zawiera trzy elementy, ponieważ jej wewnętrzna reprezentacja zawiera trzy komórki najwyższego poziomy. Tak więc za długość listy przyjmiemy liczbę elementów, z których ona się składa, nie wnikając w ich złożoność. Każda z podanych niżej list ma długość trzech elementów:

#### 6.11.

```lisp
(CZERWONY NIEBIESKI ZIELONY)
((NIEBIESKIE NIEBO) ( ZIELONA TRAWA) (BRAZOWA ZIEMIA) )
(A (B X Y Z) C)
```

Pierwotna funkcja LENGTH oblicza długość listy. Błędem jest wywołanie funkcji LENGTH z symbolem albo numerem na wejściu.

### Lista pusta

Lista o zerowej liczbie elementów jest nazywana listą pustą. Zapisuje się ją w ten sposób:

#### 6.12.

```lisp
()
```

Wewnątrz komputera lista pusty jest reprezentowana przez symbol NIL. A ponieważ NIL i lista pusta są identyczne, możemy zawsze napisać NIL zamiast ( ) i vice versa. W ten sposób (NIL B) może też zostać napisany ( ( ) B). Oba zapisy można używać wymiennie, gdyż wewnątrz komputera są ona zapisane w ten sam sposób. Długość listy pustej jest zerem. I chociaż NIL jest symbolem, to mimo to może być podany na wejście funkcji LENGTH, ponieważ NIL jest także listą. NIL jest jedyną rzeczą, która jest zarówno symbolem, jak i listą.

Długość listy pustej jest zerem. I chociaż NIL jest symbolem, to mimo to może być podany na wejście funkcji LENGTH, ponieważ NIL jest także listą. NIL jest jedyną rzeczą, która jest zarówno symbolem, jak i listą.

Ponieważ NIL jest listą pustą, jeśli używamy CONS by dodać coś do NILa, dostajemy listę o jednym elemencie.

#### 6.13.

```lisp
(cons zaba nil) =&gt; (zaba)
```

### Lista cykliczna

Załóżmy że mamy daną listę cykliczną składającą się z elementów:

```lisp
A B C
```

Jeśli komputer spróbowałby wydrukować te listę, mogłaby zdarzyć się jedna z kilku rzeczy. Np.: komputer mógłby pójść do pętli nieskończonej. Albo też mógłby spróbować drukować część listy, używając trzech kropek:

```lisp
(A B C A B C A B ...)
```

Tak zapisana lista jest niepoprawna, ponieważ sugeruje, że lista zawiera więcej niż dziesięć elementów, kiedy to faktycznie zawiera tylko trzy. Jednak dialekt języka programowania Lisp dostarcza poprawny sposób do drukowania cyklicznych struktury przy użyciu znaku \#. Użyjemy liczb dla etykiet i notacji \# n = aby etykietować przedmiot. Napiszemy \# n \# aby odnieść się do przedmiotu później w wyrażeniu. Nasza lista zostanie teraz zapisana w ten sposób:

```lisp
\# 1 =( B C . \# 1 \#)
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 5](/dydaktyka/lisp/lekcja-5) | [Lekcja 7](/dydaktyka/lisp/lekcja-7)
