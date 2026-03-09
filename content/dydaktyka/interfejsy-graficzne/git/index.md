---
title: Przeniesienie aplikacji
date: '2012-01-04T11:18:00Z'
lastmod: '2013-12-04T20:58:14Z'
draft: false
tags:
- rails
- git
author: 149.156.173.34
---

Na komputerze lokalnym w katalogu `library`
-------------------------------------------

1. Inicjujemy repozytorium git:

```bash
$ git init
```

2. Dodajemy wszystkie pliki do indeksu:

```bash
$ git add .
```

3. Zatwierdzamy zmiany:

```bash
$ git commit -m "Import projektu"
```

4. Kopiujemy repozytorium na wierzbę, np.:

```bash
$ scp -r .git pohl@wierzba.wzks.uj.edu.pl:~/library.git
```

Na wierzbie w katalogu domowym
------------------------------

1. Modyfikujemy plik `library.git/config` zmieniając parametr `bare` na `true`.

2. Klonujemy repozytorium (należy uwzględnić prawidłową ścieżkę):

```bash
$ git clone file:///home/epi/pohl/library.git
```

3. Zmieniamy katalog na `library`

```bash
$ cd library
```

4. Ustwiamy zmienną `.rvmrc`:

```bash
$ echo 'rvm use 1.9.3' &gt;&gt; .rvmrc
$ echo 'rvm gemset use global' &gt;&gt; .rvmrc
```

5. Przechodzimy do aktualnego katalogu i akceptujemy zmiany (y):

```bash
$ cd .
```

6. Wywołujemy polecenie `bundle`:

```bash
$ bundle
```

7. Aktualizujemy schemat bazy danych:

```bash
$ rake db:migrate
```

8. Uruchamiamy serwer na odpowiednim porcie:

```bash
$ rails s -p 33xx
```

Dla komputerów:

-   poniżej 40: xx = numer komputera
-   od 40 wzwyż: xx = numer komputera - 40
