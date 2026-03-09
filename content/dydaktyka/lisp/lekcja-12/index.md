---
title: Lekcja 12
date: '2010-11-29T12:41:02Z'
lastmod: '2010-11-29T12:41:02Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 11](/dydaktyka/lisp/lekcja-11) | [Lekcja 13](/dydaktyka/lisp/lekcja-13)

12. Zawężenie leksykalne i zmienne specjalne
--------------------------------------------

W LISP isntieją dwa typy zmiennych: zmienne zwykłe i specjalne.

### 12.1 Zmienne zwykłe

Zmienne zwykłe charakteryzują się
tym, że zakres ich widoczności jest leksykalny, tzn. można się do nich odwoływać tylko w bloku
wewnątrz którego zostały doń przywiązane konkretne wartości. Takie wartości mogą być związane
np. przy wywołaniu funckji, wtedy to formalne zmienne funkcji są wiązana z argumentami, na rzecz
których funkcja została wywołana. Jeżeli w danej funkcji wywołujemy inna funkcję, która
wykorzystuje zmienne o tych samych nazwach, to mimo tego, że związane są one wewnątrz ciała
pierwszej z funkcji z pewnymi wartościami, to w drugiej funkcji zmienne to nie są już związane
z tymi obiektami. W zależności, czy zmienne te sąargumentami formalnymi, czy nie danej funkcji
związane są z argumentami tej funkcji, bądź z globlanymi wartościami tych zmiennych.
h4. 12.1

code(lisp).
(defun globalna () b) =&gt; globalna
(defun leksykalna (a)
(setq b a)
(format t "~&Wartosc a: ~S oraz funkcji globalna: ~S" a (globalna))
) =&gt; leksyklana
(leksykalna 7) =&gt; Error: Attempt to take the value of the unbound symbol B
(setq b 10) =&gt; 10
(leksykalna 7)
Wartosc a 7 oraz funkcji globalna: 10
=&gt; nil

Widzimy więc, że pomimo tego iż w ciele funkcji leksykalna zmienna a jest związana z pewną wartością
to ze względu na jej leksykalny zakres, w funkcji globalna odwołujemy się do jej globalnej wartośći.
Jeśli zmienna globalna nie była wcześniej związana z jakąś wartością, to wyświetlany jest komunikat
o błędzie.

### 12.2 Zmienne specjalne

Zmienne specjalne są przeciwieństwem zmiennych zwykłych. Nazywa się je również zmiennymi dynamicznymi,
gdyż odwołując się do nich, otrzymujemy zawsze ostatnią wartość, która została im przypisana
czy to na pozimie globalnym, czy to w ciele jakiejś funkcji. Zmienne takie tradycyjnie zapisuje się
okalając je w dwie gwiazdki, aby łatwo odróżnić je od zmiennych zwykłych, np. \*zmienna-specjalna\*.

### 12.2.1 defvar

Instrukcja defvar służy do stowrzenia zmiennej specjalnej i przypisania jej wartości początkowej.
Jeśli teraz w ciele jakiejś funkcji dokonamy zmiany wartości takiej zmiennej, to zmiana ta
będzie widoczna również w pozostałych funkcjach.
h4. 12.2

code(lisp).
(defvar **a** 10)
(defun globalna () **a**) =&gt; globalna
(defun specjalna (a)
(setq **a** a)
(format t "~&Wartość a: ~S oraz funkcji globalna: ~S" a (globalna))
) =&gt; specjalna
(specjalna 10)
Wartość a: 10 oraz funkcji specjalna: 10
=&gt; nil

Ponieważ zmienne specjalne mogą dawać dziwne wyniki, w różnych funkcjach stosuje się je zwykle jako
zmienne globale, o ściśle określonym przeznaczeniu.

### 12.3 Zawężenie leksykalne

W LISP można uzuskać zawężenie leksykalne charakterystyczne dla funkcji C i Pascala, również
w miejscu innym niż ciało funkcji. Służy do tego instrukcja let i let\* .

### 12.3.1 let

Instrukcja let, pozwala związać zmienne zwykłe i dokonać na nich pewnych operacji. Dzięki temu
możemy odgrodzić pewne części programu od innych, niekoniecznie poprzez pisanie osobnych
funkcji. Jej struktura jest następująca (let ((var1 val1) (var2 val2) ...) body), gdzie var1
to pierwsza zmienna, którą chcemy zawęzić leksykalnie, zaś val1, to wartość początkowa, którą
w bloku let otrzymuje ta zmienna. Podobnie jest vla var2 i kolejnych. Body to fragment
kodu, który zostanie wykonany ze zmiennymi var1, var2... zawężonymi leksykalnie.

#### 12.3

code(lisp).
(defun demonstracja-let ()
(setq a 10)
(let ((a 20)) (format t "~&Wartosc a wewnatrz let ~S" a))
(format t "~&Wartosc a poza let ~S" a)
) =&gt; demonstracja-let
(demonstracja-let)
Wartosc a wewnatrz let 20
Wartosc a poza let 10
=&gt; nil

Wartości przypisywane zmiennym var1, var2... obliczane sa po kolei, natomiast związanie jest równoległe,
to znaczy w części wiążącej instrukcji let, mamy dostęp do zmiennych var1, var2 sprzed związania.

#### 12.4

code(lisp).
(defun demonstracja-kolejnosci ()
(setq a 10)
(let ((a 20)
(b a))
(format t "~&Wartosc a: ~S oraz b: ~S" a b))
) =&gt; demonstracja-kolejnosci
(demonstracja-kolenosci)
Wartosc a: 20 wartosc b: 10
=&gt; nil

### 12.3.2 let\*

Jeśli chcemy, aby wiązania następowały po sobie, to musimy skorzystać z instrukcji let\*, której
wywołanie jest identyczne jak instrukcji let. Natomiast różni się ona od let, właśnie kolejnością
wiązania. Najpierw więc obliczana jest wartość val1, potem przypisywana zmiennej var1, następnie
wartość val2 i przypisywana zmiennej var2 itd. Skutkuje to tym, że jeśli w vali odwołujemy się
do zmiennej varj, poprzedzającej vari, to mamy jej wartość po związaniu.

#### 12.5

code(lisp).
(defun demonstracja-kolejnosci2 ()
(setq a 10)
(let\* ((a 20)
(b a))
(format t "~&Wartosc a: ~S oraz b: ~S" a b))
) =&gt; demonstracja-kolejnosci
(demonstracja-kolenosci2)
Wartosc a: 20 wartosc b: 20
=&gt; nil

[Spis treści](/dydaktyka/lisp) | [Lekcja 11](/dydaktyka/lisp/lekcja-11) | [Lekcja 13](/dydaktyka/lisp/lekcja-13)
