---
title: Schematy blokowe
date: '2007-10-11T09:01:00Z'
lastmod: '2009-09-04T08:06:10Z'
draft: false
tags:
- dydaktyka
- wdi
author: 83.230.47.20
toc: true
---

Schematy blokowe są jednym ze sposobów reprezentacji algorytmów.

Na schematach blokowych występują elementy dwóch typów:

1.  bloki
2.  strzałki

Bloki wskazują na instrukcje, które wykonywane są w ramach algorytmu, natomiast
strzałki wskazują kolejność wykonywania poszczególnych instrukcji.

Istniej cztery główne typy bloków:

-   graniczne
-   obliczeniowe
-   wyjścia-wejścia
-   decyzyjne

### Zmienne

W większości algorytmów konieczne jest przechowywanie pewnych informacji pomiędzy
wykonaniem kolejnych instrukcji algorytmu. W tym celu wykorzystuje się **zmienne**.
Dobrym odpowiednikiem zmiennej jest funkcja *memory* w kalkulatorach - pozwala zapamiętać
jakąś wartość i później ją wykorzystać. Jednak w przeciwieństwie do większości kalkulatorów,
w programie może występować wiele zmiennych.
Każda z nich posiada swoją etykietę, która w ramach jednego diagramu pozwala
na jej jednoznaczną identyfikację (tzn. wszystkie identyczne etykiety odnoszą
się do tej samej zmiennej). Każda zmienna pozwala na wykonanie na niej operacji
przypisania i odczytania wartości (logicznej, liczbowej, znakowej, etc.).

Wartość zmiennej może zmieniać się w trakcie wykonywania algorytmu. W szczególności
w jednym bloku, w którym występuje zmienna, w trakcie wykonywania algorytmu,
może ona posiadać różne wartości, a wartość aktualna to wartość,
która została jej nadana w ostatniej instrukcji przypisania.

Odczytanie wartości musi być zawsze poprzedzone co najmniej jednokrotnym
przypisaniem wartości do zmiennej. Złamanie tego warunku, powoduje, że algorytm
staje się niejednoznaczny.

Przypisanie wartości oznaczane jest za pomocą dwukropka, po którym występuje
znak równości, np. zapis:<br/>
`z := 1`<br/>
oznacza, że do zmiennej z została przypisana wartość 1.

Ta sama zmienna może występować jednocześnie po obu stronach instrukcji przypisania.
Jest to możliwe, ponieważ wartość, która zostaje przypisana do zmiennej jest w całości
obliczana przed dokonaniem przypisania. Np. zapis:<br/>
`z := 1`<br/>
`z := z + 1` <br/>
oznacza, że w pierwszy kroku do zmiennej z została przypisana wartość 1.
W drugim kroku najpierw następuje obliczenie wartości zmiennej po stronie prawej
(biorąc pod uwagę wartość zmiennej z z poprzedniego kroku, wynosi ona 2),
a następnie wartość ta zostaje przypisana do zmiennej z. Zatem wartość tej zmiennej
po wykonaniu przypisania wynosi 2.

### Bloki graniczne

Bloki graniczne służą do oznaczania instrukcji, od których zaczyna się lub na których kończy się algorytm. Schemat blokowy może posiadać tylko jeden blok startowy, z którego wychodzi
dokładnie jedna strzałka. Na schemacie może występować wiele bloków końcowych, do których
może prowadzić więcej niż jedna strzałka.

Bloki graniczne oznaczane są za pomocą owalu, w którym znajduje się napis START
(oznacza on początek algorytmu) lub STOP (oznacza on koniec algorytmu).

![](/images/sb_start.png)     ![](/images/sb_stop.png)

### Bloki obliczeniowe

Bloki obliczeniowe służą do oznaczania instrukcji, w których dokonywane są operacje
arytmetyczno-logiczne, najczęściej z wykorzystaniem zmiennych.
Bloki te mogą posiadać wiele strzałek wchodzących, ale tylko jedną strzałkę wychodzącą.

Bloki obliczeniowe są oznaczane za pomocą prostokąta.

![](/images/sb_calc.png)

### Bloki wyjścia/wejścia

Bloki wyjścia/wejścia służą do oznaczania operacji, w których pewne informacje są
przesyłane do/na zewnątrz wykonywanego algorytmu. Najczęściej odnosi się to do wyświetlenia
pewnego tekstu na ekranie komputera, wczytania danych z klawiatury, ale może również
oznaczać odczytanie lub zapisanie pliku na dysku komputera, wygenerowanie dźwięku, etc.

Bloki wyjścia/wejścia (w skrócie "bloki I/O", od input/output) mogą posiadać
tylko jedną strzałkę wychodzącą i wiele wchodzących.
Są one oznaczane za pomocą równoległoboku.

![](/images/sb_io.png)

### Bloki decyzyjne

Bloki decyzyjne służą do oznaczania operacji pozwalających na rozwidlenie
algorytmu (czyli wykonanie jednego z dwóch lub większej liczby alternatywnych
ciągów instrukcji).

Podstawowy typ bloków decyzyjnych to instrukcja warunkowa. Składa się ona z wyrażenia
logicznego, które może dać w wyniku tylko prawdę lub fałsz. Blok instrukcji
warunkowej oznaczany jest za pomocą rombu, z którego wychodzą dwie strzałki opatrzone
etykietami tak/nie (T/N), prawda/fałsz (P/F) lub w podobny sposób. Ewaluacja
wyrażenia logicznego, która daje w wyniku wartość `prawda` powoduje wykonanie jako następnej
instrukcji, która wskazywana jest przez strzałkę z etykietą `tak` (T, prawda, P, etc.)
W przeciwnym wypadku wykonywana jest instrukcja, wskazywana przez strzałkę z
etykietą `nie` (N, fałsz, F, etc.)

![](/images/sb_cond.png)

Innym typem instrukcji decyzyjnej jest instrukcja wyboru (selekcji). Oznaczana
jest ona za pomocą figury geometrycznej przedstawionej na poniższym rysunku:

![](/images/sb_select.png)

Instrukcja wyboru pozwala rozgałęzić algorytm na wiele alternatywnych ścieżek.
Wybór odpowiedniej ścieżki uzależniony jest od wartości zmiennej znajdującej
się wewnątrz instrukcji wyboru. Każda strzałka wychodząca z tej instrukcji
powinna być opatrzona konkretną wartością zmiennej, przedziałem jej wartości lub
nierównością, dla której
wybrana powinna być instrukcja, wskazywana przez tę strzałkę.

Zbiory wartości występujące w instrukcji wyboru powinny być rozłączne i dawać w sumie
zbiór wszystkich wartości, które może przyjmować zmienna.

![](/images/sb_select_ex.png)
