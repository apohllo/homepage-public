---
title: Lekcja 5
date: '2010-11-27T11:00:00Z'
lastmod: '2010-11-27T11:00:59Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 4](/dydaktyka/lisp/lekcja-4) | [Lekcja 6](/dydaktyka/lisp/lekcja-6)

5. Definiowanie Funkcji
-----------------------

Oto kilka przykładów funkcji:

#### 5.1. ta funkcja pobiera dowolną liczbę argumentów

code(lisp).
(+ 3 4 5 6) =&gt; 18
(+ (+ 3 4) (+ (+ 4 5) 6)) =&gt; 22

#### 5.2. definiowanie funkcji

code(lisp).
(defun foo (x y) (+ x y 5)) =&gt; FOO

#### 5.3. wołanie stworzonej funkcji

code(lisp).
(foo 5 0) =&gt; 10

#### 5.4. funkcja rekursywna

code(lisp).
(defun silnia (x)
(if (&gt; x 0)
(\* x (silnia (- x 1)))
1
)
) =&gt; SILNIA
(silnia 5) =&gt; 120

#### 5.5. funkcje wzajemnie rekursywne

code(lisp).
(defun a (x) (if (= x 0) t (b (- x)))) =&gt; A
(defun b (x) (if (&gt; x 0) (a (- x 1)) (a (+ x 1)))) =&gt; B
(a 5) =&gt; T

#### 5.6. funkcja o wielu instrukcjach - zwróci wartość, zwracaną przez jej ostatnią instrukcję

code(lisp).
(defun bar (x)
(setq x (\* x 3))
(setq x (/ x 2))
(+ x 4)
) =&gt; BAR
(bar 6) =&gt; 13

W notacji EVAL używamy list, aby zdefiniować funkcje i odnosimy się do argumentów funkcji przez nadane im nazwy.

#### 5.7. Funkcja AVERAGE jest zdefiniowana w notacji EVAL w ten sposób:

code(lisp).
(defun average (x y)
(/ (+ x y) 2.0)
)

Nazwa DEFUN pochodzi od define function. Jak wskazuje nazwa DEFUN używa się, by zdefiniować inne funkcje. Pierwszy wejście do DEFUN to imię funkcji zdefiniowanej. Drugi wejście jest listą argumentów, czyli nazwy, których funkcja użyje, by odnieść się do jego argumentów. Pozostała część wejścia do DEFUN definiuje ciało funkcji, a więc to, co jest wewnątrz pudełka.

#### 5.8.

code(lisp).
(defun square (n) (\* n n))

Nazwa funkcji to SQUARE. Jego listą argumentów jest (N), czyli SQUARE przyjmuje jeden argument, do którego to odnosi się wartość N. Ciało funkcji jest wyrażeniem (\* N N).

Pewne funkcje wymagają ustalonej liczby argumentów na wejściu, np: ODDP, który przyjmuje dokładnie jedno wejście i EQUAL, który bierze dokładnie dwa. Ale istnieje wiele funkcji przyjmujących zmienną liczbę wejść. Przykładowo - funkcje arytmetyczne +, -, \* i /.

#### 5.9.

code(lisp).
(\* 2 3 5) =&gt; 30

Aby pomnożyć trzy liczby, funkcja \* pomnaża najpierw pierwszy dwa, a następnie pomnaża do skutku kolejne przez wynik poprzedniego działania.

[Spis treści](/dydaktyka/lisp) | [Lekcja 4](/dydaktyka/lisp/lekcja-4) | [Lekcja 6](/dydaktyka/lisp/lekcja-6)
