---
title: Diagramy UML
date: '2010-03-10T10:11:00Z'
lastmod: '2010-03-10T11:32:09Z'
draft: false
tags:
- db
- uml
author: 149.156.173.53
---

**UML = Unified Modeling Language**

Język UML definiuje obecnie kilkanaście różnych typów diagramów. Spośród nich najbliższe diagramom ER są diagramy klas i tylko one zostaną
(bardzo pobieżnie) omówione.

### Pojęcia podstawowe

Diagramy klas pozwalają w sposób graficzny opisywać model konceptualny (tutaj model obiektowy).
Do ich podstawowych elementów należą:

-   **klasy** (odpowiadają zbiorom encji) reprezentowane przez prostokąty podzielone wertykalnie na 3 części, których pierwsza część zawiera nazwę klasy
-   **atrybuty**, które reprezentują stan obiektów klasy, a na diagramie są umieszczane wewnątrz drugiej części opisu klasy
-   **metody** (nie mają odpowiednika na diagramach ER), które reprezentują zachowanie obiektów, a na diagramie są umieszczane wewnątrz trzeciej części opisu klasy
-   **związki**, reprezentowane przez linie łączące klasy

![](/images/klasa.png)

Metody nie mają swoich odpowiedników na diagramach ER, zatem można je pominąć na diagramie klas modelu konceptualnego bazy danych.

### Typy związków

W ogólności wyróżniamy 2 typy związków:

-   związki na poziomie **obiektów**
-   związki na poziomie **klas**

Pierwszy typ dotyczy związków, które zachodzą pomiędzy konkretnymi obiektami klasy, np. związek "posiada" łączy konkretną osobę z konkretnym
samochodem.

Drugi typ dotyczy związków, które zachodzą pomiędzy klasami, czyli pojęciami, np. związek "jest specjalizacją", łączy pojęcia "pracownik" i "osoba".

#### Asocjacja

**Asocjacja** jest związkiem na poziomie obiektów. Przedstawiana jest w postaci linii, łączącej klasy.
Może być zaopatrzone w nazwę, ale nie jest to wymagane.

![](/images/asocjacja.png)

Występowanie asocjacji w ogólności znaczy, że obiekty odpowiednich klas są (lub mogą) być ze sobą powiązane, tzn. mając obiekt jednej klasy można
otrzymać powiązane z nim obiekty klasy drugiej. Istotne jest również to, że asocjacja może obejmować na raz więcej niż dwie klasy.

#### Agregacja

**Agregacja** jest związkiem na poziomie obiektów. Przedstawiana jest w postaci linii łączącej klasy, której jeden koniec jest białym rombem.

![](/images/agregacja.png)

Występowanie agregacji oznacza, że obiekty klasy, która stoi po stronie rombu agregują obiekty drugiej klasy. W ogólności znaczy to tyle, że jeden
obiekt pierwszej klasy może *mieć przypisane* wiele obiektów drugiej klasy, ale nie odwrotnie. Dla asocjacji charakterystyczne też jest to, że
związek ten nie jest obligatoryjny, tzn. obiekty obu klas mogą istnieć całkowicie niezależnie (tak jak np. kosz na śmieci i śmieci).

Należy również podkreślić, że agregacja może obejmować tylko dwie klasy.

#### Kompozycja

\*Kompozycja jest również związkiem na poziomi obiektów. Przedstawiana jest w postaci linii łączącej klasy, której jeden koniec jest czarnym rombem.

![](/images/kompozycja.png)

Występowanie kompozycji oznacza, że obiekty klasy, która stoi po stronie rombu *składają się* z obiektów drugiej klasy. W ogólności znaczy to, że
obiekty pierwszej klasy mogą być powiązane z wieloma obiektami drugiej klasy, ale również, że obiekty tej drugiej klasy nie mogą istnieć samodzielnie.
W szczególności jeśli obiekt pierwszej klasy zostanie zniszczony, również obiekty drugiej klasy są niszczone.

Należy również podkreślić, że kompozycja może obejmować tylko dwie klasy.

#### Różnica między kompozycją a agregacją

Różnica pomiędzy kompozycją a agregacją dotyczy sposobu w jaki łączą one instancje uczestniczących w nich klas. O ile w pierwszym przypadku,
jeśli jakiś obiekt jest połączony z innym obiektem (jest jego częścią) - nie może być jednocześnie częścią innego obiektu. Zatem ma ona charakter
podobny do fizycznego komponowania faktycznie istniejących obiektów. Natomiast agregacja ma charakter bardziej logiczny i nie wyklucza sytuacji,
w której dany obiekt jest agregowany przez kilka obiektów-pojemników.

Porównując te związki ze związkami na diagramach ER, kompozycja podobna jest do związku identyfikującego jaki łączy encję ze słabą encją.
Różnica polega na tym, że w przypadku diagramów ER mamy do czynienia z identyfikacją obiektów (związek identyfikujący służy przede wszystkim
do identyfikacji słabej encji), o tyle w przypadku diagramów UML mamy do czynienia z logicznym powiązaniem odpowiednich elementów (dla których
identyfikacja jest tylko jednym z aspektów).
