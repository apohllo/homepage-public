---
title: Typy danych
date: '2007-08-17T20:39:00Z'
lastmod: '2010-01-30T09:37:13Z'
draft: false
tags:
- ruby
author: 213.134.160.231
toc: true
---

[Poprzedni rozdział](/dydaktyka/ruby/intro/do-dziela) |
[Następny rozdział](/dydaktyka/ruby/intro/struktury-jezyka)

Grupy typów danych
------------------

Chociaż w języku Ruby nie występują typy prymitywne (takie jaki występujący w
Javie typ `int`, który posiada swój obiektowy odpowiednik `Integer`),
to można w nim wyróżnić trzy grupy typów danych:

-   typy podstawowe
-   typy wbudowane
-   pozostałe

Należy zauważyć, że wartości typów należących do wszystkich grup
traktowane są przez interpreter (niemal) identycznie - każda wartość
jest **obiektem**, należącym do określonej **klasy obiektów**.
Wynika to z podstawowego założenia języka, czyli jego obiektowego
zorientowania, a jednym z jego efektów jest *zunifikowane* traktowanie
wszystkich wartości (np. liczb, łańcuchów, tablic i innych struktur danych,
a także samych klas), które mogą pojawić się w programie. W konsekwencji
programy napisane w Ruby są bardzo spójne pod względem składni - nie
występują osobne sposoby manipulowania liczbami, łańcuchami, tablicami,
czy obiektami innych typów. Jeśli jakąś konstrukcję językową można
zastosować w stosunku do liczb (np. składnię operatorową, jak w wyrażeniu
`1 + 2`), to można również zastosować ją w stosunku do typów zdefiniowanych
przez użytkownika, i *vice versa*.

Dlaczego zatem wyróżniliśmy te trzy grupy typów danych?

Otóż składnia języka wspiera tworzenie obiektów należących
do **typów podstawowych**. Aby stworzyć nowy łańcuch (obiekt klasy String)
lub wyrażenie regularne (obiekt klasy Regexp) nie trzeba wywoływać konstruktora *explicite*
(tzn. String.new("abc"), Regexp.new("abc")).
Zamiast tego wystarczy napisać "abc" czy /abc/ i odpowiedni obiekt jest tworzony.
Pozwala to oczywiście na wygodniejsze tworzenie obiektów typów należących do tej grupy.

**Typy wbudowane** to typy, które dostarczane są wraz ze standardową implementacją Ruby.
Charakterystyczne jest dla nich to, że ich wykorzystanie nie wymaga dołączania
żadnych zewnętrznych bibliotek (np. za pomocą dyrektywy **require**)
- są one dostępne "od zaraz". Wśród typów tych możemy wymienić np. `Time`.

**Pozostałe typy** danych to typu zdefiniowane przez użytkownika oraz typy
zdefiniowane w zewnętrznych bibliotekach. Warto zwrócić uwagę, że ze standardową
implementacją Ruby rozprowadzane są biblioteki, zawierające sporo interesujących
typów danych, które jednak nie należą do typów wbudowanych. Wśród nich można
wymienić np. klasę **Net::HTTP**, która znajduje się w bibliotece **Net** i pozwala
pobierać dokumenty hipertekstowe za pomocą protokołu HTTP.

