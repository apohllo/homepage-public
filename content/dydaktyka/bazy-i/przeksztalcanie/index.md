---
title: Przekształcanie
date: '2007-02-26T09:09:00Z'
lastmod: '2009-05-13T11:50:56Z'
draft: false
tags:
- dydaktyka
- db
- erd
- rdb
description: db, erd, rdb, dydaktyka
author: 149.156.161.171
toc: true
---

Przekształcanie modelu konceptualnego do modelu relacyjnego.
------------------------------------------------------------

### Zbiory encji

**Zbiory encji** przekształcane są w **relacje**, a towarzyszące im atrybuty w
odpowiednie atrybuty relacji:<br/>
![](/images/rdb/osoba.png)
<br/>
**Osoby (Imię, Nazwisko, *PESEL* , Wiek)**

Relacje, które odpowiadają zbiorom **słabych encji**, poza własnymi atrybutami, muszą
zawierać atrybuty będące **kluczami** wszystkich zbiorów encji, które służą do
ich identyfikacji (poprzez związek identyfikujący). Atrybuty te (będąc *de facto* kluczami obcymi) wchodzą w skład klucza głównego tej relacji:<br/>
![](/images/rdb/weak.png)
<br/>
\*Muzea (*Nazwa*) <br/>
Wystawy (*Nazwa*, *Tytuł*)<br/>
FK (Nazwa):Muzea<br/>
Bilety (*Nazwa*, *Tytuł*, *Rodzaj*, Cena)<br/>
FK (Nazwa,Tytuł):Wystawy<br/>\*

W sytuacji, gdy nazwy atrybutów powtarzają się lub jeśli występuje obawa niejednoznaczności,
można zmienić nazwę atrybutu, tak aby zawierał nazwę zbioru encji, z którego pochodzi:<br/>
**Bilety (*Nazwa\_muzeum*, *Tytuł\_wystawy*, *Rodzaj*, Cena)**.

### Związki

#### Krotność 1-do-1

Związki o krotności **1-do-1** przekształcamy w taki sposób, aby jedna z
relacji, będących odpowiednikiem zbioru encji uczestniczących w związku,
posiadała wszystkie atrybuty, które są kluczami drugiej relacji. Innymi słowy
do tej relacji dodajemy klucz obcy wzięty z drugiej relacji.
W zasadzie nie ma znaczenia, którą relację wybierzemy, tym niemniej w sytuacji,
gdy dla jednej ze stron związku jest on obowiązkowy, a dla drugiej nie, to
dodatkowe atrybuty umieszczamy właśnie w tej relacji. Atrybuty wzięte
z drugiej relacji nie wchodzą w skład klucza głównego relacji:<br/>
![](/images/rdb/1_to_1.png)
<br/>
\*Konkursy (*Nazwa*)<br/>
Zwycięzcy (*Imię*, *Nazwisko*, Nazwa\_konkursu)<br/>
FK (Nazwa\_konkursu):Konkursy\*

Jeśli
związek posiada atrybuty, to są one umieszczane w tej relacji, do której dodano
klucz obcy.

#### Krotność 1-do-n

Związki o krotności **1-do-n** przekształcamy w taki sposób, aby
relacja, która odpowiada zbiorowi encji, które posiadają w związku
co najwyżej jednego partnera (stoją po stronie <b>n</b>), poza własnymi
atrybutami, posiadały również atrybuty kluczowe drugiej relacji.
Mówiąc krótko - w relacji stojącej po stronie n dodajemy klucz obcy wzięty z relacji
stojącej po stronie 1 związku.
Dodatkowe atrybuty nie wchodzą do klucza tej relacji:<br/>
![](/images/rdb/1_to_n.png)
<br/>
\*Reżyserzy (*Imię*, *Nazwisko*)<br/>
Filmy (*Tytuł*, *Rok*, Imię\_reżysera, Nazwisko\_reżysera)<br/>
FK (Imię\_reżysera, Nazwisko\_reżysera):Reżyserzy\*

Jeśli
związek posiada atrybuty, to są one umieszczane w tej relacji, która
stoi po stronie <b>n</b> związku.

#### Krotność n-do-n

