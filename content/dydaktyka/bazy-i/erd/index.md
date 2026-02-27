---
title: Diagramy ER
date: '2010-03-10T10:08:00Z'
lastmod: '2010-03-10T10:12:20Z'
draft: false
tags:
- db
- erd
author: 149.156.173.53
toc: true
---

**Diagramy ER = diagramy związków-encji = entity-relationship diagrams**

### Elementy podstawowe

Diagramy związków-encji pozwalają w sposób graficzny opisywać model konceptualny.
Do podstawowych elementów diagramów ER należą:

|![zbiór encji](/images/erd/entity.png "zbiór encji") |**zbiory encji** reprezentowane przez prostokąty, które w środku zawierają nazwę zbioru|
|![atrybut](/images/erd/attribute.png "atrybut") |**atrybuty** reprezentowane przez elipsy, które w środku zawierają nazwę atrybutu|
|![związek](/images/erd/relationship.png "związek") |**związki** reprezentowane przez równoległoboki, które w środku zawierają nazwę związku|

Zbiory encji opisywane są za pomocą atrybutów, które łączy się z nimi
za pomocą pojedynczej linii prostej:<br/>
![zbiór encji i atrybuty](/images/erd/entity_attribute.png "zbiór encji i atrybuty")

Uwaga: wewnątrz elipsy wprowadzana jest **nazwa atrybutu**, a nie jego **wartość**.
Zatem niepoprawnym atrybutem jest np. **~~czerwony~~**, gdyż jest to wartość atrybutu,
który powinien nazywać się **kolor**.

Związki zachodzące pomiędzy zbiorami encji przedstawia się w postaci równoległoboku,
z którego wychodzą linie proste do wszystkich zbiorów encji, należących do danego
związku:<br/>
![zbiory encji i związek](/images/erd/entity_relationship.png "zbiory encji i związek")

Związki zachodzące pomiędzy zbiorami encji mogą być więcej niż dwuargumentowe,
mogą również posiadać atrybuty:<br/>
![związek wieloargumentowy z atrybutem](/images/erd/multirelationship.png "związek wieloargumentowy z atrybutem")

Związki mogą zachodzić pomiędzy encjami należącymi do jednego zbioru. Taka
sytuacja wymaga jednak opisania ról w jakich występują poszczególne encje:<br/>
![związek z opisanymi rolami](/images/erd/roles.png "związek z opisanymi rolami")

### Krotność związków

Krotność związków zbiorów encji jest cechą, która opisuje *z iloma encjami*
należącymi do *jednego zbioru encji* może być połączona *jedna encja*
należąca do *drugiego zbioru encji*.

Jak wskazaliśmy wcześniej (w odniesieniu do obiektów i klas), istnieją trzy główne typy związków:

-   1 do 1
-   1 do n
-   n do n

Tym niemniej wykorzystując tylko te trzy typu, nie jesteśmy w stanie wystarczająco
precyzyjnie opisać przypadków z jakimi spotykamy się w rzeczywistości. Np. często zachodzi
potrzeba odróżnienia sytuacji, w której jedna encja jednego zbioru *może* być
związana z jedną encją drugiego zbioru, od sytuacji, w której relacja ta jest
obligatoryjna (tzn. jedna encja pierwszego zbioru *musi być* związana z jedna encją drugiego zbioru).

