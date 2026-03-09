---
title: Wierzba - konfiguracja
date: '2010-03-03T07:19:00Z'
lastmod: '2013-01-04T18:22:31Z'
draft: false
tags:
- rails
- wierzba
author: 31.175.21.116
---

#### Wersja Railsów

TE INFORMACJE NIE SĄ AKTUALNE!

Na serwerze **`wierzba.wzks.uj.edu.pl`** zainstalowane są Railsy w wersji **`2.3.5`**.

Na specjalne życzenie mogą być zainstalowane Railsy w innej wersji, ale zdecydowanie zalecane jest używanie wersji `2.3.5`.
Aby zmienić używaną wersję Railsów w aplikacji, należy w pliku **`config/environment.rb`** odnaleźć fragment:

code(ruby).
RAILS\_GEM\_VERSION = '2.3.5' unless defined? RAILS\_GEM\_VERSION

i zamienić faktyczną wartość **`RAILS_GEM_VERSION`**, na tę przedstawioną powyżej.

#### Gemy

Na serwerze zainstalowanych jest całkiem sporo gemów:

-   rak - przeglądanie plików w poszukiwaniu łańcucha znaków
-   RubyInline - biblioteka pozwalająca na łatwe dodawanie kodu w C do programów w Rubim
-   unicode - wsparcie Unicode dla Rubiego w wersji 1.8
-   wirble - kolorwane irb z wsparciem dla historii
-   cucumber - platforma BDD
-   ferret - wyszukiwanie pełnotekstowe
-   sphinx - jw.
-   image\_science - biblioteka do zmiany rozmiaru plików graficznych
-   rmagick - inna biblioteka, j.w.
-   ruby-openid - OpenID dla Rubiego
-   will\_paginate - paginacja w Railsach
-   mysql - bindingi dla MySQL
-   sqlite3 - binding dla sqlite3
-   ruby-debug-ide - debuggin w RadRails?
-   authlogic - logowanie w Rails
-   paperclip - załączniki

Jeśli jednak potrzebny jest inny plugin, to proszę o kontakt mejlowy, a z dużym prawdopodobieństwem zostanie zainstalowany.

#### Passenger

Aplikacje są serwowane za pomocą modułu Apache o nazwie Passenger. Dzięki temu w docelowej konfiguracji aplikacja
działa na porcie 80 (domyślny port HTTP). Aby jednak aplikacja działała poprawnie muszą być spełnione
następujące warunki:

-   aplikacja musi znajdować się w katalogu domowym użytkownika (a nie w którymś z podkatalogów, w szczególności **nie** w public\_html)
-   aplikacja działa w trybie produkcyjny, dlatego w szczególności musi mieć skonfigurowaną bazę danych dla tego trybu (można wykorzystać tę samą konfigurację co dla tryby developerskiego)
-   administrator (czyli ja :) musi być poinformowany o loginie użytkownika i katalogu, w którym znajduje się aplikacja (np. user1 rails\_projekt) - dopiero wtedy aplikacja zacznie działać pod adresem podanym niżej.

Tak skonfigurowana aplikacja dostępna jest pod adresem:

**`wierzba.wzks.uj.edu.pl/uzytkownik/katalog`**

(Proszę zwrócić uwagę na brak tyldy)

Dodatkowo, zmiany w plikach aplikacji widoczne są tylko po jej zrestartowaniu, które wykonuje się poprzez utworzenie pliku **`restart.txt`** w katalogu
**`tmp`** aplikacji, najprościej za pomocą komendy:

code(bash).
$ touch tmp/restart.txt

która wykonywana jest w głównym katalogu aplikacji (czyli w powyższym przypadku w ~/rails\_projekt).

#### Google Maps

W wersji produkcyjnej będziemy korzystać z jednego klucza do API Google Maps dla adresu **`wierzba.wzks.uj.edu.pl`**

Jeśli ktoś korzysta z API Google Maps, to proszę o kontakt mejlowy.
