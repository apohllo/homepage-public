---
title: Musicbrainz w Rubim
date: '2010-05-22T11:44:00Z'
lastmod: '2010-05-22T14:01:47Z'
draft: false
tags:
- ruby
- semantic web
- active rdf
- musicbrainz
author: 83.230.47.20
---

SemanticWeb i Ruby
------------------

Niestety nie mam zbyt wiele czasu, aby tłumaczyć ideę SemanticWeb. W dwóch słowach można powiedzieć,
że chodzi możliwość pobierania danych z Internetu w sposób zbliżony do podbierania danych
z relacyjnej bazy danych. Oczywiście biorąc pod uwagę immanentny internetowy pluralizm, trudno wyobrażać
sobie, że taka "baza danych" mogłaby posiadać wspólny schemat, dlatego też jednym z kluczowych elementów
SemanticWeb jest koncepcja ontologii - w tym kontekście: specyfikacji pojęć, które służą do opisu danych.

Na dzień dzisiejszy jedną z najbardziej doniosłych manifestacji tej idei jest [Linked Open Data](http://linkeddata.org) i słynna [chmura ontologii](http://richard.cyganiak.de/2007/10/lod/), czyli
obrazek, który ma nas przekonać, że inwestując w ideę SemanticWeb, można już pobrać bardzo dużo danych
w ten sposób i, co więcej, dane te nie będą odizolowane, ale przynajmniej w pewnym stopniu powiązane z innymi
danymi, publikowanymi przez rozmaite podmioty.

Jednym z kluczowych elementów SemanticWeb staje się [DBpedia](http://dbpedia.org), która jest ontologią
powstałą na bazie informacji wyekstrahowanych z angielskiej (ale nie tylko) Wikipedii. Coraz więcej
innych zasobów jest "linkowanych" do DBpedii, dzięki czemu staje się ona w dużej mierze ontologią
(schematem) odniesienia.

Czy faktycznie można już wykorzystywać powiązania pomiędzy poszczególnymi źródłami wiedzy pozostaje kwestią
dyskusyjną (np. przedstawione na obrazku powiązanie DBpedii z Musicbrainzem wydaje się mocno wątpliwe, gdyż
najistotniejsze elementy - czyli klasy, nie są powiązane), niemniej jednak warto śledzić rozwój tej koncepcji,
gdyż istotnie staję się ona coraz poważniej traktowana również przez instytucje komercyjne (np. Reuters, BBC).

Jako, że moim ulubionym językiem jest Rubi, [jakiś czas temu](/blog/activerdf-i-dbpedia) testowałem możliwość
wykorzystania biblioteki [ActiveRDF](http://activerdf.org) do pobierania danych z DBpedii. W tamtym poście jest
w zasadzie tylko kod i jeśli nie miało się styczności z ActiveRDF trudno cokolwiek z niego wywnioskować.
W niniejszym poście chciałbym przedstawić inny przykład wykorzystania ActiveRDF, tym razem do
pobierania danych z [Musicbrainza](http://musicbrainz.org/), czyli wielkiej bazy zawierającej dane dotyczące
tysięcy muzyków, płyt, utworów muzycznych i tym podobnych.

ActiveRDF
---------

ActiveRDF, jak można wnioskować na podstawie nazwy, ma uczynić nasze życie z SemanticWeb znacznie prostszym
(podobnie jak ActiveRecord czyni prostszym (?) obsługę relacyjnych baz danych). Niestety
po tym jak twórca tej biblioteki, czyli Eyal Oren przestał się nią opiekować, straciła ona swoja początkową
stabilność, a, co gorsza, wiele przykładów, które zostały udokumentowane, przestało działać w kolejnych
wersjach. Jest to pewna przypadłość języków dynamicznych, w szczególności Rubiego, że twórcy rozwiązań
mniejszą wagę przywiązują do zachowania stabilnego API - w myśl zasady: "lepsze wrogiem dobrego", zapominając
jednak, że często "działające lepsze od żadnego". Pomijając jednak te filozoficzne dywagacje, warto
wspomnieć, że obecnie ActiveRDF ma swoje [konto na Githubie](http://github.com/ActiveRDF/ActiveRDF) i jest
rozwijane. Niemniej jednak uruchomienie najnowszej (1.7.0) wersji, w szczególności jeśli używamy Rubiego 1.9
nie jest wcale banalne.

Niestety aktualny opiekun biblioteki nie otagował tej wersji, nie wysłał jej także na [gemcuttera](/blog/gemcutter),
przez co skazani jesteśmy na budowanie gema ze źródeł, co wcale nie jest takie banalne (specyfikacja
gemów zdefiniowana jest z użyciem jewelera, który jest niekompatybilny z Rubim 1.9). Dlatego najprościej
jest ściągnąć [mojego brancha 1\_7\_0](http://github.com/apohllo/ActiveRDF/tree/1_7_0)

```bash
$ git clone git://github.com/apohllo/ActiveRDF.git
...
$ cd ActiveRDF
```

Niestety nie obejdzie się bez użycia Rubiego 1.8 do zbudowania gema. Ja korzystam z Gentoo, dlatego
mogę zmienić wersję wykonując polecenie:

```bash
$ sudo eselect ruby set 1
Successfully switched to profile:
ruby18
$ /usr/bin/ruby18 /usr/bin/rake build
(in /home/fox/src/ruby/ActiveRDF)
Gokdok is not available. Install with: gem install gokdok
Rcov or dependency is not available
Generated: activerdf\_net7.gemspec
activerdf\_net7.gemspec is valid.
WARNING: no rubyforge\_project specified
WARNING: deprecated autorequire specified
Successfully built RubyGem
Name: activerdf\_net7
Version: 1.7.0
File: activerdf\_net7-1.7.0.gem
$ sudo eselect ruby set 2
Successfully switched to profile:
ruby19
$ sudo gem install pkg/activerdf\_net7-1.7.0.gem
```

Można również skorzystać z [rvm](http://rvm.beginrescueend.com/), ale nie będę tego opisywał w szczegółach.

Kiedy mamy już zbudowany i zainstalowany gem **activerdf** w wersji 1.7.0 musimy jeszcze doinstalować
odpowiedni adapter RDF. Ponieważ Musicbrainz eksponuje [sparql endpoint](http://dbtune.org/musicbrainz/sparql),
musimy doinstalować właśnie ten adapter:

```bash
$ cd activerdf-sparql/
$ gem build activerdf-sparql.gemspec
WARNING: no email specified
WARNING: no homepage specified
WARNING: no rubyforge\_project specified
WARNING: description and summary are identical
Successfully built RubyGem
Name: activerdf-sparql
Version: 1.3.6
File: activerdf-sparql-1.3.6.gem
$ sudo gem install activerdf-sparql-1.3.6.gem
...
```

W tej chwili jesteśmy już w pełni wyposażeni aby korzystać z ActiveRDF w najnowszej wersji w Rubim 1.9

Musicbrainz
-----------

[Sparql endpoint](http://dbtune.org/musicbrainz/sparql) Musicbrainz jest obsługiwany przez serwer
[d2r](http://www.wiwiss.fu-berlin.de/suhl/bizer/d2r-server/), który oficjalnie nie jest wspierany
przez aktualny adapter ActiveRDF. Najwyraźniej jednak standard SPARQL staje się na tyle dojrzały, że
nie ma zbyt wielu różnic pomiędzy poszczególnymi implementacjami, dzięki czemu można wykorzystać np.
implementację dla serwera Virtuoso.

```ruby
require 'active\_rdf'
include ActiveRDF
ConnectionPool.add(:type =&gt; :sparql, :url =&gt; 'http://dbtune.org/musicbrainz/sparql', :engine =&gt; :virtuoso)
```

Powyższy kod tworzy połączenie z ontologią Musicbrainz. Następnie rejestrujemy najistotniejsze
przestrzenie nazw (FOAF:http://www.foaf-project.org/, oraz MusicOntology:http://musicontology.com/):

```ruby
ActiveRDF::Namespace.register :foaf, 'http://xmlns.com/foaf/0.1/'
ActiveRDF::Namespace.register :mo, 'http://purl.org/ontology/mo/'
```

W zasadzie w tym momencie moglibyśmy już przeglądać zawartość Musicbrainza, ale jest jeszcze jeden
haczyk - otóż najwyraźniej serwer D2R nie radzi sobie z zapytaniami, w których explicite podane są
typy atrybutów (np. dla łańcucha znaków). Dlatego też musimy ustawić zmienną globalną (sic!)
`$activerdf_without_datatype` na `true`:

```ruby
$activerdf\_without\_datatype = true
```

Mam nadzieję, że w kolejnych wersjach ActiveRDF można będzie zrobić to w bardziej cywilizowany sposób.
Tak, czy owak, w tej chwili możemy już przeglądać szczegółowe informacje na temat muzyków, zespołów i innych, np.
W teorii wygląd prosto, ale w praktyce (ze względu na rozproszony charakter wiedzy), sprawy się komplikują:

```ruby
sting = ActiveRDF::Query.new.select(:x).where(:x, FOAF::name, "Sting").execute\[0\]
sting.foaf::name.first
\#=&gt; "Sting"
groups = ActiveRDF::Query.new.select(:x).where(:x, FOAF::member, sting).execute
groups.each{|g| puts g.foaf::name.first}
Strontium 90
The Police
```

W powyższym przykładzie z bazy pobieram zasób, który reprezentuje Stinga. Następnie odpytujemy się o jego
"nazwę" - i tutaj właśnie pierwsza niespodzianka, bo musimy dla tej nazwy (które też jest zasobem) wywołać
metodę "first". Powód tego (w moim najlepszym mniemaniu) jest taki, że moglibyśmy mieć w kilku źródłach
wiedzy różne wartości tego predykatu i musimy mieć dostęp do wszystkich.

Następnie pobieramy informacje o zespołach, w których grał Sting. Wykorzystujemy do tego predykat FOAF:member,
który wiąże grupę z jej członkami (grupa jest podmiotem w tej relacji). Dostajemy dwa rezultaty, do których
dobieramy się tak jak wcześniej.

Na koniec pobierzemy informacje o zarejestrowanych koncertach, w których Sting był wiodącym wokalistą:

```ruby
performances = ActiveRDF::Query.new.select(:x).where(:x, MO::lead\_singer, sting).execute
performances.each{|g| puts g.label}
\#=&gt; Sting performing (recorded on album Why Don't You Answer?)
\#=&gt; Sting performing (recorded on album Zenyattà Mondatta)
```

Jak widać powyżej, w bazie widnieją tylko informacje o dwóch zarejestrowanych koncertach.

Podsumowanie
------------

Pomimo problemów jakie trzeba rozwiązać, korzystając z wiedzy zawartej w SemanticWeb, można przyjąć
na chwilę obecną, że technologie semantyczne są już "używalne", a w Rubim, czego mogliśmy się spodziewać,
po przezwyciężeniu problemów konfiguracyjnych, można całkiem przyjemnie je przetwarzać.
