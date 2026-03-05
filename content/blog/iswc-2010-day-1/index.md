---
title: ISWC 2010 dzień 1
date: '2010-11-19T11:37:00Z'
lastmod: '2010-11-19T11:45:13Z'
draft: false
tags:
- semantic web
- iswc
author: 91.150.223.28
---

### mc shraefel - invited talk

Nie wiem dokładnie o co chodzi z imieniem i nazwiskiem Pani "mc shraefel", ale wszędzie pojawia się ono z małej liter, więc pozostaję przy tej konwencji.

Prezentacja zaczęła się w nieoczekiwany sposób, gdyż uczestnicy musieli wstać, machać rękami i bujać się na biodrach.
Wśród niektórych wywołało to małą konsternację, ale niewątpliwie wszyscy się obudzili, a niektórzy przynajmniej na
chwilę odłożyli swoje komputery.

W zasadzie cała prezentacja mc, koncentrowała się na zagadnieniach *usability* technologii semantycznych.
Podstawowa jej obserwacja, która chyba wywołała najwięcej niezadowolenia audytorium, dotyczyła faktu,
że właściwie każda z prezentowanych jej aplikacji opartych o Semantic web, dla przeciętnego użytkownika Internetu
w zasadzie była niezrozumiała. Trudno nie zgodzić się jednak z tą obserwacją, jeśli widzi się, że kolejne
aplikacje pokazują dane RDF w coraz to nowych konfiguracjach, z coraz to nowymi ikonkami, ale nic sensownego
z tego nie wynika. Oczywiście jest to zgrubna ocena, ale też ważny sygnał dla firm, które chciałyby komercjalizować
tego typu technologie. Oczekiwanie, że użytkownik oglądając jakąś dziwną tabelkę z dziwnymi napisami
będzie zachwycony jest mało realne.

Oczywiście jako przeciwwaga pokazany został interfejs projektu, nad którym pracuje mc.
Zasadniczo w ogóle nie było wiadomo,
że jest to aplikacja Semantic Web - interfejs był tekstowy. Użytkownik mógł wprowadzać zapytania w języku
zbliżony do naturalnego, no i na tym cała rzecz się opierała (coś podobnego do firefoxowego Ubiquity).

Konkluzją prezentacji było stwierdzenie - niech tematem kolejnej ISWC będą zwykli użytkownicy i ich potrzeby,
a nie kolejne dyskusje nad przewagą OWL-a nad RDFS i vise-versa.

### Doctoral consortium i NLP

Po prezentacji mc shraefel przeniosłem się do sali, w której prezentacje mieli studenci. Przyznam szczerze,
że prezentacje mnie nie powaliły. Generalnie większość z nich miała podobny problem - chcieli poruszyć
zbyt wiele tematów w jednej pracy. Co więcej, choć ambicje prezentujących były duże, to prezentacje
wycinkowe i zazwyczaj koncentrowały się na zagadnieniach już dość dobrze zbadanych (np. ekstrakcja relacji
taksonomicznych z Wikipedii). Dlatego szybko przeniosłem się na prezentację [Supporting Natural Language Processing with Background Knowledge: Coreference Resolution Case](http://iswc2010.semanticweb.org/accepted-papers/234).

W prezentowanym artykule autorzy pokazują, jak można wykorzystać statystyczne algorytmy w połączeniu z wiedzą
dostępną w Semantic Web, aby ulepszyć wyniki uzyskiwane dla różnych zadań z dziedziny ekstrakcji informacji,
w tym wypadku w zadaniu rozpoznawaniu koreferencji między dokumentami. Autorzy proponują, aby użyć
Wikipedii jako punktu odniesienia dla innych źródeł wiedzy. Niewątpliwie nie jest to zaskakujące rozwiązanie.
Duża część artykułu poświęcona jest zagadnieniu wyboru tych relacji, spośród wielu występujących w
źródłach Semantic Web, które istotne są z punktu widzenia skuteczności algorytmu. Wiadomo bowiem, że dane
dostępne jako Linked Data nie są zbalansowane i nierzadko dla określonych zasobów (np. Obamy) istnieją setki faktów,
a dla innych zaledwie kilka. Prezentacja niewątpliwie ciekawa, ale w moim przekonaniu zastanawiające jest
użycie statystycznych metod do określenia istotnych cech zasobów, zamiast wykorzystanie jawnej reprezentacji,
która jest jedną z podstawowych zalet zasobów udostępnianych w jako Linked Data.

Z pozostałych prezentacji, które obejrzałem tego dnia, chyba żadna nie zapadła mi specjalnie w pamięć. Były to m.in.
dyskusja panelowa nad formatem RIF, "I18n of Semantic Web Applications",
"Mapping Master: a Flexible Approach for Mapping Spreadsheets to OWL" oraz
"ISReal: An Open Platform for Semantic-Based 3D Simulations in the 3D Internet".\\

Tego dnia pokazywałem również swoje demo, w którym dla danych udostępnianych jako Linked Data,
tworzone były polskie opisy. Niestety ze względu na tymczasową niedostępność serwisu MusicBrainz, demo
nie działało :( No cóż - taka natura Semantic Web. Ale przynajmniej mogłem sobie porozmawiać z kilkoma osobami,
które udawały, że chcą się nauczyć języka polskiego (ponieważ nie miałem plakatu, zamieściłem tylko krótką
notkę, że można nauczyć się naszego języka ;) ). Kilka dyskusji było niewątpliwie ciekawych, ale ich
konkluzje pozostawiam dla siebie.
