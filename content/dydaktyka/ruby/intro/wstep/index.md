---
title: Wstęp
date: '2007-08-14T18:04:00Z'
lastmod: '2008-02-14T22:09:01Z'
draft: false
tags:
- ruby
author: 83.175.191.74
toc: true
---

[Następny rozdział](/dydaktyka/ruby/intro/do-dziela)

Dlaczego Ruby?
==============

Zwykle, kiedy poznaję nowy język programowania lub technologię informatyczną, ogarniają
mnie ambiwalentne uczucia - z jednej strony przychodzi ekscytacja, związana
z tym co nowe, fascynujące, zachwalane, etc. Z drugiej jednak strony - zastanawiam się,
czy poznawanie jej w ogóle ma jakiś sens. Przecież znam już chyba z tuzin języków
programowania, kilka niezłych frameworków i innych przydatnych narzędzi. Czasem
wydaje mi się, że czas włożony w poznawanie nowej technologii, mógłbym przeznaczyć
na realizację projektów, które nieustannie odkładane są "na jutro".

### Java i C

Podobnie sprawa wyglądała z Ruby - słyszałem, że to wspaniały język, ale zwlekałem
z decyzją bliższego zapoznani się z nim. Miałem też w pamięci słowa B. Eckela, który
chyba 1. wydanie "Thinking in Java" zadedykował osobom tworzącym "nowe wspaniałe języki".
Oczywiści wydawało mu się wtedy, że Java jest najpiękniejszym językiem, jaki stworzyli
programiści, aby deliberować ze swoimi ukochanymi maszynami (wirtualnymi).

Sam przez długi czas również uważałem Javę, za coś pięknego (a "Czyż istnieje jakieś
inne usprawiedliwienie istnienia niż piękno?" pyta Nietzsche). W szczególności po wielu
nieprzespanych nocach spędzonych za pan brat z `gdb` przestałem wierzyć, że programowanie
w C czy C++ może być czymś przyjemnym. Java oferowała nową jakość - miast koncentrować się
na walce z kompilatorem, pustymi wskaźnikami i niezwolnionymi zasobami, mogłem po prostu
tworzyć oprogramowanie. To co sprawiało mi w C sporo problemów - np. znajdowanie
błędów wynikających z niezainicjowanych zmiennych, w Javie jest wychwytywane już na etapie
kompilacji (a właściwie tworzenia kodu, jeśli posiadamy jakiś sensowny edytor).

Kiedy jednak bliżej poznałem Javę, zrozumiałem, że i ten język programowania posiada
swoje wady. W szczególności - kiedy przychodzi nam do pisania poważniejszych aplikacji,
w których wykorzystywane jest wiele zewnętrznych bibliotek, pojawiają się problemy,
które również nie pozwalają się skoncentrować na tym co naprawdę istotne. Nie są to problemy
z kompilatorem, bynajmniej. Ktokolwiek jednak pisał w Javie aplikację z wykorzystaniem
np. Hibernate, doskonale zdaje sobie sprawę, że można spędzić nieraz kilka, czy kilkanaście
godzin poszukujące tej jednej opcji, która powinna była zostać włączona w jakimś XML-owym pliku,
aby transakcje zaczęły działać poprawnie. Nic bardziej nie denerwuje niż rodzące się w
głowie informatyka pytanie: "Dlaczego używam tej bezsensownej technologii?"
(nie wspominając już o WTF :)

### Perl

Moja przygoda z Javą miała więc również swoje ciemne strony. Tym niemniej pewnie nie poznałbym
Ruby, gdyby nie fakt, że, jak większość młodych adeptów programowania, miałem w swoim życiu
do czynienia ze dynamicznymi stronami internetowymi, do których tworzenia najczęściej
wykorzystuje się języki skryptowe. Zacząłem od Perla i przez pewien czas wydawało mi się,
że Perl jest wspaniałym narzędziem. Jeśli weźmiemy pod uwagę tylko to, jak zręcznie można manipulować
łańcuchami znaków w tym języku, to trudno znaleźć dla niego dobrego konkurenta. Niestety -
stworzenie nawet prostego serwisu internetowego, to nie tylko manipulowanie łańcuchami.
To także wywoływanie funkcji! Niestety w tym języku argumenty funkcji nie posiadają nazw.
I choć napisałem kilka przydanych skryptów w Perlu, to raczej do niego nie wrócę -
składnia języka wręcz zachęca do pisania koszmarnego kodu. A kod nie tylko się pisze,
ale również czyta.

### PHP

Alternatywą dla Perla było oczywiście PHP. Poznałem "pehapa" w wersji 4, która posiadała jakieś
wsparcie dla obiektowości (w Perlu obiektowość była jeszcze bardziej enigmatyczna, niż jego
krzaczastość), a jak wszyscy dobrze wiemy - jest ona podstawą dobrego samopoczucia każdego
programisty (to właśnie znacznie prostszy niż w C++ model obiektowości tak bardzo na
początku spodobał mi się w Javie). Niestety moja pierwsza przygoda z PHP była jak skok na głęboką
wodę - musiałem napisać system CMS nie mając wielkiego pojęcia ani o CMS-ach, anie o PHP :)
I choć na początku starałem się tworzyć jakiś sensowny model danych i wszystko ładnie ze
sobą powiązać, pod koniec kod przypominał niedojedzone spaghetti, które spędziło kilka słonecznych
dni na balkonie. HTML posiadał zagnieżdżone duże fragmenty kodu źródłowego, a kod źródłowy
posiadał fragmenty HTML-a. Najgorsze było to, że wszystko jeszcze musiało współpracować
z Fleshowymi animacjami. Do dzisiaj nawiedzają mnie koszmary związane z tym projektem.

