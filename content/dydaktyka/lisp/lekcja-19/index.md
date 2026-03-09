---
title: Lekcja 19
date: '2010-11-30T08:09:55Z'
lastmod: '2010-11-30T08:09:55Z'
draft: false
tags:
- lisp
author: 91.150.223.28
---

[Spis treści](/dydaktyka/lisp) | [Lekcja 18](/dydaktyka/lisp/lekcja-18) | [Lekcja 20](/dydaktyka/lisp/lekcja-20)

19. Notacja lambda
------------------

W LISP zaimplementowana jest matematyczna notacja funkcji nosząca nazwę notacji lambda, wymyślona
przez Alonzo Church'a. Notacja ta charakteryzuje się tym, że jasno w niej widać argumenty funkcji
oraz operacje jakie na nich są przeprowadzane. Np. λx.(3+x), gdzie λ to grecka litera lambda,
x przed kropką to argument funkcji, natomiast w nawiasie zapisana jest operacja jaką dokonuje
funkcja na swoim argumencie. W LISP można łatwo wyrazić ten zapis przy pomocy listy, której
pierwszym elementem jest symbol lambda (lambda (x) (+ 3 x)).

Inny przykład: f(x,y) = 3x + y^2^, w notacji lambda ma postać: λ(x,y).(3x+y^2), zaś w LISP:
(lambda (x y) (+ (\* 3 x) (\* y y))). Jak łatwo zauważyć notacja ta jest szczególnie podobna do
instrukcji LISP defun. Tym niemniej wyrażenie lambda nie jest funkcją, o próba jego obliczenia
da komunikat o błędzie. Aby wyrażenie to mogło być poprawnie obliczane, musi zostać stworzone
domknięcie leksykalne dla wyrażenia lambda. Można je stworzyć poprzez instrukcję function lub
jej skrót \#'. To co tak naprawdę robi instrukcja defun, która jest makrem, to przekształcenie
zapisu funkcji w wyrażenie lambda, stworzenie domknięcia leksykalnego, oraz przypisanie tego
domknięcia do atrybuty symbol-function symbolu będącego nazwą funkcji. Gdy interpreter LISP napotyka
jakiś symbol stojący w miejscu wywołania funkcji, to patrzy na jego atrybut symbol-function i jeśli
jest do domknięcie leksykalne, to dokonuj wywołania tego domknięcia z odpowiednimi argumentami.
Dzięki takiemu zapisowi możliwe jest tworzenie funkcji, których wynikami będą również funkcje, np:

#### 19.1

```lisp
(defun dodaj-n (n)
(lambda (x) (+ x n))
) =&gt; dodaj-n
(setf f (dodaj-n 5)) =&gt; \#<FUNCTION :LAMBDA (X) (+ X N)>
(funcall f 10) =&gt; 15
```

Notację lambda można też wykorzystywać do tworzenia anonimowych funkcji aplikowanych przez takie
instrukcje jak mapcar:

#### 19.2

```lisp
(mapcar (lambda (x) (+ x 10)) '(1 2 3 4 5))
=&gt; (11 12 13 14 15)
```

[Spis treści](/dydaktyka/lisp) | [Lekcja 18](/dydaktyka/lisp/lekcja-18) | [Lekcja 20](/dydaktyka/lisp/lekcja-20)
