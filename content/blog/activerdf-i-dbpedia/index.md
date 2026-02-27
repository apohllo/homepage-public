---
title: ActiveRDF i dbpedia
date: '2008-11-14T21:00:00Z'
lastmod: '2010-05-22T14:08:55Z'
draft: false
author: 83.230.47.20
---

Niech kod mówi sam za siebie :-)

code(ruby).
require 'active\_rdf'
pool = ConnectionPool.add\_data\_source :type =&gt; :sparql,
:url =&gt; "http://dbpedia.org/sparql",
:results =&gt; :sparql\_xml, :engine =&gt; :virtuoso
Namespace.register(:dbpedia, 'http://dbpedia.org/')
Query.new.select(:x).where(:x, RDFS::Resource.new('http://www.w3.org/2000/01/rdf-schema\#label'),
LocalizedString.new("Berlin","en")).execute

Pobieramy z DBpedii wszystkie zasoby, których etykieta w języku angielskim to "Berlin"

W dalszych przykładach zakładamy, że mamy już załadowany `ActiveRDF` oraz że dodaliśmy połączenia z DBpedią.

code(ruby).
Query.new.distinct(:y).where(:x, RDFS::Resource.new('http://www.w3.org/2000/01/rdf-schema\#label'),
LocalizedString.new("Berlin","en")).
where(:x, RDFS::Resource.new('http://www.w3.org/2000/01/rdf-schema\#comment'), :y).lang(:y,"pl").execute

Tutaj pobieramy komentarze w języku polskim dla zasobów, których polską etykietą jest "Berlin".

Poniższy przykład ilustruje proponowane rozszerzenie biblioteki ActiveRDF,
które [może zostanie uwzględnione](http://lists.deri.org/pipermail/activerdf/2008-November/000792.html) w jej kolejnej wersji:

code(ruby).
rs = Query.new.distinct(:x).where(:x,
RDFS::Resource.new('http://www.w3.org/2000/01/rdf-schema\#label'),
LocalizedString.new("Berlin","en")).execute
Query.new.distinct(:comment).where(rs\[1\],
RDFS::Resource.new('http://www.w3.org/2000/01/rdf\#comment',
:comment).lang(:comment,"pl").execute

Zamiast ostatniego polecenia znacznie lepiej byłoby, gdybyśmy mogli napisać:

code(ruby).
rs\[1\].comment{|query,object| query.lang(object,"pl")}