W dalszej części tego rozdziału omawiamy wyłącznie typy podstawowe.
Omówienie typów wbudowanych i biblioteki standardowej Ruby
znacząco przekracza ramy niniejszego wprowadzania.
Typy te zostały szczegółowo opisane w [api Ruby](http://corelib.rubyonrails.org/)
oraz w [api biblioteki standardowej Ruby](http://www.ruby-doc.org/stdlib/)
Definiowanie typów użytkownika zostało zaś omówione w rozdziale poświęconym [obiektowości](/dydaktyka/ruby/intro/klasy/).

Typy podstawowe
---------------

Do grupy typów podstawowych należą:

-   liczby (Fixnum, Bignum, Float)
-   przedziały (Range)
-   łańcuchy znaków (String)
-   symbole (Symbol)
-   wyrażenia regularne (Regexp)
-   tablice zwykłe (Array)
-   tablice asocjacyjne (Hash)
-   wartości logiczne i nil (TrueClass, FalseClass, NilClass)
-   klasy i moduły (Class, Module) - omówione w rozdziale dot. [obiektowości](/dydaktyka/ruby/intro/klasy)

### Liczby (Fixnum, Bignum, Float)

Liczby typu **Fixnum** to liczby całkowite, które "mieszczą się" w \_natywnym słowie maszyny
-1 bit\_. Znaczy to mniej więcej tyle, że operacje arytmetyczne wykonywane
na liczbach tego rodzaju realizowane są sprzętowo. Jeśli wynik jakiejś operacji
na nich nie mieści się w słowie maszynowym, to następuje automatyczna
konwersja do typu **Bignum**. Odwrotna konwersja ma miejsce, jeśli wartość liczby
typu Bignum, może być reprezentowana w postaci liczby typu Fixnum.

W zachowaniu tym nie ma oczywiście nic nadzwyczajnego. Ważniejsze natomiast jest to,
w jaki sposób interpretowane są operacje na liczbach. Osoby, które miały do
czynienia z językiem programowania Smalltalk, mogą obawiać się, że skoro w Ruby
jest tak bardzo zorientowany obiektowo, to operacje arytmetyczne wykonywane
będą nie w "matematycznym" (tj. zgodnie z priorytetami operatorów matematycznych),
lecz "obiektowym" (tj. zawsze od lewej do prawej) porządku,
jak to miało miejsce w Smalltalku.

Na szczęście Ruby nie posiada takich pułapek - operatory matematyczne zachowują
swoje naturalne priorytety. Dzięki temu poniższe działania dają taki sam wynik
(w nawiasie podana jest interpretacja tych wyrażeń w *notacji obiektowej*):

code(ruby).
1 + 2 \* 3 \# 1.+(2.\*(3))
\#=&gt; 7
2 \* 3 + 1 \# 2.\*(3).+(1)
\#=&gt; 7

W tym miejscu warto zwrócić uwagę, że w klasach można definiować metody, których
nazwy są nazwami operatorów (np. +, -, /), dzięki
czemu dla obiektów tych klas można zastosować **składnię operatorową**, taką samą
jak w przypadku liczb. Nieraz zatem spotkamy się z zapisem a + b,
gdzie a i b to nie liczby, lecz np. tablice. W przypadku tablic wynikiem tego
działania będzie tablica składająca się z elementów pierwszej i drugiej tablicy
(będąca "sumą" tych tablic). Użytkownika zaś może dostarczyć własnych interpretacji
tego operatora w dowolnych klasach, nie wykluczając klas wbudowanych.

Ponieważ liczby są pełnoprawnymi obiektami, rozszerzając klasę Fixnum można w łatwy sposób
zapisywać wartości liczbowe należące do różnych dziedzin. Przykładowo: framework
Rails rozszerza klasę Fixnum o metody będące nazwami jednostek czasu. Dzięki
temu możemy napisać:

code(ruby).
1.hour + 5.minutes
\#=&gt; 3900

Nie trzeba chyba podkreślać jak bardzo wpływa to na czytelność kodu!

[Pełny opis klasy `Fixnum`](http://www.ruby-doc.org/core/classes/Fixnum.html) |
[`Bignum`](http://www.ruby-doc.org/core/classes/Bignum.html)

### Przedziały (Range)

**Przedział** (zwany również **zakresem**) to typ danych dosyć rzadko
spotykany w językach programowania.
Pozwala on na łatwe określanie grup obiektów o charakterze sekwencyjnym.

Składnia przedziałów jest bardzo prosta:

code(ruby).
(1..10)
\#=&gt; 1..10
(1...10)
\#=&gt; 1...10

Tworząc przedział podaje się dwie skrajne wartości otoczone nawiasami okrągłymi i oddzielone
dwoma lub trzeba kropkami. Różnica w ilości kropek określa czy górny kres przedziału
należy do niego (dwie kropki), czy nie (trzy kropki).

Ważną cecha przedziałów jest to, że ilość pamięci zajmowanej przez przedział niezależna
jest od jego wielkości. Dopiero przekształcenie przedziału (np. w tablicę)
powoduje zaalokowanie ilości pamięci odpowiadającej rozmiarowi przedziału.

Metoda, która zamienia przedział na tablicę to **to\_a**:

code(ruby).
(1..10).to\_a
\#=&gt; \[1, 2, 3, 4, 5, 6, 7, 8, 9, 10\]
(1...10).to\_a
\#=&gt; \[1, 2, 3, 4, 5, 6, 7, 8, 9\]

Istotną cechą przedziałów jest również to, że są one wykorzystywane *implicite*
w operatorze indeksowania \[\], co pozwala z jednej strony pominąć przy indeksowaniu
nawiasy okrągłe (zamiast pisać `a[(1..2)]`, piszemy po prostu `a[1..2]`),
z drugiej zaś pozwala na łatwe tworzenie uogólnionych operatorów
indeksowania, która akceptują pojedyncze wartości jak i zakresy (więcej na temat
operator indeksowania można znaleźć w punkcie poświęconym tablicom).

[Pełny opis klasy `Range`](http://www.ruby-doc.org/core/classes/Range.html)

### Łańcuchy znaków (String)

**Łańcuchy znaków**, zwane również napisami, to typ danych, który występuje w większości
języków programowania. Są one ważne z wielu względów - oczywiście najważniejszy
polega na tym, że mogą być bezpośrednio prezentowane użytkownikowi. Ponieważ
często zachodzi potrzeba prezentowania również wartości innych typów, każdy
obiekt może być skonwertowany do łańcucha za pomocą metody `to_s`.

Tak jak w innych językach, w Ruby łańcuchy są ciągami
liter ujmowanymi w pojedyncze lub podwójne cudzysłowy, np. 'Ruby', czy "Ruby".
Łańcuchy ujęte w pojedynczy cudzysłów są jednak traktowane inaczej, niż
łańcuchy ujęte w podwójny - w drugim przypadku w łańcuchach możemy dokonywać
podstawień, podczas gdy w pierwszy łańcuch traktowany jest literalnie.

Aby dokonać podstawienia w łańcuchu należy objąć fragment kodu Ruby w parę nawiasów
klamrowych poprzedzonych haszem: \#{...} Kod który pojawia się wewnątrz nawiasów
klamrowych jest ewaluowany, a jego wartość (po skonwertowaniu za pomocą wywołania `to_s`)
podstawiana jest w miejsce nawiasów.
Kod występujący w nawiasach nie musi ograniczać się do nazwy zmiennej -
można stosować dowolne konstrukcje języka, a bloki tego rodzaju można zagnieżdżać:

code(ruby).
imie = "Ala"
"\#{imie} to grzeczna dziewczynka"
\#=&gt; "Ala to grzeczna dziewczynka"

code(ruby).
imiona = \[ "Grześ", "Bartek", "Jacek" \]
"Chłopcy: \#{imiona.join(" i ")} idą na spacer"
\#=&gt; "Chłopcy: Grześ i Bartek i Jacek idą na spacer"

code(ruby).
jeden = "1"
dwa = "2"
"\#{jeden + " \#{dwa} " }"
\#=&gt; "1 2 "

code(ruby).
jeden = "1"
'\#{jeden}'
\#=&gt; "\\\#{jeden}"

Oczywiście nie należy przesadzać ze stosowaniem tego rodzaju konstrukcji, gdyż
powodują one, że kod staje się mało czytelny.

Jeśli zachodzi potrzeba wprowadzenia dłuższego fragmentu tekstu,
można skorzystać z trzeciego sposobu definiowania łańcuchów znaków,
tzw. *HereDocs*. Łańcuch taki rozpoczyna się od dwóch znaków relacji mniejszości '&lt;', po
których następuje słowo, które pojawiając się na początku linii oznacza
koniec łańcucha. Dodatkowo, jeśli słowo to poprzedzone jest znakiem '-',
to przy ustalaniu końca łańcucha ignorowane są białe spacje, występujące
przed tym słowem:

code(ruby).
wierszyk = &lt;&lt;END
Siała Baba mak
Nie wiedziała jak
Dziadek wiedział
Nie powiedział
A to było tak...
END

Należy również zwrócić uwagę, że wewnątrz takiego długiego łańcucha
dokonywane są podstawienia w wyrażeniach ujętych w nawiasy klamrowe `#{...}`.

Łańcuchy znaków są modyfikowalne, tzn. że ich modyfikowanie nie powoduje
zmiany ich identyfikatora.
Ponadto przy modyfikacjach łańcuch zajmuje ten sam obszar
pamięci (o ile nie wzrasta jego długość). Dzięki temu operacje na łańcuchach są
wydajne.

code(ruby).
str1 = "Pszczółka Maja"
\#=&gt; "Pszczółka Maja"
str1.object\_id
\#=&gt; -607662428
str1.sub!("M","m")
\#=&gt; "Pszczółka maja"
str.object\_id
\#=&gt; -607662428

Metoda sub powoduje zastąpienie pierwszego podciągu identycznego z pierwszym argumentem,
argumentem drugim. Występuje ona w dwóch wersjach: z wykrzyknikiem i bez.
Wersja **z wykrzyknikiem** powoduje **zmodyfikowanie oryginalnego łańcucha**, natomiast
wersja **bez wykrzyknika, nie modyfikuje go**, lecz zwraca kopię, która stanowi zmodyfikowaną
wersję łańcucha. Jest to ogólna konwencja Ruby - **wykrzyknik** na końcu nazwy metody,
oznacza, że jest ona **potencjalnie destrukcyjną** wersją metody o tej samej nazwie. Istnieje również inna
podobna konwencja - **znak zapytania** oznacza metodę, która zwraca **wartość logiczną**.

Inne metody tego rodzaju, które
zaimplementowane są w klasie String, to m.in. :

-   strip! (usuwa białe znaki na początku i końcu łańcucha)
-   gsub! (dokonuje podmiany wszystkich podciągów pasujących do wzorca)
-   chop! (usuwa ostatni znak łańcucha)

Wśród ciekawszych metod występujących w klasie String można jeszcze wymienić:

-   capitalize (zamienia pierwszą literę na dużą, pozostałe na małe)
-   upcase (zamienia wszystkie litery na duże)
-   downcase (zamienia wszystkie litery na małe)
-   squeeze (usuwa powtarzające się znaki występujące w bezpośrednim sąsiedztwie)

Uwaga

Obsługa Unicode w Ruby nie jest niestety doskonała. Język ten zasadniczo operuje
na bajtach a nie znakach, przez co metody takie jak `length` (długość łańcucha), nie
biorą pod uwagę czy łańcuch nie jest zakodowany np. w UTF8. Sytuacja ta zmieniła się
w Ruby 1.9 (w chwili pisania tego rozdziału nie jest on jeszcze przeznaczony do
rozwiązań produkcyjnych). Ponadto we frameworku Rails zaimplementowano lepszą obsługę znaków
wielobajtowych. Również w implementacji JRuby, która bazuje na Javie, obsługa znaków
jest zaimplementowana o wiele lepiej (korzysta z świetnej implementacji Unicode w Javie).

Więcej informacji na temat łańcuchów w Ruby 1.8 można znaleźć na stronie [ruby-rails.pl](http://ruby-rails.pl/polskie-literki-w-ruby-on-rails)
natomiast znakomity opis możliwości wersji 1.9 (w tym ulepszeń związanych
z obsługą łańcuchów znaków) znajduje się na [blogu Radarka](http://radarek.jogger.pl/2007/12/31/ruby-1-9-wydany-opis-glownych-zmian-i-nowosci/)

[Pełny opis klasy `String`](http://www.ruby-doc.org/core/classes/String.html)

### Symbole (Symbol)

**Symbole** składają się z nazwy poprzedzonej dwukropkiem, np. `:Symbol`.
Ten typ danych występuje przede wszystkim w symbolicznych językach programowania
(dobrym przykładem jest tutaj LISP). To co charakteryzuje obiekty typu symbolicznego
to jednoznaczność ich tożsamości - nie mogą występować dwa symbole, które wyglądałyby
identycznie, a posiadały inną wartość (mamy tutaj do czynienia z sytuacją wprost przeciwną
do tego co w językach naturalnych nazywane jest [zjawiskiem homonimii](/dydaktyka/nlp)).

W kontekście Ruby oznacza to, że niezależnie od tego co w określonym kontekście oznacza
jakaś nazwa (stałą, zmienną czy nazwę metody), symbol wygenerowany na jej podstawie
jest zawsze ten sam (o ile nazwa jest identyczna). Własności tej nie posiadają
w Ruby łańcuchy znaków - pomimo tego, że dwa łańcuchy znaków wyglądają identycznie,
nie muszą być tym samym obiektem. Możemy się o tym przekonać wywołując metodę **object\_id**,
która zwraca wewnętrzny identyfikator obiektu:

code(ruby).
s1 = :Krolis
s2 = :Krolis
str1 = "Alicja"
str2 = "Alicja"
s1.object\_id  s2.object\_id
\#=&gt; true
str1.object\_id  str2.object\_id
\#=&gt; false

W tym miejscu warto wspomnieć, że własność jednoznaczności obejmuje również
liczby (ale tylko te, które są instancjami klasy `Fixnum`), a także
jedyne instancje klas `NilClass`, `TrueClass` oraz `FalseClass`. Jedną
z konsekwencji tego stanu rzeczy jest to, że w wywołaniach funkcji
obiekty tych klas zawsze przekazywane są przez wartość, a nie przez
referencję.

Symbole w Ruby wykorzystywane są często jako klucze tablic asocjacyjnych i
(pośrednio) jako nazwy argumentów w wywołaniach funkcji. Zastosowanie
symboli (w przeciwieństwie do łańcuchów) jako kluczy tablic asocjacyjnych
ma swoje podwójne uzasadnienie. Po pierwsze takie rozwiązanie jest bardziej wydajne,
po drugie zaś, ze względu na możliwość modyfikacji łańcuchów znaków, wykorzystanie
ich jako kluczy może prowadzić do niepożądanych konsekwencji. Jeśli jakiś łańcuch
został użyty jako klucz tablicy asocjacyjnej, a następnie został zmodyfikowany,
to informacja ta nie zostanie odzwierciedlona w tablicy asocjacyjnej!
Wartość przechowywana w tablicy będzie bowiem dostępna wyłącznie pod starą nazwą.

code(ruby).
key = "Jabłko"
histogram\[key\] = 10
key.sub<img src="
#=&gt; &quot;Jabłka&quot;
histogram[&quot;Jabłka&quot;]
#=&gt; nil " alt="" class="&quot;a&quot; &quot;o&quot;," />![]()
histogram\["Jabłko"\]
\#=&gt; 10
key
\#=&gt; "Jabłka"

Uwaga!

W powyższym kodzie wykorzystywane są tablice asocjacyjne, które omówione są w dalszej
części tego rozdziału, dlatego jeśli kod ten jest niezrozumiały, można do niego wrócić
później. Istotne było pokazanie niebezpieczeństwa jakie kryje się w wykorzystaniu łańcuchów
jako kluczy tablic asocjacyjnych.

Powyższy problem nie może pojawić się jeśli w tablicy jako kluczy użyje się symboli,
gdyż są one niemodyfikowalne, a inna nazwa symbolu, to po prostu inny symbol.

Symbole nie są jednak stosowane wyłącznie jako klucze tablic asocjacyjnych
- można ich używać zwykle tam, gdzie istotna jest wyłącznie
nazwa, a nie łańcuch znaków jako taki. Dlatego też symbole wykorzystuje się często
w meta-programowaniu, np. jako argumenty meta-metod operujących na metodach czy
zmiennych (*vide* `attr_accessor :elements`).

[Pełny opis klasy `Symbol`](http://www.ruby-doc.org/core/classes/Symbol.html)

### Wyrażenia regularne (Regexp)

O wyrażeniach regularnych napisano już [niejedną książkę](http://www.oreilly.com/catalog/regex/), dlatego też nie zamierzam rozpisywać
się na ten temat. Wyrażenia regularne w Ruby inspirowane są wyrażeniami Perlowymi,
co w szczególności dotyczy ich konstruowania (/regexp/), dopasowywania ( =~) oraz
przypisywania wartości pewnym predefiniowanym zmiennym globalnym ($\`, $&, $').

W pierwszej chwili wydawać by się mogło, że konstrukcje tego rodzaju są jakimś
dziwnym nieobiektowym wtrętem w Ruby. Nic podobnego nie ma jednak miejsca - otóż
wyrażenia regularne są pełnoprawnymi obiektami, dlatego też można z nich korzystać
na modłę obiektową.

Dwa sposoby korzystania z wyrażeń regularnych ilustrują poniższe przykłady:

code(ruby).
name = ”Matz”
name =∼ /(\[\[:lower:\]\]{2})/
\#=&gt; 1
$‘
\#=&gt; ”M”
$1
\#=&gt; ”at”
$’
\#=&gt; ”z”

code(ruby).
re = Regexp.new(”(\[\[:lower:\]\]{2})”)
md = re.match(name)
\#=&gt; \#<MatchData:0xb7d41054>
md.pre\_match
\#=&gt; ”M”
md.value\_at 1
\#=&gt; ”at”
md.post\_match
\#=&gt; ”z”

Wyrażenia regularne wykorzystywane w obu przykładach są oczywiście identyczne -
dopasowują się one do dwóch małych liter. W pierwszym przykładzie zastosowana
jest "perlowa" składnia tworzenia wyrażeń regularnych z wykorzystaniem *slashy*
oraz operatora dopasowania (=~). Widzimy, że przy dopasowaniu zakończonym sukcesem
do zmiennych globalnych $\`, $&, $' (a także kilku innych) przypisywane są
fragmenty łańcucha stojące odpowiednio przed, wewnątrz i po dopasowanym wyrażeniu.
W przypadku niedopasowania wyrażenia, zmiennym tym przypisywana jest wartość `nil`.

Metoda =~ w przypadku powodzenia zwraca
indeks pierwszej dopasowanej litery, zaś w przypadku niepowodzenia zwraca wartość `nil`.
Dzięki temu można ją stosować w instrukcji warunkowej, aby sprawdzić czy dany
łańcuch pasuje do określonego wyrażenia regularnego.

W składni obiektowej konieczne jest jawne wywołanie konstruktora wyrażenia regularnego
Regexp.new("..."), w wyniku którego tworzony jest obiekt reprezentujący to wyrażenie.
Obiekt ten posiada metodę `match`, która dopasowuje wyrażenie do łańcucha
przekazanego jako jej argument. W wyniku poprawnego
dopasowania tworzony jest obiekt MatchData, który zawiera informacje o dopasowaniu
(metody `pre_match` i `post_match` odpowiadają zmiennym $\` i $', natomiast `value_at`
zwraca n-tą dopasowana podgrupę).

Wydawać by się mogło, że zaprezentowane sposoby używania wyrażeń regularnych są
niekompatybilne - nic bardziej mylnego. Zarówno operator =~ przyjmuje po prawej
stronie obiekt tworzony za pomocą konstruktora obiektowego, jak i metoda
`match` powoduje przypisanie odpowiednich wartości do predefiniowanych zmiennych
globalnych.

Wyrażenia regularne są wykorzystywane w wielu metodach operujących na łańcuchach
znaków. Wspomniana wcześniej metoda `sub` jako pierwszy parametr przyjmuje
również wyrażenie regularne. Aby odwołać się w *łańcuchu zastępującym* do podgrup
występujących w wyrażeniu, można skorzystać z perlowej składni, gdzie numer
podgrupy poprzedzony jest *backslashem*:

code(ruby).
global\_truth = "Nikt nam nie wmowi, ze czarne to czarne a biale to biale"
global\_truth.sub(/(\\w\*) a (\\w\*) to (\\w\*)/,"\\\\2 a \\\\3 to \\\\1")
\#=&gt; "Nikt nam nie wmowi, ze czarne to biale a biale to czarne"

[Pełny opis klasy `Regexp`](http://www.ruby-doc.org/core/classes/Regexp.html)

### Tablice zwykłe (Array)

**Tablice zwykłe**, zwane po prostu tablicami, to typ danych, który występuje w
większości języków programowani. Tym niemniej nawet w tak obiektowo zorientowanym
języku jak Java, nie są one pełnoprawnymi obiektami - metody sortowania, czy
znajdowania elementów wywoływane są jako statyczne metody klasy Arrays, a nie
jako metody instancyjne tablicy. Według mojej skromnej wiedzy na temat
Pythona, również w tym języku tablice nie są do końca traktowane obiektowo
(np. metoda *length* nie jest metodą instancyjną).

Na szczęście, zgodnie z zasadą, że wszystko jest obiektem, w Ruby tablice również
są pełnoprawnymi obiektami. Co nie zmienia faktu, że można je definiować i
przekształcać w bardziej tradycyjny i naturalny sposób.

Tablice najczęściej **tworzy się** umieszczając poszczególne \*wartości oddzielone
przecinkiem wewnątrz nawiasów kwadratowych\*. Znacznie ciekawszym sposobem
tworzenia tablic jest wykorzystanie bloku kodu, który pozwala zainicjować
tablicę wartościami wyliczonymi na podstawie indeksu:

code(ruby).
a = \[ "zero", "one", "two", "three"\]
\#=&gt; \[ "zero", "one", "two", "three"\]
b = Array.new(5) {|i| i\*i}
\#=&gt; \[0, 1, 4, 9, 16\]

Uwaga

Bloki kodu omówione zostały w rozdziale następnym. Tym niemniej w przykładach dotyczących
tablic będą się one wielokrotnie pojawiać, gdyż dzięki temu można zobaczyć
olbrzymią potęgę drzemiącą w tej strukturze języka. Jeśli przykłady te będą jednak
niezrozumiałe, warto wrócić do nich po zapoznaniu się z informacjami dotyczącymi bloków.

Tablice **indeksowane** są **od zera**,
ale można wykorzystywać również popularne w językach skryptowych indeksy ujemny -
ostatni element ma indeks -1, poprzedzający go -2, itd. Jeśli indeks wykracza
poza zakres tablicy zwracana jest wartość `nil`. Aby odwołać się do obiektu o określonym
indeksie stosujemy **operator indeksowania \[\]**:

code(ruby).
a = \[ "zero", "one", "two", "three"\]
a\[0\]
\#=&gt; "zero"
a\[-1\]
\#=&gt; "three"
a\[-2\]
\#=&gt; "two"
a\[10\]
\#=&gt; nil
a\[-1\] = "trzy"
\#=&gt; "trzy"
a
\#=&gt; \[ "zero", "one", "two", "trzy" \]

Tablice można również **indeksować zakresami**, wtedy zamiast pojedynczej wartości
otrzymamy tablicę składającą się z elementów mieszczących się w zadanym zakresie.
Jeśli zadany zakres i zakres poprawnych indeksów nie mają elementów wspólnych,
zwracana jest tablica pusta.

code(ruby).
a = \[ "zero", "one", "two", "three"\]
a\[0..2\]
\#=&gt; \[ "zero", "one", "two" \]
a\[0...2\]
\#=&gt; \[ "zero", "one" \]
a\[2..-1\]
\#=&gt; \[ "two", "three" \]
a\[10..20\]
\#=&gt; \[\]

W tablicy można przechowywać obiekty dowolnego typu, nie wykluczając samych tablic
Co więcej - w jednej tablicy można przechowywać inne tablice, tworząc tablice wielowymiarowe.
Aby odwołać się do elementów takiej wielowymiarowej tablicy należy skorzystać
wielokrotnie z operatora indeksowania:

code(ruby).
matrix = \[\[1,2,3\],\[3,4,5\],\[5,6,7\]\]
matrix\[1\]
\#=&gt; \[3, 4, 5\]
matrix\[1\]\[1\]
\#=&gt; 4
matrix\[1,1\]
\#=&gt; \[\[3, 4, 5\]\]

Próba przekazania dwóch indeksów w jednym operatorze indeksowania spowodowała
zwrócenie podtablicy tablicy `matrix`, a nie liczby 4, ponieważ ten zapis interpretowany
jest jako alternatywna definicja zakresu. Dlatego `matrix[1,1]` tożsame jest z `matrix[1..1]`
a nie `matrix[1][1]`.

W tablicy można przechowywać razem obiekty różnych typów. W zasadzie nie powinno to powodować
jakiś nieprzyjemnych konsekwencji, ale jeśli chcemy w ten sposób budować struktury
danych, gdzie indeksy odpowiadają poszczególnym polom, to jest to rozwiązanie
zdecydowanie odradzane (do tego celu została stworzona klasa [`Struct`](http://www.ruby-doc.org/core/classes/Struct.html)).
Ponadto przy próbie posortowania takiej tablicy może pojawić się błąd (patrz poniższe
przykłady).

Klasa `Array` posiada mnóstwo przydatnych metod, wśród których można wyróżnić kilka grup:

-   metody **operatorowe** - pozwalają operować na tablicach jak na abstrakcyjnych obiektach
    matematycznych, np.:
    -   + zwraca tablicę, która jest sumą dwóch tablic
    -   - zwraca tablicę, która jest różnica tablicy pierwszej i drugiej
    -   &lt;&lt; dodaje element na końcu tablicy
    -   & zwraca tablicę, która jest częścią wspólną (iloczynem) dwóch tablic
-   metody **blokowe** - akceptują blok kodu, który wykonywany jest dla wszystkich
    elementów tablicy, np.:
    -   `delete_if` - usuwa element tablicy jeśli blok zwraca wartość `true`
    -   `collect` - tworzy tablicę, która składa się z elementów zwróconych przez blok
    -   `each` - wykonuje blok kodu dla każdego elementu tablicy
    -   `reject` - tworzy nową tablicę, z elementów dla których blok zwrócił wartość `false`
    -   `reverse_each` - wykonuje blok kodu dla każdego elementu tablicy, poczynając od ostatniego
    -   `select` - zwraca tablicę składającą się z elementów, dla których blok zwrócił
        wartość `true`
-   **pozostałe** metody - wśród nich warto zwrócić uwagę na:
    -   `empty?` - zwraca wartość `true`, jeśli tablica jest pusta
    -   `join` - zwraca łańcuch znaków, który powstaje z łańcuchowych reprezentacji elementów tablicy połączonych opcjonalnym łącznikiem
    -   `include?` - zwraca wartość `true` jeśli tablica zawiera określoną wartość
    -   `push` - dodaje element na końcu tablicy (działanie identyczne do &lt;&lt;)
    -   `reverse` - zwraca tablicę, w której elementy ułożone są w porządku odwrotnym
    -   `shift` - usuwa pierwszy element tablic i zwraca go
    -   `sort` - sortuje tablice w sposób naturalny (akceptuje również blok, który pozwala
        określić dowolny porządek sortowania)

Ponieważ szczegółowe omówienie wszystkich metod klasy `Array` wystarczyłoby na napisanie
niewielkiej książki, ograniczamy się jedynie do przedstawienia kilku przykładów
wykorzystania powyższych metod. Więcej przykładów można znaleźć oczywiście w [API tej klasy](http://www.ruby-doc.org/core/classes/Array.html)

#### Metody operatorowe

code(ruby).
\[ 1, 2, 3 \] + \[ 4, 5 \]
\#=&gt; \[ 1, 2, 3, 4, 5 \]
\[ 1, 2, 3 \] - \[ 1, 3 \]
\#=&gt; \[ 2 \]
a = \[ 1, 2, 3 \]
a &lt;&lt; 4
\#=&gt; \[ 1, 2, 3, 4 \]

#### Metody blokowe

code(ruby).
zenskie = \[ "Janek", "Jozef", "Kasia", "Ania", "Wojtek" \].delete\_if {|name| name !~ /a$/ }
\#=&gt; \["Kasia", "Ania"\]
duza\_litera = \[ "ania", "kasia" \].collect{|name| name.capitalize }
\#=&gt; \["Ania", "Kasia"\]
literki = \[ "a", "b", "c" \].each{|l| puts l}
\# a
\# b
\# c
\#=&gt; \["a", "b", "c" \]

#### Pozostałe metody

code(ruby).
\[\].empty?
\#=&gt; true
zawiera\_dwa = \[1,2,3\].include?(2)
\#=&gt; true
grzybki = \[ "kurka", "kania", "muchomor" \]
grzybki.join(", ")
\#=&gt; "kurka, kania, muchomor"
kolejka = \[ "pierwszy", "drugi", "trzeci" \]
kolejka.shift
\#=&gt; "pierwszy"
\# kolejka = \[ "drugi", "trzeci" \]
priorytety = \[ 7, 5, 3, 4, 8\].sort
\#=&gt; \[ 3, 4, 5, 7, 8 \]
macierz = \[\[1,2\],\[2,1\],\[2,2\],\[1,1\]\]
macierz.sort
\#=&gt; \[\[1,1\],\[1,2\],\[2,1\],\[2,2\]\]
macierz.sort{|e1,e2| e1\[1\] == e2\[1\] ? e1\[0\] &lt;=&gt; e2\[0\] : e1\[1\] &lt;=&gt; e2\[1\]}
\#=&gt; \[\[1, 1\], \[2, 1\], \[1, 2\], \[2, 2\]\]

Metoda `sort` wymaga nieco więcej uwagi. Wywołanie jej dla tablicy
bez opcjonalnego bloku, powoduje posortowanie elementów wg *naturalnego porządku*,
który definiowany jest za pomocą operatora porównania `<=>`.
Operator ten zwraca wartość ujemną jeśli pierwszy element jest mniejszy
od drugiego, 0 jeśli są równie, natomiast wartość dodatnią w przypadku
przeciwnym. ~~Nie zawsze jest to działanie pożądane~~ w przypadku macierzy
chcieliśmy uzyskać sortowanie słownikowe, ale metoda `<=>` bierze pod uwagę
wyłącznie rozmiar tablic- (Tak było w Ruby 1.8.5). W przypadku tablicy
brana jest pod uwagę jej długość oraz zawartość (poszczególne elementy porównywane
są parami). Można jednak zmienić to domyślne zachowanie, przekazując do metody
blok, w który określamy interesujący nas porządek.

Ten sam mechanizm może być zastosowany, jeśli w tablicy znajdują się obiekty typów,
które są ze sobą nieporównywalne:

code(ruby).
dziwna1 = \[ 2, 3, "a" \].sort
\# ArgumentError: comparison of String with 2 failed...
dziwna2 = \[ 3, 2, "a" \].sort do |a,b|
v1 = a.is\_a?(String) ? a.size : a
v2 = b.is\_a?(String) ? b.size : b
v1 &lt;=&gt; v2
end
\#=&gt; \["a", 2, 3\]

Innym rozwiązaniem tego problemu jest zastosowanie **mechanizmu koercji** (zobacz `coerce`
w [dokumentacji języka](http://www.ruby-doc.org/core/)).

[Pełny opis klasy `Array`](http://www.ruby-doc.org/core/classes/Array.html)

### Tablice asocjacyjne (Hash)

**Tablice asocjacyjne**, zwane również *hashami*, słownikami lub mapami to struktury danych
przypominające zwykłe tablice, lecz indeksowane dowolnymi wartościami.
W Ruby tablice asocjacyjne **tworzy się**, umieszczając w nawiasach klamrowych
oddzielone przecinkami pary *klucz* =&gt; *wartość*. Natomiast **dostęp** do poszczególnych
wartości odbywa się w taki sam sposób jak w przypadku tablic (nazwa tablicy,
po której następuje, ujęty w nawiasy kwadratowe, klucz). W przypadku odwołania
do klucza, który **nie znajduje się** w tablicy domyślnie zwracana jest wartość **`nil`**.

code(ruby).
hash = { "jeden" =&gt; 1, "dwa" =&gt; 2, "trzy" =&gt; 3 }
hash\["jeden"\]
\#=&gt; 1
hash\["cztery"\]
\#=&gt; nil
hash\["cztery"\] = 4
hash\["cztery"\]
\#=&gt; 4

Domyślna wartość zwracana w przypadku braku odpowiedniego klucza,
może być jednak zastąpiona, jeśli do konstruktora tablicy asocjacyjnej
przekażemy argument lub jeśli jawnie przypiszemy wartość parametrowi `default`.
Wtedy przy odwołaniu do nieistniejącego klucza zwracana jest wartość domyślna.
Takie rozwiązanie wykorzystywane jest często w przypadku, gdy tablicę
asocjacyjną wykorzystuje się jako sumator wystąpień wartości, np. w programie
do zliczania wystąpień słów w tekście.

code(ruby).
histogram = Hash.new(0)
histogram\["Ala"\]
\#=&gt; 0
histogram\["Ala"\] += 1
histogram\["Ala"\]
\#=&gt; 1

Obiekty, które występują jako klucze porównywane są za pomocą metody `eql?`.
Jeśli modyfikujemy tę metodę w naszej klasie, powinniśmy również zadbać
o implementację metody `hash`, która dla obiektów nieodróżnialnych
przez metodę `eql?` powinna zwracać identyczne wartości liczbowe.

W programach napisanych w Ruby często można spotkać tablice
asocjacyjne **indeksowane symbolami** - najczęściej **w wywołaniach funkcji**.
Rozwiązanie takie jest stosowane w celu symulowania nazwanych, opcjonalnych parametrów
wywołania. Ze względu na jego powszechność, w wywołaniach, w których parametrem
jest tablica asocjacyjna, można pominąć nawiasy, o ile nie prowadzi to do
niejednoznaczności.

code(ruby).
has\_many(:src\_links, :class\_name =&gt; "Link", :foreign\_key =&gt; "src\_id")

W powyższym wywołaniu parametr drugi i trzeci zostaną połączone w jedną
tablicę asocjacyjną. Jest to *de facto* skrót dla poniższego zapisu:

code(ruby).
has\_many(:src\_links, {:class\_name =&gt; "Link", :foreign\_key =&gt; "src\_id"})

Podobnie jak zwykłe tablice, tablice asocjacyjne posiadają wiele wbudowanych
metod. Wśród nich na szczególną uwagę zasługują:

-   `has_key?` - zwraca prawdę, jeśli tablica posiada określony klucz.
-   `has_value?` - zwraca prawdę, jeśli tablica posiada określoną wartość.
-   `each` - wykonuje blok przekazując jako jego parametry parę: *klucz* - *wartość*
-   `each_key` - jw. ale przekazywane są tylko *klucze*.
-   `each_value` - jw. ale przekazywane są tylko *wartości*. Jeśli wartości się powtarzają
    to wywołanie następuje wiele razy dla tych samych wartości.
-   `index` - zwraca klucz, posiadający wartość przekazaną jako parametr wywołania. Jeśli
    jest wiele takich kluczy, to zwracany jest tylko jeden (dowolny).
-   `merge` - zwraca tablicę asocjacyjną, która jest połączeniem tablicy, dla której
    została wywołana ta metoda oraz jej argumentu. Jeśli w obu tablicach występują
    pokrywające się klucze, to wartości wybierane są z drugiej tablicy (przekazanej jako
    parametr). Metoda ta posiada wariant z wykrzyknikiem, który modyfikuje tablicę,
    dla której została wywołana.
-   `select` - przyjmuje blok jako argument.
    Zwraca zwykłą tablicę, która składa się z par \[klucz, wartość\], dla których blok
    zwrócił wartość `true`.

Przykłady wykorzystania powyższych metod przedstawione są poniżej.

code(ruby).
hash = { "jeden" =&gt; 1, "dwa" =&gt; 2, "trzy" =&gt; 3}
hash.has\_key?("jeden")
\#=&gt; true
hash.has\_key?(1)
\#=&gt; false
hash.has\_value?(1)
\#=&gt; true
hash.has\_value?("jeden")
\#=&gt; false
hash.each{|key,value| puts "klucz: \#{key}, wartość: \#{value}" }
\# klucz: jeden, wartość: 1
\# klucz: dwa, wartość: 2
\# klucz: trzy, wartość: 3
\#=&gt; {"jeden"=&gt;1, "dwa"=&gt;2, "trzy"=&gt;3}
hash.index(1)
\#=&gt; "jeden"
hash.index(5)
\#=&gt; nil
hash.merge({ "jeden" =&gt; "I", "dwa" =&gt; "II", "cztery" =&gt; "IV"})
\#=&gt; {"jeden" =&gt; "I", "dwa" =&gt; "II", "cztery" =&gt; "IV", "trzy" =&gt; 3}
hash.select{|key,value| key.match(/d/)}
\#=&gt; \[\["jeden",1\], \["dwa",2\]\]

[Pełny opis klasy `Hash`](http://www.ruby-doc.org/core/classes/Hash.html)

### Wartości logiczne i nil (TrueClass, FalseClass, NilClass)

**Wartości logiczne** (`true`, `false`) oraz **wartość pusta** (`nil`)
są jedynymi instancjami klas odpowiednio: `TrueClass`, `FalseClass` i `NilClass`.
Posiadają one niewielkie API (które w przypadku
wartości logicznych ogranicza się do 4 metod: &, |, ^ oraz `to_s`,
a przypadku wartości pustej ogranicza się do 9 metod: &, |, ^, `inspect?`, `nil?`,
`to_a`, `to_i`, `to_f`, `to_s`) dlatego nie będziemy go szczegółowo omawiać.

Nie można jednak powiedzieć, że klasy te nie ogrywają bardzo istotnej roli
w Ruby. Jest wręcz przeciwnie. \*Testowanie, czy dana zmienna posiada wartość
pustą\* jest jedną z najczęściej spotykanych konstrukcji językowych. Ponieważ
wykonywane jest ono tak często, za pomocą wywołania **`nil?`**, które zdefiniowane
jest dla wszystkich obiektów, można sprawdzić, czy są one wartością pustą.
Jedyny obiekt, który zwraca wartość `true` dla tego wywołania, to oczywiście
wartość pusta:

code(ruby).
a = ""
a.nil?
\#=&gt; false
a = \[\]
a.nil?
\#=&gt; false
a = 0
a.nil?
\#=&gt; false
a = nil
a.nil?
\#=&gt; true

Testowanie tożsamości z wartością pustą pozwala uchronić nas przed sytuacjami, kiedy
do jakiejś zmiennej została przypisana wartość pusta (np. w wyniku wywołania funkcji),
a na zmiennej tej powinna zostać wywołana jakaś metoda, itp.
Tym niemniej testowanie metodą `nil?` nie chroni przed sytuacjami, gdy jakaś \*zmienna
nie została w ogóle zainicjowana.\* Próba sprawdzenia czy niezainicjowana zmienna
posiada wartość pustą spowoduje wygenerowanie błędu:

code(ruby).
zzz.nil?
\# NameError: undefined local variable or method \`zzz'

Aby uchronić się przed tego rodzaju sytuacją można skorzystać z funkcji **`defined?`**,
która zwraca wartość niepustą (jest to informacja o typie zmiennej/stałej),
jeśli dana zmienna została zainicjowana:

code(ruby).
defined? a
\#=&gt; nil
a = 10
defined? a
\#=&gt; "local-variable"
defined? Z
\#=&gt; nil
Z = 10
defined? Z
\#=&gt; "constant"

Wartym odnotowania faktem jest też to, że
przeciwieństwie do wielu innych języków skryptowych, w Ruby \*tylko `false` i `nil`
są traktowane jako fałsz\* w wyrażeniach logicznych. Pusta tablica, wartość 0 czy
pusty łańcuch ewaluowane są jako prawda.

code(ruby).
if false or nil
"True"
else
"False"
end
\#=&gt; "False"
if 0 and \[\] and ""
"True"
else
"False"
end
\#=&gt; "True"

Dodatkowo, jeśli w wyrażeniu logicznym pojawi się łańcuch, generowane jest ostrzeżenie.

[Pełny opis klasy `NilClass`](http://www.ruby-doc.org/core/classes/NilClass.html) |
[`TrueClass`](http://www.ruby-doc.org/core/classes/TrueClass.html) |
[`FalseClass`](http://www.ruby-doc.org/core/classes/FalseClass.html)

[Poprzedni rozdział](/dydaktyka/ruby/intro/do-dziela) |
[Następny rozdział](/dydaktyka/ruby/intro/struktury-jezyka)
