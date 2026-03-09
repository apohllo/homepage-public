---
title: ONP
date: '2011-02-03T11:05:00Z'
lastmod: '2011-02-04T04:37:32Z'
draft: false
tags:
- onp
author: 91.150.223.28
---

Notacja infiksowa, prefiksowa i sufiksowa
-----------------------------------------

Zwykła notacja algebraiczna (zwana notacja infiksową) posiada pewne wady, jeśli weźmiemy pod uwagę łatwość jej interpretacji przez komputery:

-   operatory posiadają priorytety (tzn. mnożenie wykonywane jest przed dodawaniem)
-   zmiana priorytetów operatorów wymaga użycia nawiasów

Alternatywnymi wobec niej notacjami są notacja prefiksowa (przedrostkowa) oraz sufiksowa (przyrostkowa, odwrotna notacja polska).
W pierwszej z nich operator (symbol reprezentujący działanie) stoi przed operandami (argumentami działania), a w drugiej - za nimi. Przykładowo:

|       |                        |
|-------|------------------------|
| 2 + 3 | notacja konwencjonalna |
| + 2 3 | notacja prefiksowa     |
| 2 3 + | notacja sufiksowa      |

Notacja prefiksowa oraz sufiksowa nie posiadają wad notacji tradycyjnej, tzn. kolejność operacji zawsze wyznaczana jest przez położenie argumentów,
a nawiasy nie są stosowane. Z tego względu zapis w tych notacjach może być w znacznie prostszy sposób interpretowany przez komputer. Z drugiej
strony, brak nawiasów sprawa, że dla człowieka zapis tego rodzaju jest trudniejszy w interpretacji.

Odwrotna notacja polska
-----------------------

### Obliczanie wartości

ONP (odwrotna notacja polska) pozwala na konstrukcję bardzo prostego algorytmu obliczania wartości wyrażenia. Polega on na tym, że jeśli w w wyrażeniu
czytanym od lewej pojawia się operand (liczba), to wkładany jest on na stos, natomiast jeśli pojawia się operator, to ze stosu zdejmowane są jego
argumenty, a na stos trafia wynik działania. Ostateczny wynik jest odczytywany ze stosu.

Przykładowo dla wyrażenia '2 3 4 + \*', zmiany zawartości stosu wyglądają następująco:

```
2 &lt;= 2
2 3 &lt;= 3
2 3 4 &lt;= 4
2 7 &lt;= + (3 + 4)
14 &lt;= \* (2 \* 7)
```

Wynik: 14

Poniżej przedstawiony jest kod w języku Ruby, który pozwala na ewaluację wyrażenia w ONP przekazanego jako argument programu (uwaga - zakłada się, że wszystkie elementy oddzielone są pojedynczymi spacjami):

```ruby
expr = ARGV\[0\]
stack = \[\]
expr.split(/\\s+/).each do |token|
case token
when /\[+\*\\/^-\]/
op2 = stack.pop
op1 = stack.pop
case token
when "+"
stack.push(op1.to\_f + op2.to\_f)
when "-"
stack.push(op1.to\_f - op2.to\_f)
when "\*"
stack.push(op1.to\_f \* op2.to\_f)
when "/"
stack.push(op1.to\_f / op2.to\_f)
when "^"
stack.push(op1.to\_f **** op2.to\_f)
end
else
stack.push token
end
end
puts stack.pop
```

### Konwersja z notacji konwencjonalnej do ONP

Istnieje dosyć prosty algorytm pozwalający na dokonanie konwersji pomiędzy notacją konwencjonalną, a ONP.
Na wstępie należy ustalić priorytety operatorów w systemie konwencjonalnym:

|             |           |
|-------------|-----------|
| operator(y) | priorytet |
| ^           | 4         |
| \* /        | 3         |
| + -         | 2         |
| =           | 1         |
| (           | 0         |

Następnie analizując zawartość wyrażenia należy wykonywać następujące akcje:

-   jeśli element jest liczbą, to trafia on bezpośrednio do reprezentacji wyjściowej wyrażenia
-   jeśli element jest operatorem, to trafia na stos, wpierw jednak, ze stosu zdejmowane są kolejno wszystkie operatory, których priorytet jest większy bądź równy priorytetowi operatora, który ma być włożony na stos i trafiają one do reprezentacji wyjściowej
-   jeśli element jest nawiasem otwierający, to trafia on na stos
-   jeśli element jest nawiasem zamykającym, to ze stosu zdejmowane są wszystkie elementy, aż do pierwszego nawiasu otwierającego. Elementy te trafiają do reprezentacji wyjściowej. Nawiasy - otwierający i zamykający - są pomijane.
-   na koniec wszystkie elementy pozostałe na stosie, dopisywane są do reprezentacji wyjściowej

Przykładowo:

```
(2 + 3) \* 4
2 3 + 4 \*
```

Zawartość stosu:
```
( &lt;= (
( + &lt;= +
&lt;= ) zdjęcie ze stosu + i (
\* &lt;= \*
```

Poniższy kod w Ruby realizuję konwersję z systemu konwencjonalnego do ONP:

```ruby
expr = ARGV\[0\]
result = \[\]
stack = \[\]
PRIOR = Hash.new(0).merge({
"^" =&gt; 4,
"\*" =&gt; 3, "/" =&gt; 3,
"+" =&gt; 2, "-" =&gt; 2,
"=" =&gt; 1,
"(" =&gt; 0
})
expr.scan(/\[\*\\/+^-\]|\\d+|\\(|\\)/) do |token|
case token
when /\\A\[\*\\/+^-\]\\Z/
while PRIOR\[(token1 = stack.last)\] &gt;= PRIOR\[token\]
result &lt;&lt; stack.pop
end
stack.push token
when "("
stack.push token
when ")"
while (token1 = stack.pop) != "("
result &lt;&lt; token1
end
else
result &lt;&lt; token
end
end
while (token = stack.pop)
result &lt;&lt; token
end
puts result.join(" ")
```