Na "szczęście" po skończeniu projektu, poznałem gotowe systemy CMS napisane w PHP, które
miałem zamiar wykorzystać w kolejnych projektach. Mój wybór padł na Mambo, gdyż system
ten posiadał znakomite recenzje, a także całkiem sporą rzeszę użytkowników w Polsce.
Myślałem, że poznając jego tajniki, dowiem się jak tworzy się "prawdziwe" systemy CMS.
Niestety - rozczarowałem się. System ten już od strony użytkownika przytłacza swoim
skomplikowaniem. Oczywiście - wynika to z faktu, że można go adaptować dla rozmaitych
potrzeb, że administrator, który nie musi być programistą, może w "niemal dowolny sposób"
zarządzać swoją witryną. Dla programisty nie jest to jednak najważniejsze - znacznie
istotniejszy jest sposób zorganizowania kodu oraz możliwość tworzenia rozszerzeń dla systemu.

W minimalnym przypadku system powinien dostarczać bogatego API do komunikacji z bazą danych
oraz pozwalającego na tworzenie w sposób programiastyczny (a nie HTML-owy) podstawowych
elementów strony takich jak tabele, formularze, etc. Niestety w żadnym z tych względów
Mambo mnie nie zadowoliło. Obsługa bazy danych była uproszczona w stopniu znikomym,
a model MVC realizowany był poprzez podzielenie kodu modułów na dwa pliki - jedngo
z tagami HTML, a drugiego z kodem źródłowym, bez żadnego wsparcia ze strony systemu.
Ponadto, szybko okazało się, że nie jest ono systemem elastycznym -
tworzenie dodatków jest oczywiście możliwe, ale ich integracja z resztą systemu jest
właściwie znikoma.

Kolejne projekty - kolejne nieprzespane noce. To co najbardziej denerwowało mnie
w php i opartym na nim Mambo, było przegrzebywanie się przez zupę z tagów HTML-a i kodu.
Słabe wsparcie dla obiektowości, to już zupełnie inna historia (nie wiem, jak sprawa
wygląda w PHP v.5, ale właściwie mnie to nie interesuje). Tak, czy owak - przygoda z PHP
wywołała we mnie wręcz awersję do systemów webowych. Właściwie przez jakiś czas nie chciałem
w ogóle o nich słyszeć.