Związki o krotności **n-do-n** wymagają utworzenia dodatkowej relacji.
Relacja ta zawiera wszystkie atrybuty kluczowe relacji, odpowiadających
zbiorom encji uczestniczącym w związku. Zatem posiada ona dwa klucze obce
odwołujące się do relacji odpowiadających zbiorom encji uczestniczącym w związku. Atrybuty wchodzące w skład tych kluczy obcych stanowią klucz główny tej dodatkowej relacji.
<br/>
![](/images/rdb/n_to_n.png)
<br/>
\*Aktorzy (*Imię*, *Nazwisko*), Filmy (*Tytuł*, *Rok*)<br/>
Aktorzy\_Filmy (*Imię\_aktora*, *Nazwisko\_aktora*, *Tytuł\_Filmu*, *Rok\_Filmu*)<br/>
FK (Imię\_aktora, Nazwisko\_aktora):Aktorzy<br/>
FK (Tytuł\_Filmy,Rok\_Filmu):Filmy\*.

Nazwa nowej relacji może być taka sama jak nazwa związku. Częściej jednak stosuje
się nazwy typu **Aktorzy\_Filmy**, **Aktorzy\_do\_Filmy**, etc.

Jeśli związek posiada atrybuty, to są one umieszczane obok atrybutów kluczowych
relacji, odpowiadających zbiorom encji uczestniczącym w związku.

#### Związki rekurencyjne

W przypadku związków rekurencyjnych stosowane są te same zasady co w
przypadku pozostałych typów związków, z zastrzeżeniem, że nazwy atrybutów
kluczowych odpowiadają rolom encji uczestniczących w związku:<br/>
![](/images/rdb/node.png)
<br/>
\*Węzły (*Id*, Wartość, Rodzic\_Id)<br/>
FK (Rodzic\_Id):Węzły\*

### Relacja isa

Relacja **isa** może być przekształcana na trzy sposoby:

-   **pełna relacja dla każdego zbioru encji**
-   **niepełna relacja dla każdego zbioru encji**
-   **jedna relacja dla wszystkich zbiorów encji**

![](/images/rdb/isa.png)

#### Pełna relacja dla każdego zbioru encji

Każdy zbiór encji, który uczestniczy w relacji **isa**, posiada własną
relację, która zawiera **wszystkie atrybuty** zarówno bardziej ogólnego, jak i
bardziej specyficznego zbioru encji:

-   **Ciała niebieskie (*Nazwa*, Promień, Temperatura, Masa)**
-   **Księżyce (*Nazwa*, Promień, Temperatura, Masa, Promień orbity, Planeta nazwa)**
-   **Planety (*Nazwa*, Promień, Temperatura, Masa, Jasność, Promień orbity, Gwiazda nazwa)**
-   **Gwiazdy (*Nazwa*, Promień, Temperatura, Masa, Jasność)**

#### Niepełna relacja dla każdego zbioru encji

Każdy zbiór encji, który uczestniczy w relacji **isa**, posiada własną relację,
która oprócz atrybutów specyficznych dla danego zbioru encji, posiada atrybuty
kluczowe zbioru bardziej ogólnego:

-   **Ciała niebieskie (*Nazwa*, Promień, Temperatura, Masa)**
-   **Księżyce (*Nazwa*, Promień orbity, Planeta nazwa)**
-   **Planety (*Nazwa*, Promień orbity, Jasność, Gwiazda nazwa)**
-   **Gwiazdy (*Nazwa*, Jasność)**

#### Jedna relacja dla wszystkich zbiorów encji

Wszystkie zbiory encji uczestniczące w relacji **isa**, posiadają jedną tabelę, która
zwiera atrybuty będące sumą atrybutów wszystkich zbiorów encji oraz
jeden dodatkowy atrybut, np. typu *string* o nazwie *typ*, zawierający
nazwę zbioru encji. Ten dodatkowy atrybut pozwala odróżnić encje, które
w modelu konceptualnym należały do różnych zbiorów, a w modelu relacyjnym
należą do tej samej relacji. Jeśli dwa
zbiory encji posiadają atrybuty o tej samej nazwie, lecz o różnych domenach,
to nazwa jednego z tych atrybutów musi zostać zmieniona:

-   **Ciała niebieskie (*Nazwa*, Promień, Temperatura, Masa, Promień orbity, Jasność, Typ, Planeta nazwa, Gwiazda nazwa)**
