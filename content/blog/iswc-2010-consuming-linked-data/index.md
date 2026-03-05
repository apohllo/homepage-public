---
title: ISWC 2010 COLD
date: '2010-11-08T01:21:00Z'
lastmod: '2010-11-19T08:58:07Z'
draft: false
tags:
- semantic web
- iswc
author: 91.150.223.28
---

Ciekawsze prezentacje z warsztatów [COLD](http://people.csail.mit.edu/pcm/tempISWC/workshops/COLD2010/index.html) w ramach konferencji [International Semantic Web Conference 2010](http://iswc2010.semanticweb.org)

### [Capturing Emerging Relations between Schema Ontologies on the Web of Data](http://people.csail.mit.edu/pcm/tempISWC/workshops/COLD2010/NikolovEtAl_COLD2010.pdf)

Autorzy pokazują jak można ustalać relację ekwiwalencji pomiędzy klasami wykorzystywanymi w [Linked Data](http://linkeddata.org). Zasadnicza idea opiera się na wykorzystaniu relacji "sameas" na poziomie instancji.
Okazuje się, że proste drzewo decyzyjne pozwala uzyskać precyzję na poziomie przekraczającym 90%.
Problem, który utrudnia wykorzystanie rezultatów tego rodzaju, jest m.in. zmienność schematów konceptualnych
używanych w różnych bazach wiedzy. Ponadto operowanie na poziomie instancji dużych zbiorów danych jest bardzo
czasochłonne.

### [The R2R Framework: Publishing and Discovering Mappings on the Web](http://people.csail.mit.edu/pcm/tempISWC/workshops/COLD2010/BizerEtAl_COLD2010.pdf)

Autorzy przedstawiają metodykę oraz język, który mają pomóc w rozwiązaniu jednego z podstawowych problemów Semantic
Web, tzn. występowania wielu niezależnych taksonomii. Podstawowa idea polega umożliwieniu publikowania
oraz odnajdywania mapowań pomiędzy różnymi schematami konceptualnymi.

Autorzy wymieniają następujące problemy, który pojawiają się, kiedy używamy różnych schematów konceptualnych,
a nawet tych samych schematów konceptualnych w różnych źródłach danych:

-   odmienne klas używane do wyrażenia tych samych pojęć
-   odmienne własności (tutaj istotny problem polega również na dopasowaniu pozycji argumentów)
-   używanie odmiennych jednostek w różnych DS korzystających z tej samej ontologii
-   modyfikacje typu danych ~~&gt; int~~ float
-   używanie odmiennych etykiet (A. Einstein vs. Albert Einstein)

Autorzy proponują nowy język R2R zbudowany na podstawie SPARQL, który pozwalałby na opisywanie przekształceń,
które muszą być dokonane aby dopasować do siebie różne źródła danych, ponieważ dotychczasowe rozwiązania
zdefiniowane w OWL i SKOS są niewystarczające do rozwiązania wszystkich wyżej przedstawionych problemów.

Propozycja polega na dodanie rozbudowanych szablonów mapowania, które uwzględniają wszystkie wyżej wymienione problemy. Ponadto zaproponowane rozwiązanie umożliwia tworzenie łańcuchów przetwarzania (tzn. mapowania
poprzez schematy pośrednie) oraz uwzględnia meta dane na temat twórcy mapowania, jego jakości, etc.

Rozwiązanie wydaje się jednak dosyć nietrafione - istnieje wiele formalnych
rozwiązań, które adresują powyższe problemy. Zdecydowanie lepiej byłoby
objąć w rozwiązaniu tylko te elementy, które nie dają się załatwić na
poziomie deklaratywnym. W szczególności odnosi się to do dopasowania klas,
własności oraz jednostek (w końcu można wprost opisać jednostki, które
używane są w określonym DS, albo wymusić używanie określonych jednostek w
samej ontologii). W szczególności rezygnacja z wykorzystania predykatów sameAs, equivalentClass,
equivalentProperty wydaje się najgorszym pomysłem.

Wydaje się natomiast, że niektóre aspekty
są zupełnie pomijalne - np. etykieta A. Einstein vs Albert Einstein. Jeśli tylko będzie ustalona relacja
sameAs pomiędzy odpowiednimi zasobami, takie różnice będą zupełnie nieistotne (jest to jedna z podstawowych
idei leżących u podstaw Semantic Web - tzn. reidentyfikacja przez URL a nie te lub inne własności).

PS. Autorzy są twórcami DBpedii. Rozmawiałem z autorem prezentacji i wyjaśnił, że predykaty sameAs, etc. będą wykorzystywane przez prezentowane narzędzie, ale po co zatem dodawać nowe rozwiązanie służące do tego samego?

### [Consuming multiple linked data sources: Challenges and Experiences](http://people.csail.mit.edu/pcm/tempISWC/workshops/COLD2010/MillardEtAl_COLD2010.pdf)

Zasadniczy problem poruszany w artykule dotyczy efektywnego wykonywania zapytań w języku SPARQL obejmujących
wiele zbiorów danych. Autorzy zwracają uwagę na dwa aspekty zagadnienia:

-   uwzględnieniu wielu URL-i wskazujących ten sam obiekt w różnych zbiorach danych
-   efektywne przetwarzanie zapytań, dla których dane znajdują się w odrębnych zbiorach

Dotychczasowe podejście do problemu przedstawione jest na przykładzie dwóch wcześniejszych rozwiązań:

-   Semantic Web Client Library - w celu wykonania zapytania obejmującego wiele zbiorów danych, dane są wcześniej cache'owane lokalnie i zapytanie realizowane jest na ich kopii. Problemem jest to, że często pobierane są znaczne ilości informacji nie istotne do realizacji zapytania.
-   DARQ - prezentuje podejście dokładnie przeciwne dl SWCL, wszystkie zapytania realizowane są w oparciu od zdalne SPAQRL end-pointy (co wyklucza wykorzystanie danych nie posiadających takiego end-pointu). Zasadniczymi wadami tego podejścia są: mała wydajność oraz konieczność dostarczenia danych statystycznych na temat zawartości określonego źródła danych w celu optymalizacji zapytani.

Propozycja przedstawiona przez autorów opiera się na doświadczeniu zdobytym z narzędziem [RKBExplorer](http://www.rkbexplorer.com). Służy ono
do dostarczania informacji na temat *społeczności praktyków* pracujących nad jakimś zagadnieniem naukowym.
W szczególności narzędzie to powinno dostarczać informacje na temat osób, ich publikacji, tematów badań itp.
Zaproponowane rozwiązanie sprowadza się do dostarczenie specyficznych połączeń zapytań, które mają być wykonywane na wielu zbiorach danych. W szczególności chodzi o to, by fragmenty zapytania mogły być wykonywane wewnątrz jednego
zbioru danych, natomiast całość może obejmować wiele zbiorów. Choć rozwiązanie to posiada istotne ograniczenia,
dla zadania, w którym było wykorzystywane uzyskana wydajność była zadowalająca. Co więcej zbiory danych różnego typu
(surowe dane RDF oraz dane dostępne za pomocą języka SPARQL) są obsługiwane w tym rozwiązaniu.

### IBM Jeopardy! Challenge

Zdecydowanie najciekawsza prezentacja z tych warsztatów - przedstawiciel IBM-a - Chris Welty przedstawił
projekt o rozmachu podobny do Deep Blue. Duży zespół naukowców z IBM Research pracuje nad systemem
odpowiadającym na pytania, który mógłby konkurować z ludźmi w grze podobnej do naszego "Va Banque"
(w istocie rzeczy Va Banque był realizowany na licencji Jeopardy).
Cały problem polega na tym, że osoby wygrywające ten teleturniej zazwyczaj odpowiadają w ciągu kilku
sekund, i w przeważającej liczbie przypadków nie mylą się. Dodatkowym utrudnieniem jest fakt, że pytanie
zadawane jest nie wprost.

Zatem system, który mógłby konkurować z ludźmi musiałby poprawnie analizować zdanie, posiadać olbrzymią
wiedzę faktograficzną oraz określać właściwą odpowiedź w czasie kilku sekund. Niestety w gruncie rzeczy
uczestnicy konferencji nie dowiedzieli się zbyt wiele, poza ogólnikowymi stwierdzeniami, że kluczową własnością
systemu, jest zdolność do prawidłowej oceny odpowiedzi. Padło też dosyć enigmatyczne stwierdzenie, że
w systemie tego rodzaju niezbyt istotna jest wiedza "zdroworozsądkowa", której tak wiele uwagi poświęcają
twórcy ontologii, ale wiedza faktograficzna. Z pytania, które zadałem Weltyemu wynikało jednak, że chodzi tutaj
przede wszystkim o odpowiednie określenie kategorii semantycznej obiektu podlegającego ocenie. Niewątpliwie
jest to wiedza faktograficzna, ale z drugiej strony wątpię, by można obyć się bez pewnych inferencji realizowanych
na jej podstawie.

Dosyć zabawne było również rozwiązanie problemu ograniczeń czasowych - system generuje bowiem tysiące
hipotetycznych odpowiedzi i każda z nich analizowana jest na odrębnej maszynie. Zatem system działa w oparciu
o wielotysięczny klaster komputerów. A nad samym systemem pracuje kilkudziesięcioosobowa grupa naukowców
z IBMa. Nie dowiedzieliśmy się również, jaka jest jego obecna skuteczność, choć przez przypadek pojawił się taki
slajd (którego miało nie być... :\] )

W każdym razie system wzbudził duże zainteresowanie i niewątpliwie można się spodziewać, że niedługo zostanie
pokazany całemu światu, jako kolejne wielkie dzieło IBMa.
