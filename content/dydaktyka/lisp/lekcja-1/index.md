---
title: Lekcja 1
date: '2010-11-27T10:14:00Z'
lastmod: '2010-11-27T10:38:05Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 2](/dydaktyka/lisp/lekcja-2)

1. Zaczynamy
------------

### Historia

Początki Lispa sięgają 1956, kiedy to podczas spotkania naukowego Dartmouth College John McCarthy poznał technikę zwaną ‘‘list processing’’ wynalezioną przez Allen Newell, J. C. Shaw oraz H. Simon. Programowanie w latach 1950-tych opierało się przede wszystkim na asemblerze. Wtedy też stworzono nowy język FORTRAN, przeznaczony do obliczeń numerycznych. Innowacyjnym okazał się pomysł, aby przekazywać komputerowi wyrażenia zapisane w matematyczny sposób. W ten sposób powstał bardzo potężny język obliczeniowy. McCarthy postanowił zbudować równie sprawny język dla obliczeń symbolicznych. Pierwsza wersja, Lisp 1, została stworzona na komputer IBM 704. Do roku 1964 Lisp działał już na kilku rodzajach komputerów, w tym IBM 7094.

W latach 1970-tych Guy Steele i Gerald Sussman określili nowy rodzaj Lisp, tzw. Scheme, który łączył siłę struktur Lispa z elegancją pomysłów z rodziny języka Algol. Na początku lat 1980-tych istniało kilkanaście niezależnych implementacji Lispa w kilku dialektach. Pierwsza edycja Common Lispa, łącząca najlepsze cechy wszystkich dialektów, pojawiła się w 1984 dzięki grupie projektantów: Scott Fahlman, Daniel Weinreb, David Moon, Guy Steele i Richard Gabriel. Pozostałe edycje w większości wymarły, poza wspomnianym Scheme. Dzisiaj Lisp jest wiodącym językiem dla wyszukanych badaniach nad funkcjonalnych, zorientowanych obiektowo i współbieżnych stylów programowania.

### Uruchamianie Lispa

Aby uruchomić Lispa na swoim komputerze (po wcześniejszym zainstalowaniu go) należy podać komendę „lisp”. Każda implementacja posiada swój własny styl powiadomienia Cię o rozpoczęciu pracy, lecz typowa informacja wygląda tak:

#### 1.1

CODEBLOCK\_PLACEHOLDER\_1

Znak '&gt;' to tzw. znak zachęty. W zależności od implementacji może on wyglądać trochę inaczej.
Aby zakończyć pracę z Lispem zazwyczaj należy wpisać (QUIT) lub (EXIT). Czasami można też użyć kombinację klawiszy Ctrl-D.

[Spis treści](/dydaktyka/lisp) | [Lekcja 2](/dydaktyka/lisp/lekcja-2)
