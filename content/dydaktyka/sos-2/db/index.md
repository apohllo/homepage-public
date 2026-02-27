---
title: Serwer baz danych
date: '2010-03-09T13:55:00Z'
lastmod: '2014-05-19T11:48:15Z'
draft: false
tags:
- mysql
author: 94.254.198.104
---

Laboratorium dotyczy konfiguracji bazy danych.

Prerekwizyty:

-   migawka z zainstalowanym serwerem WWW
-   zapoznanie z [dokumentacją bazy MySQL dla Ubuntu](https://help.ubuntu.com/12.04/serverguide/mysql.html)
-   znajomość pojęć: instancja bazy danych, system zarządzania bazą danych, schemat bazy danych, transakcja, SQL, relacyjne bazy danych,
    bazy NoSQL, wbudowane bazy danych (przykład SQLite), ACID, SQL injection, otwarte bazy danych (przykład MySQL),
    komercyjne bazy danych (przykład Oracle)

Zadania do wykonania

-   zmiana nazwy serwera z `localhost` na `virtual` (plik `/etc/conf.d/hostname`) (do usunięcia)
-   dodanie aliasu dla adresu IP `127.0.0.1` o nazwie `virtual` (plik `/etc/hosts`)
-   instalacja serwera baz dany [MySQL](http://www.mysql.com/)
-   skonfigurowanie serwera tak, aby dane były przechowywane w katalogu `/var/lib/mysql`
-   uruchomienie serwera
-   dodanie serwera jako usługi domyślnie aktywnej
-   zmiana hasła dla użytkownika uprzywilejowanego na "root"
-   utworzenie konta dla użytkownika "user1" z hasłem "user1"
-   utworzenie nowej bazy danych o nazwie "epi" z dostępem dla użytkownika "user1" (wszystkie prawa modyfikacji bazy)
-   usunięcie bazy test

Warunki powodzenia:

-   po restarcie systemu serwer bazodanowy działa
-   użytkownik "root" oraz "user1" nie mogą zalogować się bez podania hasła
-   logując się jako użytkownik "root" można utworzyć nową bazę danych
-   logując się jako użytkownik "user1" do bazy "epi" można utworzyć nową tabelę oraz można przeglądać zawartość tabeli
-   logując się jako użytkownik "user1" nie można tworzyć nowej bazy danych
