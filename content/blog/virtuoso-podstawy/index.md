---
title: Virtuoso - podstawy
date: '2011-04-05T09:10:00Z'
lastmod: '2014-04-25T14:29:35Z'
draft: false
tags:
- sparql
- rdf
- semantic web
author: 5.173.55.168
---

### Dlaczego Virtuoso?

Obecnie jest już [sporo narzędzi](http://www.w3.org/wiki/SparqlImplementations) pozwalających na przechowywanie danych w formacie RDF oraz
zadawanie pytań w języku SPARQL. Ponieważ obecnie nie mam czasu żeby przyjrzeć się szczegółowo nawet tym najbardziej popularnym (AllegroGraph, Sesame 2, OWLime,
D2R, OntoBroker, Virtuoso), aby przechowywać dane, które są co prawda dostępne jako RDF, ale nie posiadają dedykowanego SPARQL endpointu,
oparłem się na wyborze jakiego dokonali twórcy DBpedii, tj. [Virtuoso](http://virtuoso.openlinksw.com/dataspace/dav/wiki/Main).
Narzędzie to występuje w wersji komercyjnej oraz wolnej, więc z jednej strony można mu się swobodnie przyjrzeć, a z drugiej, czas na to poświęcony
raczej nie będzie stracony, jeśli w przyszłości zechcemy wykorzystać je w jakimś komercyjnym projekcie, dla którego potrzebna będzie większa wydajność oraz
support.

### Instalacja

Virtuoso OpenSource można ściągnąć ze [strony producenta](http://virtuoso.openlinksw.com/dataspace/dav/wiki/Main/VOSDownload) lub za pośrednictwem
dedykowanego dla naszego systemu operacyjnego narzędzia do zarządzania pakietami (odpowiednie paczki istnieją np. dla Gentoo oraz Debiana), dlatego
z instalacją nie powinno być problemu.

### Konfiguracja

Zainstalowane ze źródeł Virtuosu (przynajmniej pod Gentoo) nie posiada żadnych plików konfiguracyjnych, dlatego musimy przygotować sami minimalną konfigurację.
Może ona wyglądać następująco:

```
\[Database\]
DatabaseFile=/var/lib/virtuoso/db/virtuoso.db
TransactionFile=/var/lib/virtuoso/db/virtuoso.trx
ErrorLogFile=/var/lib/virtuoso/db/virtuoso.log
\[Parameters\]
DirsAllowed=/path/to/dir
\[HTTPServer\]
ServerPort=8080
```

Konfigurację tę możemy umieścić np. w pliku **`/etc/virtuoso.ini`**.

Poszczególne zmienne konfiguracyjne zasadniczo są samoopisujące - z wyjątkiem może `DirsAllowed`. Ten parametr ustala ścieżki, z których będziemy mogli
ładować **pliki zewnętrzne**. Ustalenie go jest kluczowe dla punktu, w którym będziemy ładować dane zewnętrzne.

### Uruchomienie serwera i klienta

Serwer uruchamiany jest za pomocą polecenia **`virtuoso-t`**. Polecenie to przyjmuje kilka opcji, w szczególności kluczowe jest określenie pliku konfiguracyjnego.
Służy do tego opcja `+configfile`.
Dodatkowo przy pierwszym uruchomieniu możemy zażądać, aby serwer nie działał w tle (opcja `+foreground`),
dzięki czemu w razie problemów będziemy mogli zobaczyć co jest nie tak.

```bash
$ virtuoso-t +configfile /etc/virtuoso.ini +foreground
Tue Apr 05 2011
12:23:07 INFO: OpenLink Virtuoso Universal Server
12:23:07 INFO: Version 06.01.3127-pthreads for Linux as of Mar 8 2011
12:23:07 INFO: uses parts of OpenSSL, PCRE, Html Tidy
12:23:07 INFO: Database version 3126
12:23:07 INFO: SQL Optimizer enabled (max 1000 layouts)
12:23:08 INFO: Compiler unit is timed at 0.000694 msec
12:23:11 INFO: Roll forward started
12:23:11 INFO: Roll forward complete
12:23:12 INFO: Checkpoint started
12:23:13 INFO: Checkpoint finished, log reused
12:23:15 INFO: HTTP server online at 8080
12:23:15 INFO: Server online at 1111 (pid 15156)
```

Kiedy uruchomimy serwer, możemy sprawdzić go w działaniu wykorzystując polecenie **`isql-v`**. Otwiera ono interaktywną sesję pracy z serwerem:

```bash
$ isql-v
SQL&gt; sparql select \* where {?s ?p ?o} limit 10;
```

Powłoka klienta pozwala na bezpośrednie przeglądanie bazy danych, na której działa Virtuoso, za pomocą zwykłych poleceń SQL-owych. Dlatego
zapytania SPARQL-owe muszą być poprzedzone słowem kluczowym SPARQL. Przykładowe zapytanie przedstawione jest powyżej. Niemniej dla świeżej
instalacji Virtuoso nie zwróci ono żadnych rezultatów.

### Ładowanie istniejących danych

Żeby poeksperymentować z zapytaniami SPARQL musimy załadować jakieś dane RDF.
Są one dostarczane przez wiele organizacji (np. [DBpedię](http://wiki.dbpedia.org/Downloads36), [Umbel](http://code.google.com/p/umbel/source/browse/#svn%2Ftrunk%2Fv100%2FOntology), itp)
w postaci RDF+XML lub innego popularnego formatu, np. n3. Zazwyczaj dane takie dostępne są w postaci jednego dużego pliku lub, w przypadku bardzo dużych
zbiorów, w postaci kilku mniejszych plików.

Możemy je załadować do własnej instancji Virtuoso wykonując następujące kroki:

1.  w pliku konfiguracyjnym zezwalamy na ładowanie plików z katalogu, w którym przechowujemy ściągnięte pliki
2.  ściągamy i uruchamiamy [skrypt](http://virtuoso.openlinksw.com/dataspace/dav/wiki/Main/VirtBulkRDFLoaderScript) pozwalający na masowe ładowanie danych
3.  w konsoli Virtuoso wykonujemy polecenie/a **`ld_dir`**
4.  w konsoli Virtuoso wykonujemy polecenie **`df_loader_run`**

Pierwszy krok został opisany w punkcie "Konfiguracja".

Po ściągnięciu pliku, wskazanego w drugim punkcie, zapisujemy go w aktualnym katalogu, np. pod nazwą `rdfloader.sql`,
następnie w tym samym katalogu wywołujemy polecenie `isql-v`.
Następnie w konsoli SQL wywołujemy polecenie `load rdfloader.sql`:

```bash
$ ls
rdfloader.sql
$ isql-v
SQL&gt; load rdfloader.sql;
```

Jeśli za kilka dni będziemy chcieli załadować kolejną paczkę danych, to procedury tej nie trzeba będzie już powtarzać.

Kolejny krok polega na wskazaniu katalogu, z którego chcemy załadować dane. Polecenie `ld_dir` przyjmuje trzy argumenty:

-   ścieżkę do katalogu
-   szablon nazwy plików
-   nazwę grafu, do którego załadowane zostaną dane

Pierwszy argument nie wymaga wyjaśnienia. Drugi argument pozwala określić szablon (tak jak dla polecenia ls), np. '\*.n3' lub wskazać konkretny plik,
np. dbpedia.n3. Trzeci argument jest o tyle istotny, że pozwala przechowywać w jednej instancji semantycznej bazy dane z różnych źródeł i odwoływać
się do nich niezależnie za pomocą klauzuli `WHERE`. Warto wybrać nazwę wskazującą źródło danych w postaci adresu URL, np. `http://dbpedia.org`.

Przykładowe polecenie może wyglądać następująco:

```
SQL&gt; ld\_dir('/home/user/rdf/dbpedia','\*.n3','http://dbpedia.org');
```

Wbrew oczekiwaniom polecenie to nie załaduje od razu danych do bazy. Dopiero kolejne polecenie `df_loader_run`, spowoduje załadowanie danych.
Przed jego wykonaniem należy uzbroić się w cierpliwość, gdyż może zająć to całkiem sporo czasu.

```
SQL&gt; rdf\_loader\_run ();
```

### Przykładowe użycie

Jeśli wszystko przebiegło poprawnie, to powinniśmy mieć możliwość korzystania z załadowanych danych poprzez SPARQL end-point.
Możemy go najpierw przetestować w konsoli `isql-v`:

```
sparql select \* from &lt;http://dbpedia.org&gt; where {?s ?p ?o} limit 5;
http://dbpedia.org/resource/Autism http://www.w3.org/1999/02/22-rdf-syntax-ns\#type http://www.w3.org/2002/07/owl\#Thing
http://dbpedia.org/resource/Alabama http://www.w3.org/1999/02/22-rdf-syntax-ns\#type http://www.w3.org/2002/07/owl\#Thing
http://dbpedia.org/resource/Aristotle http://www.w3.org/1999/02/22-rdf-syntax-ns\#type http://www.w3.org/2002/07/owl\#Thing
http://dbpedia.org/resource/Academy\_Award http://www.w3.org/1999/02/22-rdf-syntax-ns\#type http://www.w3.org/2002/07/owl\#Thing
http://dbpedia.org/resource/Actrius http://www.w3.org/1999/02/22-rdf-syntax-ns\#type http://www.w3.org/2002/07/owl\#Thing
```

Innym sposobem dostępu jest wykorzystanie wbudowanego serwera WWW. Otwieramy stronę pod adresem <http://localhost:8080/sparql> i
od razu możemy zadawać zapytania SPARQL.

Możemy również przetestować działanie end-pointu z poziomu jakiegoś języka programowania, np. Rubiego:

```ruby
require 'sparql/client'
client = SPARQL::Client.new("http://localhost:8080/sparql")
results = client.query("select \* where {?subject ?predicate ?object} limit 5")
results.each{|r| puts "\#{r.subject} \#{r.predicate} \#{r.object}"}
```
