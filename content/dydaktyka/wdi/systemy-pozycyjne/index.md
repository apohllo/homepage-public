---
title: Systemy pozycyjne
date: '2010-12-16T05:27:00Z'
lastmod: '2010-12-16T07:22:24Z'
draft: false
author: 149.156.172.11
---

### Konwersja liczba całkowitych z systemu dwójkowego do dziesiętnego

Wartość cyfry na określonej pozycji obliczana jest poprzez pomnożenie tej cyfry przez odpowiednią
potęgę podstawy systemu (czyli dwójki). Cyfra na zerowej pozycji (licząc od prawej) mnożona jest przez
2<sup>0</sup> czyli 1, na drugiej przez 2<sup>1</sup> czyli 1, itd.

Przykład

2<sup>6</sup> 2<sup>5</sup> 2<sup>4</sup> 2<sup>3</sup> 2<sup>2</sup> 2<sup>1</sup> 2<sup>0</sup> <br/>
1&nbsp;  0&nbsp; 1&nbsp;  0&nbsp;  1&nbsp;  1&nbsp;  0 <br/>
64 + 16 + 4 + 2 = 86

### Konwersja liczb całkowitych z systemu dziesiętnego do dwójkowego

Konwersja polega na wielokrotnym całkowitym dzieleniu liczby dziesiętnej przez podstawę systemu.
Wynik dzielenia jest wykorzystywany w kolejnym obliczeniu, a reszta z dzielenia staje wchodzi do
reprezentacji w systemie dwójkowym. Wynik konwersji to kolejne reszty z dzielenia odczytane w kolejności
odwrotnej do ich uzyskania. Najprościej konwersję tę przeprowadzić w słupku, gdzie po prawej wpisuje
się kolejne reszty, a poniżej - kolejne wyniki dzielenia całkowitego.

Przykład

    101 | 1
     50 | 0
     25 | 1
     12 | 0
      6 | 0
      3 | 1
      1 | 1
      0 |

Wynik: 1100101<sub>2</sub>

### Konwersja ułamków z systemu dwójkowego do dziesiętnego

Wartość cyfry na określonej pozycji obliczana jest poprzez pomnożenie tej cyfry przez ujemną
potęgę podstawy systemu (czyli dwójki). Cyfra na pierwszej pozycji (licząc od lewej) mnożona jest przez
2<sup>-1</sup> czyli 1/2, na drugiej przez 2<sup>-2</sup> czyli 1/4, itd.

Przykład

    2<sup>-1</sup> 2<sup>-2</sup> 2<sup>-3</sup> <br/>
0, 1&nbsp;   0&nbsp;   1<br/>
1/2 + 1/8 = 5/8

### Konwersja ułamków dziesiętnych na system dwójkowy

W przypadku zamiany ułamków dziesiętnych na reprezentację binarną, dokonujemy wielokrotnego mnożenia ułamka przez
podstawę systemu, czyli liczbę dwa. Część całkowita uzyskanego wyniku wchodzi staje się elementem
reprezentacji binarnej, natomiast część dziesiętna wykorzystywana jest w kolejnym obliczeniu.
Wynik odczytywany jest w kolejności zgodnej z wykonywaniem kolejnych mnożeń. Uzyskanie dwukrotnie tej samej
wartości oznacza, że ułamek jest okresowy. Obliczenia najlepiej przeprowadzać w słupku (patrz przykład).

Przykład

Zamiana 0,1

     0 | 1
       ,
     0 | 2
     0 | 4
     0 | 8
     1 | 6
     1 | 2
     0 | 4
     0 | 8
     1 | 6
     ...

Wynik 0,0(0011)<sub>2</sub>

### Konwersja pomiędzy systemami, spośród których podstawa pierwszego jest potęgą podstawy drugiego systemu

Jeżeli podstawa jednego systemu pozycyjnego jest potęgą podstawy drugiego systemu (np. system szesnastkowy
i system dwójkowy), to można dokonywać prostej konwersji pomiędzy nimi z pominięciem zamiany na system dziesiętny.

Wiadomo bowiem, że jednej pozycji w systemie o podstawie większej będzie odpowiadało dokładnie tyle pozycji
w systemie o podstawie mniejszej ile wynosi potęga podstawy systemu pierwszego (w przypadku systemu
szesnastkowego i dwójkowego, jednej pozycji systemu szesnastkowego odpowiadają cztery pozycje systemu dwójkowego).

Dokonując konwersji możemy zatem każdą pozycję lub grupę pozycji konwertować niezależnie.

Przykład

        A    B    C
     1010 1011 1100

ABC<sub>16</sub> = 101010111100<sub>2</sub>

     1000 0011 0001
        8    3    1

100000110001<sub>2</sub> = 831<sub>16</sub>
