---
title: Lekcja 2
date: '2010-11-27T10:26:00Z'
lastmod: '2010-11-27T10:44:48Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 1](/dydaktyka/lisp/lekcja-1) | [Lekcja 3](/dydaktyka/lisp/lekcja-3)

2. Elementy języka
------------------

Na początku wyjaśnijmy podstawowe pojęcia: funkcja i dane. Terminem dana określa się informacje takie jak liczby, słowa lub listy rzeczy. Funkcje można porównać do pudełka, przez które wychodzą dane.

Symbol – to każdy łańcuch znaków, cyfr i niektórych znaków specjalnych nie będący liczbą, np.: x, y, z, xyz, sdf-df, g7y7y, znak, heigh, . Zazwyczaj nazwy symboli biorą się z angielskich nazw (w naszym wypadku także polskich).

#### 2.1. zachowaj liczbę 4 jako wartość symbolu x

code(lisp).
(setg x 4)

#### 2.2. pobierz wartość symbolu x (wymaga wcześniejszego wykonania zadania 2.1.)

code(lisp).
x
zwracane jest: 4

#### 2.3. użyj wartości symbolu jako argumentu funkcji + (wymaga wcześniejszego wykonania zadania 2.1.)

code(lisp).
(+ x 7)
zwracane jest: 11

#### 2.4. spróbuj pobrać wartość symbolu, któremu nie przypisano żadnej wartości

code(lisp).
m
zwracane jest:
Error: Attempt to take the value of the unbound symbol M / nil ??

### Symbole specjalne: T i NIL

Lisp posiada dwa symbole posiadające przypisane im na stałe wartość. Są to: T oznaczający „prawda” , „tak” oraz NIL - „fałsz”, „nie”, „pusty”

#### 2.5. test symboli T i NIL

code(lisp).
(if T 3 9)
zwracane jest: 3
(if NIL 3 9)
zwracane jest: 9
(if 1 3 9)
zwracane jest: 3

Należy tu dodać pewne wyjaśnienie. Nil zawsze oznacza fałsz, czyli wszystko inne zawsze będzie oznaczało prawdę. Właściwie T używamy dla pewnej prostoty i przejrzystości.

Słowo kluczowe – dowolny symbol, którego nazwa rozpoczyna się od „:”, np.:

#### 2.6. słowa kluczowe

code(lisp).
:to-jest-slowo-kluczowe
zwracane jest: :TO-JEST-SLOWO-KLUCZOWE

Liczby – to łańcuch cyfr od “0” do “9”, czasami poprzedzonych znakami “+” lub “-“. Wyróżniamy liczby: całkowite, dziesiętne (ma kropkę dziesiętną i może być zapisana w notacji naukowej), wymierna (dwie liczby całkowite przedzielone znakiem „/”), zespolone (są zapisywane jako \#c(r i) -gdzie r jest częścią rzeczywistą, a i jest częścią urojoną), np:

#### 2.7. kilka liczb w LISPie

code(lisp).
234
-62
+478
3.1415
3.45e-3
\#c(6.13e-3 4.123)

Standardowe funkcje arytmetyczne są wciąż dostępne: +, -, **, /, floor, ceiling, mod, sin, cos, tan, sqrt, exp, expt, itd. Wszystkie one przyjmują dowolny rodzaj argumentu. +, -,**, i / zwracają liczbę zgodnie z następującymi zasadami: liczba całkowita plus wymierna daje wymierną, wymierna plus rzeczywistą daje rzeczywistą, a rzeczywista plus zespolona daje zespoloną.

#### 2.8. podstawowe funkcje arytmetyczne

code(lisp).
(+ 4 3/5)
zwracane jest: 23/5
(exp 1)
zwracane jest: 2.7182817
(exp 3)
zwracane jest: 20.085537
(expt 3 4.2)
zwracane jest: 100.90418

Jedynym ograniczeniem wielkości liczby całkowitej jest pamięć komputera. Nie mniej jednak operowanie na dużych liczbach bardzo spowalnia prace komputera.

[Spis treści](/dydaktyka/lisp) | [Lekcja 1](/dydaktyka/lisp/lekcja-1) | [Lekcja 3](/dydaktyka/lisp/lekcja-3)
