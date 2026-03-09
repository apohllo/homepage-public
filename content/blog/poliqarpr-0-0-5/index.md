---
title: poliqarpr 0.0.5
date: '2009-12-10T13:08:00Z'
lastmod: '2009-12-10T14:06:27Z'
draft: false
tags:
- ruby
- nlp
- gem
- poliqarpr
author: 213.134.160.231
---

Poliqarpr jest nakładką dla Rubiego, pozwalającą w prosty sposób korzystać z serwera [Poliqarp](http://poliqarp.sourceforge.net/).

#### Poliqarp - serwer korpusów

Sam Poliqarp został pomyślany jako narzędzie ułatwiające pracę z korpusami tekstów. Jego zasadnicze przeznaczenie
to wyszukiwanie fragmentów tekstów na potrzeby różnych zadań z dziedziny przetwarzania języka naturalnego.
W obecnej chwili jest wykorzystywany w projekcie [Narodowego Korpusu Języka Polskiego](http://nkjp.pl), ale został
zaprojektowany w sposób, który pozwala stosować go również dla innych języków.

Co więcej - język zapytań
Poliqarpa pozwala wyszukiwać słowa w korpusie nie tylko w oparciu o odmienione formy (wtedy nie różniłby się
on specjalnie od funkcjonalności baz danych z wyszukiwaniem pełnotekstowym), ale pozwala np. określić,
formę podstawową (tzw. lemat) słowa, a znalezione zostaną wszystkie wystąpienia, również form derywowanych
(np. możemy zadać pytanie o "bój", a w wynikach otrzymamy formy odmienione: boju, boje, bojom).

Również ta funkcjonalność nie jest związana wyłącznie z językiem polskim (choć ma zastosowanie głównie dla języków fleksyjnych),
ani nie jest przywiązana do jednego zbioru tagów. Dzięki temu, w zależności od zastosowanego narzędzia, możemy korzystać
z alternatywnych zbiorów tagów, nawet w ramach jednego języka.

#### Poliqarpr - klient napisany w Rubim, dla serwera Poliqarp

Poliqarp\*r\*, jak było wspomniane, jest napisanym w Ruby klientem, dla serwera Poliqarp.
Jest on dostępny w publicznym repozytorium na [GitHubie](http://www.github.com/apohllo/poliqarp). Możemy go stamtąd
pobrać za pomocą poniższego polecenia:

code(bash).
$ git clone git://github.com/apohllo/poliqarpr.git

Oczywiście jest on również dostępny jako gem na gemcutterze:

code(bash).
\# sprawdzamy wersję rubygems
$ gem -v
1.3.5 \#=&gt; OK!
\# dodajemy gemcutter do listy repozytoriów, jeśli wcześniej na niej nie był
$ gem sources -a http://gemcutter.org
\# instalujemy poliqapr
$ gem install poliqarpr -a http://gemcutter.org
Successfully installed poliqarpr-0.0.5
1 gem installed
Installing ri documentation for poliqarpr-0.0.5...
Installing RDoc documentation for poliqarpr-0.0.5...

Jeśli wszystko przebiegnie bez zakłóceń możemy zacząć testować poliqarpa. Ponieważ jednak bez korpusu nie ma to większego sensu,
dostępny jest również gem `poliqarpr-corpus`, który zawiera przykładowy korpus dla języka polskiego (zrównoważony słownik frekwencyjny).

Instalacja jest równie prosta:

code(bash).
$ gem install poliqarpr-corpus

W tym momencie musimy uzbroić się w odrobinę cierpliwości, bo korpus ma rozmiar kilku megabajtów.

Poliqarpr nie jest jedynym klientem dla serwera Poliqarp - dostępna jest również wersja w Javie, napisana przez autorów serwera.
W stosunku do klienta javowego otrzymujemy jednak kilka udogodnień:

-   specyfikacja w formie testów
-   segmenty, fragmenty oraz rezultaty zapytań są pełnoprawnymi klasami
-   jest napisany w Rubim ;)

W szczególności to, że rezultaty zapytań są klasami, pozwala w łatwy sposób tworzyć paginację. Po szczegóły najlepiej
zajrzeć do [dostępnych w repozytorium](http://github.com/apohllo/poliqarpr/tree/master/spec/) speców.

#### Przykład użycia

Przypuśćmy, że mamy na naszym komputerze korpus języka polskiego o wielkości 250 mln segmentów, pobrany ze
[strony korpus.pl](http://korpus.pl/download/2.all.250.bin.tar.bz2).
Załóżmy, że znajduje się w katalogu `/home/user/korpus`. Co należy zrobić, aby można było go wygodnie przeglądać lub wykorzystać
w programie napisanym w Rubim?

Po pierwsze musimy upewnić się, że serwer poliqarp jest zainstalowany i działa. Najprościej wykonać w linii poleceń następującą komendę:

code(bash).
$ poliqarpd &

Jeśli nie pojawią się żadne błędy, oznaczać to będzie, że serwer poliqarp został uruchomiony.

Następnie możemy skorzystać z serwera w programie napisanym w Rubim.
Na wstępie musimy załadować zainstalowany wcześniej gem, stworzyć klienta oraz załadować korpus:

code(ruby).
require 'poliqarpr'
client = Poliqarp::Client.new("TEST")
client.open\_corpus("/home/user/korpus/all")
client.right\_context = 10
client.left\_context = 10
client.lemmata = :all
client.buffer\_size = 1000

Kiedy tworzymy klienta, możemy przekazać opcjonalny parametr będący nazwą sesji z serwerem (pozwala odróżniać od siebie
wiele jednocześnie połączonych klientów). Potem możemy otworzyć korpus (polecenie `open_corpus`), podając ścieżkę do jego katalogu, wraz z nazwą
(tutaj używamy korpusu 250 mln segmentów, którego nazwa to "all").

Opcjonalnie możemy również ustawić różne parametry dot. zwracanych rezultatów:

-   rozmiar prawo- i lewostronnego kontekst
-   szczegóły opisu segmentów
-   rozmiar bufora wyników, itp.

Kiedy dokonamy tych wstępnych ustaleń, możemy pobrać wyniki, dla wybranego zapytania (szczegóły składni języka zapytań omówione są
w artykule na [stronie dr. hab. Adama Przepiórkowskiego](http://nlp.ipipan.waw.pl/~adamp/Papers/2004-corpus/)):

code(ruby).
result = client.find("\[base=kot\]")
result\[0..5\].each do |excerpt|
putes excerpt
end
\# – kukułka – piła – kot Zaznacz te obrazki, które
\# burza osy – ptaki – kot ptak – zegar – samochód
\# – orkiestra – telefon – kot Posłuchaj uważnie nagranych dźwięków i
\# ptaszek – burza lew – kot lecąca z kranu woda –
\# strumyk telefon – sowa – kot baran – lew – ptaszek

W powyższym przykładzie szukamy w korpusie wszystkich fragmentów, w których występuje wyraz "kot" w dowolnej formie.
Następnie wyświetlany 6 pierwszych rezultatów. Każdy z rezultatów jest jednak pełnoprawnym obiektem, więc możemy
przyjrzeć mu się szczegółowo:

code(ruby).
result\[0\].author
\#=&gt; Małgorzata Pamuła
result\[0\].title
\#=&gt; Wczesne nauczanie języków obcych...
result\[0\].short\_context.join("")
\#=&gt; – kukułka – piła – kot Zaznacz te obrazki, które

API w chwili obecnej jest nieźle rozbudowane i udokumentowane, więc nie będę omawiał go szczegółowo.

Na koniec nie możemy zapomnieć o zamknięciu połączenia z serwerem:

code(ruby).
client.close
