---
title: Język w SPARQL
date: '2008-11-14T19:10:00Z'
lastmod: '2010-05-22T11:39:13Z'
draft: false
author: 83.230.47.20
---

Moja przygoda z SPARQL zacząłe się od [DBpedia.org](http://dbpedia.org) - sformalizowanej wersji Wikipedii.
Chciałem zrobić coś naprawdę prostego - wydobyć wszystkie pojęcia, która miałyby określoną wartość atrybuty `rdfs:label`.
Szybko jednak okazało się, że proste zapytanie, które powinno zwrócić obiekty o etykiecie 'Berlin':

code.
SELECT \* WHERE {
?x rdfs:label "Berlin"
}

nie daje żadnych sensownych rezultatów. Domyślałem się, że problem leży w tym, że predykat `rdfs:label`
może posiadać wiele wartości, dla wielu języków wykorzystywanych w Wikipedii. Niestety znalezienie
odpowiedzi na pytanie, jak określić język dla atrybuty nie było całkowicie banalne.
Chociaż informacja ta zawarta jest w [opisie SPARQL](http://www.w3.org/TR/rdf-sparql-query),
na stronach w3.org niestety uszła mojej uwadze w trakcie pobieżnego czytania.

Dopiero dalsze googlowanie przywiodło mnie do następującego rozwiązania:

code.
SELECT \* WHERE {
?x rdfs:label "Berlin"@en
}

Określenie języka poprzez dodanie za łańcuchem znaków małpy oraz jego skrótu, dało pożądany rezultat,
tzn. zwróciło wszystkie obiekty, których etykieta w języku angielskim to "Berlin".
Ku mojemu zdziwieniu, rezultatów jest wiele, o czy można [przekonać się samemu](http://dbpedia.org/snorql/?query=SELECT+*+WHERE+{%0D%0A+%3Fx+rdfs%3Alabel+%22Berlin%22%40en%0D%0A%7d).
