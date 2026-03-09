---
title: Operator kompozycji w Rubim
date: '2012-08-27T16:01:00Z'
lastmod: '2012-08-28T01:32:31Z'
draft: false
tags:
- ruby
- programowanie funkcyjne
- haskell
author: 145.97.199.104
---

Jako język funkcyjny Haskell posiada wiele ciekawych własności, m.in. umożliwia kompozycje funkcji. Tzn. możemy zdefiniować dwie funkcje a operator kompozycji przekształca je w trzecią funkcję, która jest złożeniem tychże.

Zastanawiałem się przez chwilę, czy coś takiego możliwe jest do zrobienia w Rubim. Jak wiadomo posiada on pewne
cechy języków funkcyjnych, ale nie jest tak zaawansowany jak Haskell - w szczególności jest dynamicznie typizowany,
więc nie umożliwia statycznej analizy typów.
Niemniej jednak możliwość zdefiniowania operatora kompozycji wydała mi się interesującym wyzwaniem.

Okazuje się, że w Rubim można zrobić to dość łatwo - wystarczy rozszerzyć definicję klasy `Proc` o operator powiedzmy
`*`, który pozwalał będzie na składanie funkcji. Definicja tego operator wygląda następująco:

```ruby
class Proc
def \*(other)
-&gt;(x){self\[other\[x\]\]}
end
end
```

Dzięki tak zdefiniowanemu operatorowi możliwe jest składanie funkcji:

```ruby
f = -&gt;(x){x + 1}
g = -&gt;(x){x \* 2}
f\[g\[1\]\] \#=&gt; 24 - zwykłe złożenie
(f \* g)\[1\] \#=&gt; 24 - złożenie z użyciem operatora)
```

Co więcej, okazuje się, że w Rubim dość łatwo można składać funkcje więcej niż 1-argumentowe (w Haskellu nie ma takiej możliwości - konieczne jest jawne użycie krotek (tuple); w praktyce sprowadza się to do składania funkcji jednoargumentowcych). Odpowiednia definicja wygląda następująco:

```ruby
class Proc
def \*(other)
-&gt;(\*args){self\[\*other\[\*args\]\]}
end
end
f = ~~&gt;(x,y){\[x + y,x~~ y\]}
g = -&gt;(x,y){\[x \* y,x / y\]}
(f \* g)\[10,2\] \#=&gt; \[25,15\]
```

Oczywiście w Rubim też w zasadzie budujemy krotki, ale nie zmienia to faktu, że funkcje f i g w tym przykładzie są
dwuargumentowe.

Podsumowując - powyższe przykłady pokazują, że w Rubim można dość łatwo uzyskać niektóre interesujące cechy
programowania funkcyjnego.
