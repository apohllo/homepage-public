---
title: Ruby on Rails
date: '2010-03-10T05:08:00Z'
lastmod: '2011-05-25T07:13:56Z'
draft: false
tags:
- ruby
- rails
- passenger
author: 149.156.172.11
---

Laboratorium dotyczy instalacji interpretera języka Ruby i konfiguracji serwera WWW, tak by
obsługiwał framework Ruby on Rails.

Prerekwizyty:

-   migawka z zainstalowaną bazą danych i Gitem

Zadania do wykonania:

-   zainstalować następujące pakiety w systemie Debian: `zlib1g-dev libssl-dev libreadline5-dev libxml2-dev libsqlite3-dev ruby rubygems`
-   zainstalować narzędzie [RVM](https://rvm.beginrescueend.com/) (Ruby version manager) tak aby było widoczne w całym systemie (dla każdego użytkownika)
-   korzystając z RVM zainstalować interpreter języka Ruby w wersji 1.9.2
-   ustawić Ruby 1.9.2 jako domyślny interpreter Rubiego dla całego systemu
-   zainstalować [Refinery CMS](http://refinerycms.com/) i utworzyć nowy projekt w katalogu użytkownika "user"
-   utworzyć bazę danych MySQL dla Refinery CMS: refinery\_development
-   skonfigurować Refinery CMS, tak by korzystało z utworzonej bazy (dla trybu developerskiego)
-   uruchomić aplikację na porcie 3000 korzystając z serwera WebRick
-   upewnić się, że aplikacja działa
-   wyłączyć serwer WebRick
-   zalogować się z maszyny hosta na maszynę wirtualną
-   zainstalować program `screen`
-   odpalić sesję programu `screen` a w niej odpalić serwer WebRick na porcie 3000
-   odłączyć się (detach) od sesji `screen`-a
-   wylogować się z maszyny wirtualnej

Warunek powodzenia:

-   w konsoli maszyny wirtualnej **nie jest uruchominy** serwer WebRick
-   po **wylogowaniu się** z maszyny wirtualnej pod adresem http://adres\_maszyny\_wirtualnej:3000/ dostępne jest Refinery CMS -
    można się zalogować jako "admin" i utworzyć nową podstronę

Wersja dla zaawansowanych (5 dodatkowych punktów):

-   zainstalować gem [passenger](http://www.modrails.com)
-   skonfigurować Passengera tak, by współpracował z zainstalowanym serwerem WWW
-   skonfigurować Passengera tak, by współpracował z RVM-em
-   utworzyć bazę danych refinery\_production
-   skonfigurować Refinery tak by w trybie produkcyjnym korzystało z bazy refinery\_production
-   skonfigurować Passengera tak, by obsługiwał Refinery CMS w trybie produkcyjnym zainstalowane w katalogu domowym użytkownika "user" pod adresem http://adres\_maszyny\_wirtualnej/refinery

Warunek powodzenia:

-   pod adresem http://adres\_maszyny\_wirualnej/refinery dostępne jest Refinery CMS w trybie produkcyjnym