### Ruby!

I tak rok temu, nieco przez przypadek, natknąłem się na stronę o [Ruby on Rails](http://www.rubyonrails.com)
i przyznać muszę, że moja fascynacja językiem Ruby oraz platformą Rails ciągle trwa!
Mogę powiedzieć z całą stanowczością \*Ruby to prawdziwe arcydzieło![](*
Ten język wprost zachwyca swoją estetyką. Jeśli mogę wskazać jakieś przyczyny tego stanu rzeczy,
to są chyba trzy:
# *Pełna obiektowość.* Naprawdę pełna obiektowość) Liczby są obiektami, a dopiero w drugiej kolejności liczbami!
Łańcuchy są obiektami, tablice są obiektami, hashe są obiektami, a nawet nil jest obiektem!
Wszystko (z wyjątkiem bloków, które jednak też można zamienić w obiekty) jest w Ruby obiektem!

1.  **Bloki**. Fragmenty kodu, które wyglądają prawie jak parametry funkcji. Dlaczego bloki są takie ważne?
    Pozwalają tworzyć niezwykle zwięzły kod, który jest jednak (a może dlatego) czytelny. Przykład:
    tablice posiadają metodę `detect`, która zwraca pierwszy element, dla którego blok zwrócił wartość
    true. Pomyśl jak zaimplementowałbyś taką metodę w Javie - za pomocą jakiejś pętli, przed którą
    musiałbyś zainicjować zmienną. Pętlę musiałbyś przerwać, etc. etc. W Ruby zajmuje to jedną linijkę! `valuable = my_array.detect{|elem| elem.value > 100000}`
2.  **Metaprogramowanie**. W największym skrócie można powiedzieć, że pozwala
    ono na dynamiczne modyfikowanie własności całych klas obiektów. Technika
    ta jest niezwykle przydatna przy tworzeniu prototypów, a także w programowaniu
    komponentowym.

Tych powodów jest z pewnością więcej, ale te trzy są dla mnie chyba najbardziej
istotne i pociągające.

### Ruby on Rails

Zanim przystąpimy do omawiania języka, wspomnę jeszcze kilka słów o platformie Rails, gdyż
sporo napisałem tutaj o Perlu, PHP, a dotyczy to również Javy. Otóż Railsy dysponują
wszystkimi tymi wspaniałymi elementami, które przydają się w systemach webowych. Ba!
Oferują znacznie więcej:

-   fantastyczne wsparcie dla modelu MVC
-   obiektową abstrakcję bazy danych
-   konfigurowalne URL-e
-   migracje schematu bazy danych
-   wsparcie dla Javascriptu w postaci zintegrowanej biblioteki Prototype
-   wsparcie dla AJAX-a
-   testy jednostkowe, funkcjonalne i integracyjne
-   generatory, pluginy i inne cuda wianki, które po prostu działają

Być może hasła te mówią niewiele - można pokusić się o stwierdzenie, że platforma ta
posiada funkcjonalność Hibernate (ActiveRecord), Smarty (ActionView),
GoogleWebToolkit (generowany JS) i JUnit (Runit) zrealizowaną w kilku komponentach harmonijnie ze sobą współpracujących.
Ale zamiast tyle pisać, najlepiej wskazać stronę [Ruby on Rails](http://www.rubyonrails.pl) i polecić
[filmik](http://media.rubyonrails.org/video/rails_take2_with_sound.mov),
w którym autor w 15 minut "od zera" tworzy prosty blog.
Ponieważ zbywa mu czasu, pisze dla niego również testy.

Warto wspomnieć również, że to właśnie dzięki Railsom Ruby cieszy się na świecie
tak wielkim zainteresowaniem.

Mam nadzieję, że moje zwierzenia przekonały Cię o tym, że warto
poznać język Ruby. Dlatego
najlepiej zrobisz jeśli [zainstalujesz Ruby](/dydaktyka/ruby/intro/do-dziela) na swojej platformie.

[Następny rozdział](/dydaktyka/ruby/intro/do-dziela)