W literaturze poświęconej modelowaniu baz danych można spotkać się z symboliką,
która oparta jest na modelu, w którym rozróżnia się tylko trzy podstawowe przypadki.
Tym niemniej w praktyce wykorzystywane są notacje, które pozwalają precyzyjnie
opisywać te zależności. Niestety w odniesieniu do diagramów ERD [nie wypracowano
jednego standardu](http://www.smartdraw.com/tutorials/software/erd/erdcardinality.htm)
oznaczania krotności (jak ma to miejsce w przypadku standardu modelowania obiektowego [UML](http://www.uml.org)),
aczkolwiek najczęściej można spotkać się z następującą notacją (rozpowszechnioną
m.in. w dokumentacji Oracle):

-   ![Powiązanie jednokrotne, obowiązkowe](/images/erd/single_mandatory.png "Powiązanie jednokrotne, obowiązkowe") - powiązanie jednokrotne, obowiązkowe (tylko jeden)
-   ![Powiązanie jednokrotne, opcjonalne](/images/erd/single_optional.png "Powiązanie jednokrotne, opcjonalne") - powiązanie
    jednokrotne, opcjonalne (jeden lub zero)
-   ![Powiązanie wielokrotne, obowiązkowe](/images/erd/multi_mandatory.png "Powiązanie wielokrotne, obowiązkowe") - pozwiązanie
    wielokrotne, obowiązkowe (co najmniej jeden)
-   ![Powiązanie wielokrotne, opcjonalne](/images/erd/multi_optional.png "Powiązanie wielokrotne, opcjonalne") - powiązanie wielokrotne, opcjonalne (zero lub więcej)

Poniżej zaś przedstawiamy przykład, który dobrze ilustruje różne
kombinacje krotności:<br/>
![Różne przykłady krotności powiązań](/images/erd/cardinality.png "Różne przykłady krotności powiązań")

Uwaga: symbole krotności interpretowane są zawsze w ten sposób,
że *jedna encja* z jednego zbioru encji może być powiązana z taką liczbą
encji należących do *drugiego zbioru*, na jaką wskazuje symbol leżący
bezpośrednio przy *drugim zbiorze encji*.<br/>
W powyższym przykładzie - jeden organizm może posiadać jedne lub więcej organów,
natomiast jeden organ musi należeć do dokładnie jednego organizmu.

### Typy atrybutów

W modelu ER wyróżnić można trzy specjalne typy atrybutów:

-   kluczowe
-   pochodne
-   częściowe kluczowe

Jednym z ważniejszych etapów projektowania modelu konceptualnego, jest zidentyfikowanie
**atrybutów kluczowych**, które tworzą *klucz* encji.
*Atrybuty kluczowe* to atrybuty, które w sposób jednoznaczny
identyfikują encję, która je posiada. Znaczy to, że nie mogą występować dwie
encje, które posiadają taką samą wartość atrybutów kluczowych.

Klucz może być pojedynczym atrybutem lub zbiorem atrybutów. W drugim przypadku
wymóg jednoznaczności odnosi się do zbioru jako całości, a nie poszczególnych
atrybutów, tzn. wymóg jednoznaczności odnosi się do kombinacji wartości,
a nie każdej wartości z osobna. Np. klucze (1, 2) oraz (1, 3) będą identyfikowały
odmienne encje, pomimo tego, że wartość pierwszego atrybutu jest w obu przypadkach
taka sama.

Encja może posiadać wiele kluczy. W takiej sytuacji jeden z nich jest wyróżniony
i nazywa się go **kluczem głównym**. Pozostałe klucze, to **klucze alternatywne**.
Ponadto **każdy zbiór encji** musi posiadać **przynajmniej jeden klucz**.

*Atrybuty kluczowe* wyróżnia się poprzez podkreślenie ich nazwy:<br/>
![Atrybut kluczowy](/images/erd/key.png "Atrybut kluczowy")

Innym ważnym typem atrybutów, są **atrybuty pochodne**. Ten typ atrybutów
wykorzystywany jest do reprezentowania informacji, które zawsze mogą być
obliczone na podstawie danych zgromadzonych w bazie, ale zachodzi potrzeba
reprezentowanie ich w modelu. Przykładem atrybutu tego rodzaju może być
np. średnia ocena publikowanego materiału, wyliczana na podstawie głosów oddanych
przez czytelników.

Atrybuty pochodne reprezentowane są za pomocą owalu, którego
brzeg rysowany jest linią przerywaną:<br/>
![Atrybut pochodny](/images/erd/derived.png "Atrybut pochodny")

W diagramach ERD wykorzystuje się również **klucze częściowe**.
Klucze częściowe pełnią tę samą rolę, co zwykłe kluczowe, z tą różnicą, że
samodzielnie nie identyfikują encji. Partycypują w kluczach, które tworzone
są z atrybutów innych encji i występują wyłącznie w *słabych encjach*,
które zosały omówione w punkcie następnym.

Klucze częściowe wyróżniane są za pomocą podkreślenia linią przerywaną:<br/>
![Klucz częściowy](/images/erd/weak_key.png "Klucz częściowy")

### Słabe encje

**Słabe encje** to szczególny typ encji, których klucze składają się (przynajmniej
częściowo) z atrybutów kluczowych innych encji. Jeśli encja jest słaba,
to pomiędzy zbiorem encji, których klucze wykorzystywane są w jej kluczu, a
zbiorem do którego on należy, musi zachodzić związek, którego krotność po
stronie przeciwnej słabej encji, wynosi dokładnie jeden. W przeciwnym bowiem
razie, mogłaby wystąpić sytuacja, w której słaba encja nie posiadałaby jednoznacznego
identyfikatora.

**Słabe encje** reprezentowane są za pomocą prostokątów z podwójną ramką:<br/>
![Zbiór słabych encji](/images/erd/weak_entity.png "Zbiór słabych encji")

**Związki identyfikujące**, które wskazują zbiory encji, których klucze wykorzystywane
są przez zbiory słabych encji, reprezentowane są za pomocą podwójnego równoległoboku:<br/>
![Związek identyfikujący](/images/erd/weak_relationship.png "Związek identyfikujący")

Słabe encje wykorzystywane są zwykle wtedy, gdy mamy do czynienia z kompozycją
lub związkiem wiele do wiele przekształconym w zbiór encji, tzn. słabe
encje zawsze występują jako elementy pewnej struktury wyższego rzędu.

Jako przykład można podać zamówienie, które posiada swój unikalny identyfikator
oraz pozycje, których porządek jest ustalony przez użytkownika. Zamiast
przypisywać każdej pozycji odrębny identyfikator (klucz) i dodatkowo numer
porządkowy na zamówieniu, prościej jest opisać pozycję, za pomocą klucza
składającego się z identyfikatora zamówienia i numeru pozycji.

Sytuacja ta przedstawiona jest na poniższym diagramie: <br/>
![Przykład zbioru słabych encji](/images/erd/weak.png "Przykład zbioru słabych encji")

### Relacja "isa"

Relacja *isa* ("X is a Y"), występuje pomiędzy zbiorami encji, spośród
których jeden może być określony jako specjalizacja drugiego.
Tzn. każda encja należąca do pierwszego zbioru posiada
wszystkie cechy encji należących do zbioru drugiego,
ale ponadto posiada pewne cechy specyficzne.
Przez cechy rozumie się tutaj nie tylko atrybuty, ale również
wszystkie związki w jakie wchodzi dany zbiór encji.

Na diagramach ERD relacja *isa* oznaczana jest za pomocą trójkąta,
wewnątrz którego znajduje się napis [Isa]() <br/>
![Symbol relacji isa](/images/erd/isa_sym.png "Symbol relacji isa")

Relacja *isa* jest jedną z podstawowych relacji występujących pomiędzy
pojęciami. Typowy zwrot, który służy
do jej wyrażania, to "X jest rodzajem Y" lub "X jest Y", gdzie X i Y są
pewnymi pojęciami ogólnymi (np. *wilk jest zwierzęciem*,
*lazur jest rodzajem niebieskiego*, *van jest rodzajem samochodu*).

Klasyczna **definicja arystotelesowska** składała się z dwóch elementów:
*genus proximum* (rodzaj najbliższy) i *differentia specifica* (różnica gatunkowa).
Jest ona jednym z podstawowych sposobów definiowania słów, a w konsekwencji
organizowania wiedzy. Widać wyraźnie, że jest ona oparta o relację "isa" -
aby zdefiniować słowo należy wskazać inne, którego znaczenie jest bardziej
ogólne od słowa definiownego.

Poniżej przedstawiony jest **przykład** wykorzystujący relacji "isa".
Został w nim wyabstrahowany jeden zbiór encji: *ciała niebieskie*. Wszystkie ciała
niebieskie posiadają masę, temperaturę i promień (można przyjąć dla uproszczenia,
że zajmujemy się tylko ciałami kulistymi). Niektóre spośród nich
posiadają jednak cechy specyficzne - gwiazdom i planetom możemy przypisać
jasność, a planetom i księżycom - promień orbity, po której się poruszają.
Ponadto istotny jest również fakt, że księżyce krążą wokół planet,
a planety wokół gwiazd. Wszystkie te informacje zostały uwzględnione
na diagramie.

![Przykład relacji isa.](/images/erd/isa.png "Przykład relacji isa.")
