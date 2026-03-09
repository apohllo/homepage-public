---
title: Currying w Rubim
date: '2012-08-28T14:46:03Z'
lastmod: '2012-08-28T14:46:03Z'
draft: false
tags:
- ruby
- haskell
- currying
author: 131.211.227.134
---

W nawiązaniu do [wcześniejszego wpisu](/blog/operator-kompozycji-w-rubim) na temat możliwości zaimplementowania
operatora kompozycji w Rubim w tym wpisie pokazuję, że Ruby posiada jeszcze jedną cechę języków funkcyjnych.
Mianowicie umożliwia wywoływanie funkcji z niepełną listą parametrów. W terminologii programowania funkcyjnego
nazywane jest to curryingiem. Zasadnicza idea polega na tym, że skoro funkcje traktujemy funkcje jako
pierwszorzędnych obywateli w danym języku, to powinniśmy mieć możliwość częściowej aplikacji tych
funkcji do ich argumentów - tzn. jeśli liczba argumentów jest mniejsza niż wymagana, otrzymujemy nową
funkcję, która dopiero po dostarczeniu brakujących argumentów zwróci konkretną wartość.

W chwili gdy poznałem tę funkcję Haskella, uświadomiłem sobie, że w Rubim nie mamy takiej możliwości, tzn.

```ruby
plus = -&gt;(x,y) { x + y }
plus\_two = plus\[2\] \# ArgumentError: wrong number of arguments (1 for 2)
```

Okazuje się jednak, że klasa Proc definiuje wywołanie `curry`, które realizuje tę funkcjonalność.
Zatem korzystając z tego wywołanie możemy osiągnąć pożądany efekt:

```ruby
plus = -&gt;(x,y) { x + y }
plus\_two = plus.curry\[2\]
plus\_two\[3\] \# =&gt; 5
plut\_two\[5\] \# =&gt; 7
```

Co więcej - uzyskana w ten sposób funkcja nie wymaga wywoływania `curry` w celu częściowej aplikacji argumentów:

```ruby
multiply = -&gt;(x,y,z) { x \* y \* z }
multiply\_2 = multiply.curry\[2\]
multiply\_2\_3 = multiply\_2\[3\]
multiply\_2\_3\[5\] \#=&gt; 30
```
