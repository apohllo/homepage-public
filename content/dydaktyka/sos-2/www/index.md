---
title: Serwer WWW
date: '2010-03-09T04:55:00Z'
lastmod: '2014-05-19T11:29:28Z'
draft: false
tags:
- apache
- nginx
author: 94.254.198.104
---

Laboratorium dotyczy instalacji i konfiguracji serwera WWW.

Prerekwizyty
------------

-   migawka z zainstalowanym Gitem
-   zazpoznanie z dokumentacją Apache:
    -   [Uwierzytelnianie](http://httpd.apache.org/docs/2.2/howto/auth.html)
    -   [Dyrektywa DocumentRoot](http://httpd.apache.org/docs/2.2/mod/core.html#documentroot)
    -   [Dyrektywa UserDir](http://httpd.apache.org/docs/2.2/mod/mod_userdir.html#userdir)
    -   [Dyrektywa Directory](http://httpd.apache.org/docs/2.2/mod/core.html#directory)
    -   [Dyrektywy Allow](http://httpd.apache.org/docs/2.2/mod/mod_authz_host.html#allow) oraz [Deny](http://httpd.apache.org/docs/2.2/mod/mod_authz_host.html#deny)
    -   [Pliki .htaccess](http://httpd.apache.org/docs/2.2/howto/htaccess.html)
-   [Ubuntu - podręcznik instalacji Apache2](https://help.ubuntu.com/12.04/serverguide/httpd.html)
-   polecenia: [ln](http://manpages.ubuntu.com/manpages/precise/en/man1/ln.1.html), [service](http://manpages.ubuntu.com/manpages/precise/en/man8/service.8.html), [a2enmod](manpages.ubuntu.com/manpages/precise/en/man8/a2enmod.8.html), [htpasswd](http://manpages.ubuntu.com/manpages/precise/en/man1/htpasswd.1.html)
-   znajomość pojęć: World Wide Web, Hypertext Markup Language, Protokół HTTP (struktura żądania, struktura odpowiedzi, nagłówki HTTP, kody stanu,
    czasowniki HTTP), Adres URL (protokół, adres, port, ścieżka, zapytanie, fragment), adres IP, port, DNS i nazwy domenowe, serwer WWW,
    serwer wirtualny, moduł Apache’a, plik .htaccess

Konfiguracja Apache w Ubuntu
----------------------------

-   pliki konfiguracyjne Apache znajdują się w katalogu `/etc/apache2/`
-   konfiguracja modułów znajduje sie w katalogu `/etc/apache2/mods-available`
-   uruchomienie modułu odbywa się poprzez stworzenie odwołania symbolicznego w katalogu `/etc/apache2/mods-enabled` albo za pomocą polecenia `a2enmod` i restart serwera
-   logi błędów znajdują się w katalogu `/var/log/apache2/`

Zadania do wykonania
--------------------

-   zalogowanie się na maszynę wirtualną w oknie terminala maszyny fizycznej
-   **instalacja serwera WWW** [Apache](http://httpd.apache.org/)
-   **modyfikacja komunikatu** pojawiającego się pod domyślnym adresem (http://virtual.host.ip) -
    "Witaj na stronie EPI - serwer skonfigurowł(a) &lt;imię i nazwisko&gt;"
-   dodanie obsługi **katalogów użytkownika** (http://virtual.host.ip/~nazwisko)
-   **utworzenie repozytorium** git na Wierzbie, zawierającego projekt z przedmiotu "Statyczny dokument hipertekstowy"
-   **sklonowanie** projektu z Wierzby na maszynę wirtualną
-   umieszczenie projektu w katalogu **public\_html**
-   **udostępnienie projektu** poprzez serwer WWW
-   **zabezpieczenie katalogu** użytkownika przed niepowołanym dostępem z wykorzystaniem prostej autoryzacji (HTTP Basic Authorization). Login: student, hasło: password.
-   **całkowite zablokowanie dostępu** do katalogu .git

Warunki powodzenia
------------------

-   po restarcie komputera, bezpośrednio po uruchomieniu przeglądarki pod adresem maszyny wirtualnej pojawia się komunikat "Witaj na stronie EPI..."
-   poprawne wyświetlanie polskich znaków w powyższym komunikacie (bez jakichkolwiek zmian w konfiguracji przeglądarki internetowej)
-   jw. ale w katalogu użytkownika (http://virtual.host.ip/~student) można wyświetlić projekt z przedmiotu "Statyczny dokument hipertekstowy" - tylko po zalogowaniu
-   w katalogu użytkownika (tzn. http://virtual.host.ip/~student) nie może być dostępny plik z hasłem pozwalającym na zalogowanie się
-   historia zmian w repozytorium git wskazująca na to, że projekt został sklonowany z Wierzby
-   niemożność wyświetlenia katalogu .git w katalogu użytkownika zarówno przed, jak i po zalogowaniu z wykorzystaniem protokołu Basic Authorization

Wyświetlanie polskich znaków w konsoli
--------------------------------------

`sudo dpkg-reconfigure console-setup`

-   Kodowanie używane w konsoli: **UTF-8**
-   Zestaw znaków: **Złożony - łaciński, cyrylica słowiańska, grecki**
-   Czcionka dla konsoli: **Fixed (domyślnie)**
-   Wielkość czcionki: **16 (domyślnie)**
