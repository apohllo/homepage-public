---
title: PHP
date: '2010-03-09T14:38:00Z'
lastmod: '2014-05-19T11:37:09Z'
draft: false
tags:
- php
author: 94.254.198.104
---

Laboratorium dotyczyły instalacji interpretera PHP i konfiguracji serwera WWW, tak by wspierał ten język.

Prerekwizyty:

-   migawka z zainstalowaną bazą danych
-   zapoznanie z [dokumentacją LAMP w Ubuntu](https://help.ubuntu.com/community/ApacheMySQLPHP)

Zadania do wykonania:

-   zainstalować interpreter PHP z wsparciem dla **Apache** oraz **MySQL**
-   skonfigurować serwer WWW, tak by pliki z rozszerzeniem .php były interpretowane jako programy PHP
-   ściągnąć forum dyskusyjne [phpBB](http://www.phpbb.pl/)
-   utworzyć nową bazę danych dla forum "phpbb" dla użytkownika "user1"
-   zainstalować forum w katalogu domowym użytkownika "user"
-   skonfigurować forum tak, by korzystało z utworzonej bazy
-   dodać/skonfigurować użytkownika uprzywilejowanego (admin, hasło: admin) i zwykłego (user, hasło: user) do forum
-   zmienić ustawienia formu tak, by posty domyślnie pojawiały się bez akceptacji administratora

Warunki powodzenia:

-   zalogować się pod adresem http://adres\_maszyny\_wirtualnej/~user/phpbb jako użytkownik uprzywilejowany i utworzyć nowe forum
-   zalogować się jako użytkownik zwykły i dodać nowego posta na forum
