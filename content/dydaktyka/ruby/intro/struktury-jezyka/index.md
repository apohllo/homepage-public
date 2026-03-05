---
title: Struktury języka
date: '2007-10-17T18:17:00Z'
lastmod: '2008-10-24T11:42:22Z'
draft: false
tags:
- ruby
author: 193.138.143.42
toc: true
---

[Poprzedni rozdział](/dydaktyka/ruby/intro/typy-danych) |
[Następny rozdział](/dydaktyka/ruby/intro/klasy)

Uwagi ogólne
------------

Jak można było zauważyć w przykładach znajdujących się w rozdziale [typy danych](/dydaktyka/ruby/intro/typy-danych), \*wyrażenia w Ruby nie muszą
kończyć się średnikiem lub innym separatorem\*. Zazwyczaj koniec linii
jest tożsamy z końcem wyrażenia. Reguła ta może być złamana na dwa sposoby:

-   przez **wstawienie średnika**, wtedy można zapisać kilka wyrażeń w jednej linii
-   przez **zakończenie linii operatorem arytmetycznym, logicznym, otwartym blokiem**, itp.
    Ruby rozpoznaje takie sytuacje, przez co dłuższe wyrażenia mogą być zapisywane
    w kilku linijkach.

Struktury występujące w Ruby zaczynają się zazwyczaj od jakiegoś \*słowa
kluczowego\* (np. `class`, `def`, `if`, `case`) a kończą się \*słowem kluczowym
`end`\*. Wszystko co stoi pomiędzy tymi słowami kluczowymi, traktowane jest jako
ciało rozważanej struktury.

Obok zasady, głoszącej, że wszystko jest obiektem, w Ruby występuje
również zasada głosząca, że **każda poprawna konstrukcja językowa jest wyrażeniem**
(z wyjątkiem bloków..., ale to osobny temat, który zostanie szczegółowo przedstawiony
poniżej). Znaczy to tyle, że w wyniku ewaluacji, każda konstrukcja daje jakąś
wartość. Dla ciągu instrukcji, będzie to wartość otrzymana w wyniku wywołania
ostatniej z nich. W połączeniu z tezą o pełnej obiektowości, rozwiązanie takie pozwala
na łatwe tworzenie ciągów przekształceń danych (jakby na wzór linii poleceń
w systemach unixowych) oraz w większości przypadków pozwala na uniknięcie
jawnego zwracania wartości z funkcji z wykorzystaniem słowa kluczowego `return`
(zwracana jest wartość ostatniego wyrażenie ewaluowanego w metodzie).

Przykładowo, aby w tablicy zawierającej łańcuchy znaków znaleźć trzy o największej,
parzystej długości i zwrócić je w kolejności malejącej długości, wystarczy napisać:

code(ruby).
t = \["jeden", "ala", "bardzo\_długi\_napis", "krotki", "śmieszny", "tamten", "to"\]
t.reject{|e| e.size % 2 != 0}.sort{|e1,e2| e1.size &lt;=&gt; e2.size}.reverse\[0..2\]
\#=&gt; \[ "bardzo\_długi\_napis", "śmieszny", "tamten" \]

Dzięki tej ostatniej własności, zapis funkcji również zyskuje nieco na czytelności:

code(ruby).
def even(number)
if number % 2 == 0
"parzysta"
else
"nieparzysta"
end
end

Inna własność Ruby, którą trzeba mieć na uwadze analizując jego kod, to
możliwość **opcjonalnego stosowania nawiasów** zarówno w wywołaniach, jak i definicjach
metod. O ile nie prowadzi to do wieloznaczności, nawiasy w wywołaniach mogą zostać
pominięte. Tę własność najczęściej stosuje się w odniesieniu do prostych
metod, które przyjmują niewielką liczę parametrów - np. metoda `puts`, może
być zapisana na dwa sposoby:

code(ruby).
puts "Hello world"
puts("Hello world")

Tym niemniej najczęściej spotyka się ją w wersji pierwszej.

Wspomniane własności języka będą często wykorzystywane przy omawianiu poszczególnych
struktur, dlatego warto mieć je na uwadze.

Struktury kontrolne
-------------------

Jak większość współczesnych języków programowania, Ruby dostarcza abstrakcji językowych
pozwalających na łatwe zapisywanie **rozgałęzień algorytmu** oraz **pętli**.
Te pierwsze realizowane są przy pomocy **instrukcji warunkowych** (`if`, `unless`)
oraz **instrukcji selekcji** (`case` .. `when`), te drugie zaś przy pomocy
**pętli** (`while`, `until`, `for`) oraz **iteratorów** (`each`).

### Instrukcje warunkowe i instrukcja selekcji

**Instrukcja warunkowa `if`** przyjmuje jako argument wyrażenie logiczne i jeśli
w wyniku jego ewaluacji otrzymana zostanie wartość `true`, wykonany zostaje kod,
znajdujący się bezpośrednio po tym wyrażeniu. Instrukcja ta może zawierać
element opcjonalny, w postaci słowa kluczowego `else`, które markuje kod, wykonywany
w wyniku ewaluacji wyrażenia logicznego do wartości `false`. Instrukcje `if` mogą
być sprzęgane, wtedy zamiast słowa kluczowego `else` stosuje się słow `elsif`, po
którym następuje kolejne wyrażenie logiczne oraz kod, który powinien zostać
wykonany, jeśli wyrażenie to jest prawdziwe.

code(ruby).
number = 5
if(number &gt; 0)
"dodatni"
elsif(number &lt; 0)
"ujemny"
else
"zero"
end
\#=&gt; "dodatni"

**Instrukcja `unless`** jest odpowiednikiem `if`, z tą różnicą, że ewaluowane wyrażenie
logiczne jest zanegowane. Znaczy to tyle, że pierwszy fragment kodu jest wykonywany
jeśli wyrażenie logiczne da wartość `false`. Instrukcję tę często wykorzystuje się
przy sprawdzaniu niepustości zmiennej:

code(ruby).
unless str.nil?
return str.length
end

Obie instrukcje warunkowe mogą występować jako modyfikatory wyrażeń - pojawiają
się wtedy na końcu wyrażenia i nie kończą się słowem kluczowym `end`.
Powyższy fragment kodu można zapisać zwięźlej, stosują składnię modyfikatorową:

code(ruby).
return str.length unless str.nil?

Jak zostało to wskazane na początku tego rozdziału, wszelkie poprawne konstrukcje
językowe są wyrażeniami. Dzięki temu instrukcje warunkowe mogą stanąć po prawej
stronie instrukcji przypisania. Fragment kodu badający znak zmiennej, może
być zatem wykorzystany w następujący sposób:

code(ruby).
number = 5
znak = if number &gt; 0
"dodatni"
elsif number &lt; 0
"ujemny"
else
"zero"
end
znak
\#=&gt; "dodatni"

**Instrukcja selekcji `case`** może występować w dwóch formach - w pierwszej
po słowie kluczowym `case` następuje wyrażenie, a dalej sekwencja opcji.
Każdy z opcji składa się ze słowa kluczowego `when`, po którym następuje
lista oddzielonych przecinkami wartości, powodujących wybranie danej opcji.
Na końcu znajduje się kod, który ma zostać wywołany w przypadku wybrania danej opcji.
W drugim przypadku zamiast listy wartości, powodujących wybranie danej opcji, pojawia
się warunek logiczny, którego spełnienie powoduje jej wybranie.

W obu wypadkach testowanie wartości/wyrażeń wykonywane jest do napotkania pierwszego
spełnionego wyrażenia.
Instrukcja `case` może kończyć się opcjonalnym blokiem `else`, który zostanie wykonany,
jeśli nie zostanie wybrana żadna z opcji.

Obie formy instrukcji selekcji przedstawione są poniżej:

code(ruby).
case number
when 1,2,3
"mały"
when 4,5,6
"średni"
when 7,8,9
"duży"
else
"olbrzymi"
end

code(ruby).
case
when cplx\[1\] != 0
"liczba zespolona"
when cplx\[0\] &gt; 0
"liczba dodatnia"
when cplx\[0\] &lt; 0
"liczba ujemna"
else
"zero"
end

Należy zwrócić uwagę na to, że w innych językach programowania
instrukcja selekcji zazwyczaj składa się z pary słów kluczowych `switch`, `case`.

**Testowanie wartości** odbywa się z wykorzystaniem **operatora `===`** (a nie `==`).
Pozwala to na definiowanie specyficznych warunków równości w instrukcji
selekcji, odmiennych od zwykłych warunków równości. Własność ta jest
wykorzystywana w wielu typach podstawowych: w przypadku porównania łańcucha
znaków z **wyrażeniem regularnym** operator `===` zwróci wartość `true`, jeśli
łańcuch ten pasuje do wyrażenia; w przypadku porównania wartości z **przedziałem**,
zostanie zwrócona prawda, jeśli dana wartość należy do przedziału; zaś
w przypadku porównania z **klasą** - jeśli dany obiekt jest instancją tej klasy.

Pozwala to na bardzo zwięzłe zapisywanie nawet skomplikowanych przypadków, np.

code(ruby).
case url
when /http:/
"protokół stron internetowych"
when /https:/
"bezpieczny protokół stron internetowych"
when /ftp:/
"protokół przesyłu plików"
else
"nieznany protokół"
end

code(ruby).
case number
when 1..9
"mały"
when 10..99
"średni"
when 100..999
"duży"
else
"olbrzymi"
end

### Pętle i iteratory

**Instrukcja `while`**, która służy do tworzenia pętli, wykonuje objęty nią blok
kodu, tak długo, jak prawdziwe jest wyrażenie logiczne, które występuje bezpośrednio
po słowie kluczowym `while`.

code(ruby).
lines = \[\]
while line !~ /\\Aend\\Z/
line = gets.chomp
lines &lt;&lt; line
end

Powyższy fragment kodu powoduje wczytywanie do tablicy tekstu wprowadzanego
przez użytkownika, aż do momentu, w którym wprowadzi on tekst `end`.

Instrukcja `while` może występować również jako modyfikator, tzn. pojawić się
na końcu wyrażenia. Wyrażenie, które stoi po lewej stronie słowa kluczowego `while`
jest wtedy wykonywane dopóty, dopóki wyrażenie logiczne stojące po jego prawej
stronie, będzie wyrażeniem prawdziwym.

code(ruby).
line = gets.chomp while line !~ /^$/

Powyższy fragment kodu powoduje wczytywanie do zmiennej line tekstu wprowadzanego
przez użytkownika (funkcja `gets` pobiera łańcuch znaków ze standardowego wejścia),
aż do wystąpienia pustej linii.

Ewaluacja wyrażenia logicznego występującego po słowie `while` jest podstawowym
sposobem sterowania wykonaniem pętli. Można również stosować instrukcje `break`,
`redo`, `next`:

-   Instrukcja `break` powoduje natychmiastowe przerwanie pętli, w której się znajduje.
-   Instrukcja `redo` powoduje ponowne wykonanie bieżącej iteracji, bez sprawdzenia
    warunku.
-   Instrukcja `next` powoduje przejście do następnej iteracji, bez wykonania kodu,
    który w bloku pętli występuje po niej.

Działanie tych instrukcji przedstawione jest poniżej:

code(ruby).
lines = \[\]
while line = gets.chomp
next if line =~ /^$/
break if line =~ /^end$/
count, content = line.split(/:/)
lines &lt;&lt; (content || line)
unless content.nil?
count = count.to\_i - 1
line = count.to\_s + ":" + content
redo if count &gt; 0
end
end

W tym nieco wydumanym przykładzie do tablicy `lines` wczytywane są
dane wprowadzane przez użytkownika. Operacja ta kończy się jeśli
wprowadzi on z klawiatury ciąg znaków `end`. Puste linie są
pomijane, natomiast linie o strukturze "x:abc", gdzie `x` to liczba
całkowita, a `abc` to treść wprowadzane są do tablicy x razy.

Przykład jest o tyle wydumany, że wprowadzenie do tablicy kilka razy
tego samego elementu można było rozwiązać znacznie prościej.

**Instrukcja `until`** jest dokładnym odpowiednikiem instrukcji `while`
z tą różnicą, że instrukcja `until` wykonuje swoje ciało tak długo,
jak długo występujący w niej warunek logiczny pozostaje fałszywy.

Podobnie jak instrukcja `while` występuje ona również w postaci modyfikatorowej.
Wczśniejszy przykład działania instrukcji `while` można zapisać
korzystając z instrukcji `until`:

code(ruby).
line = gets.chomp until line =~ /^$/

**Iterator `each`** to metoda implementowana przez klasy, których obiekty
mają charakter struktur sekwencyjnych, np. tablice. Do metody
`each` należy przekazać blok kodu, który wywoływany jest dla
każdego elementu należącego do danej struktury sekwencyjnej,
z tym elementem jako parametrem bloku.

Taka konstrukcja metody `each` pozwala w łatwy sposób wykonywać
dowolne operacje na wszystkich elementach danej struktur, np.

code(ruby).
strs = \["abc\\n", "cdae\\n", "zzas\\n", "aaaa\\n" \]
strs.each{|s| s.chop!}
\#=&gt; \["abc", "cdae", "zzas", "aaaa"\]

W powyższym kodzie w ciele iteratora, każdy łańcuch należący do tablicy `strs`
pozbawiany jest ostatniego znaku.

**Instrukcja `for`** pozwala iterować po strukturach danych,
które implementują metodę `each`. Ciało instrukcji `for` wykonywane
jest podobnie jak ciało iteratora `each` dla każdego elementu struktury,
z tą różnicą, że zasięg zmiennych zdefiniowanych wewnątrz
ciała instrukcji `for` przekracza je.

code(ruby).
letters = %w{ x y z }
for letter in letters
puts letter
end
\# x
\# y
\# z
\#=&gt; \["x", "y", "z"\]

Zastosowana w powyższym przykładzie sekwencja %w{ .. } powoduje zamianę słów
występujących pomiędzy nawiasami klamrowymi w tablicę, której elementami
są te słowa. Pozwala to na znacznie wygodniejsze definiowanie tablic, składających
się z wielu słów. Ponieważ spacja jest w tej konstrukcji separatorem, aby
w tablicy pojawił się napis ze spacją, należy ją poprzedzić odwrotnym ukośnikiem \\.

**Pętle numeryczne**

Dla użytkowników języków takich jak Java, C, czy Pascal zaskakujący
może być brak w języku Ruby klasycznej - numerycznej pętli `for`.
W istocie pętla ta występuje w języku, ale jest ukryta w klasie... `Fixnum`!
Trzy metody tej klasy: **`times`**, **`upto`** oraz **`downto`** pozwalają na
tworzenie pętli, które mają wykonać się określoną ilość razy.

Metoda `times` wykonuje występujący po niej blok kodu dokładnie tyle
razy ile wynosi wartość liczby, dla której została wywołana. Przekazuje
do bloku indeksy od 0 do *wartość danej liczby pomniejszonej o 1*, zwiększając wartość
indeksu o jeden w każdej iteracji.

code(ruby).
5.times {|i| puts i}
\# 0
\# 1
\# 2
\# 3
\# 4
\#=&gt; 5

Metoda `upto` wykonuje występujący po niej blok kodu przekazując
do niego indeksy od wartości liczby dla której została wywołana (**indeks dolny**)
aż do wartości jej argumentu (**indeks górny**), przy każdej iteracji zwiększając wartość
indeksu o jeden. Jeśli wartość dolnego indeksu jest większa od
wartości indeksu górnego blok nie jest w ogóle wywoływany.

code(ruby).
2.upto(4) {|i| puts i}
\# 2
\# 3
\# 4
\#=&gt; 2

Metoda `downto` działa podobnie jak metoda `upto` z tą różnicą, że przy
każdej iteracji indeks jest zmniejszany:

code(ruby).
4.downto(2) {|i| puts i}
\# 4
\# 3
\# 2
\#=&gt; 4

Funkcje
-------

Ruby, podobnie jak większość współczesnych języków programowania dostarcza
mechanizm pozwalający na definiowanie podprogramów. **Definicja funkcji**
składa się ze słowa kluczowego `def`, nazwy funkcji, ujętej
w nawiasy okrągłe listy nazw parametrów oddzielonych przecinkami,
a kończy się słówkiem `end`. Funkcje wywołujemy podając jej nazwę,
po której następuje ujęta w nawiasy okrągłe lista jej argumentów.

Ogólna postać definicji funkcji oraz przykład jej użycia:

code(ruby).
def nazwa\_funkcji(par1, par2, ...)
...
end
nazwa\_funkcji(arg1,arg2,...)

code(ruby).
def hello(name)
puts "Witaj \#{name}"
end
hello("Alex")
\# Witaj Alex
\#=&gt; nil
hello("Jan B.")
\# Witaj Jan B.
\#=&gt; nil

**Wartością zwracaną** przez funkcję jest **wartość ostatniej wykonanej instrukcji**.
Dlatego też w powyższych wywołaniach jako wartość zwracana przez funkcję
`hello` pojawia się `nil`, bowiem `puts` zwraca właśnie wartość pustą.

Biorąc pod uwagę fakt, że w Ruby każda instrukcja (poza blokiem, o czym mowa dalej)
jest wyrażeniem, to zawsze zwracana jest pewna wartość. Dlatego też
mówimy, że w tym języku nie można zdefiniować czystych procedur.
Jeżeli w funkcji żadna instrukcja nie zostaje wykonana, to zwracana
jest wartość pusta, podobnie jak w przypadku, gdy w instrukcji warunkowej
nie posiadającej sekcji `else` wyrażenie logiczne jest fałszywe:

code(ruby).
def empty
end
def always\_false
if false
"to nie może być zwrócone"
end
end
empty
\#=&gt; nil
always\_false
\#=&gt; nil

W powyższym przykładzie widzimy również, że zarówno w definicji funkcji,
jak i w jej wywołaniu **można pominąć nawiasy**. Nie zależy to od tego, czy
funkcja przyjmuje jakieś argumenty, czy nie. Jednakże w przypadku, gdy
jako argument jednej funkcji, w której nie użyto nawiasów, zostanie podana
inna funkcja, w której też nie użyto nawiasów, zostanie wygenerowane ostrzeżenie:

code(ruby).
def hello(name)
"Witaj \#{name}"
end
def pick\_name(index)
%w{Ciechomirze Miłogoście Kanizjuszu}\[index\]
end
hello pick\_name 2
\# (irb):26: warning: parenthesize argument(s) for future version
\#=&gt; "Witaj Kanizjuszu"

Jeśli chcemy **opuścić funkcję** pomijając wywołanie pewnych instrukcji,
możemy skorzystać ze słowa kluczowego **`return`**. Wartością zwróconą
przez funkcję będzie wtedy wartość wyrażenia pojawiającego się
po tym słowie. Jeśli wyrażenia takie nie pojawia się, to zwracana
jest wartość pusta:

code(ruby).
def power(number,exp)
return if number.nil? || exp.nil?
if exp &lt;= 1
number
else
power(number,exp-1)\*number
end
end
power(2,3)
\#=&gt; 8
power(nil,3)
\#=&gt; nil

W powyższej, bardzo nieefektywnej, implementacji funkcji potęgowania,
w przypadku gdy
podstawa lub wykładnik potęgi są wartościami pustymi, funkcja
jest natychmiast opuszczana i zwracana jest wartość pusta.

Argumenty funkcji w Ruby mogą przyjmować **wartości domyślne**, który
podaje się po nazwie argumentu i znaku =. Wtedy, jeśli nie
określimy wartości tych argumentów, to zostaną użyte wartości
domyślne.

code(ruby).
def good\_morning(who="Vietnamie")
"Dzień dobry \#{who}"
end
good\_morning("Żelisławie")
\#=&gt; "Dzień dobry Żelisławie"
good\_morning
\#=&gt; "Dzień dobry Vietnamie"

Argumenty posiadające wartości domyślne muszą zawsze pojawiać się po
argumentach nie posiadających wartości domyślnych.

Funkcje w Ruby mogą też akceptować **dowolną liczbę argumentów**.
Zmienna, do której ma zostać przypisana tablica zawierająca te
arbitralne argumentu, poprzedzana jest gwiazdką:

code(ruby).
def good\_bye(\*guys)
"Do widzenia " + guys.join(" i ")
end
good\_bye("Amosie")
\#=&gt; "Do widzenia Amosie"
good\_bye("Lechosławie","Samuelu")
\#=&gt; "Do widzenia Lechosławie i Samuelu"

W Ruby **nie można** wywoływać funkcji z wykorzystaniem \*opcjonalnych
argumentów etykietowanych\*. Tym niemniej często symuluje się
tę własność m.in. Lispa przekazując jako argument wywołania
tablicę asocjacyjną. W takiej sytuacji można pominąć nawiasy
klamrowe, które zwykle ją otaczają.

code(ruby).
def html\_img(path, options={})
options\[:title\] ||= path.sub(/.\*?(\\w+)\[.\]\\w+\\Z/,"\\\\1")
options\[:alt\] ||= options\[:title\]
"<img src='#{path}' title='#{options[:title]}' alt='#{options[:alt]}'></img>"
end
html\_img("http://abc.xyz/img.gif")
\#=&gt; "<img src='http://abc.xyz/img.gif' title='img' alt='img'></img>"
html\_img("http://abc.xyz/img.gif", :title =&gt; "© Adkonis Bolemysł",
:alt =&gt; "Szkoda, że tego nie widzisz")
\#=&gt; "<img src='http://abc.xyz/img.gif' title='(C) Adkonis Bolemysł' alt='Szkoda, że tego nie widzisz'></img>"

W powyższym przykładzie tworzony jest tag HTML `img`. Jeśli nie zostaną podane
argumenty `:title` oraz `:alt`, to ustawiane są one na podstawie nazwy
wyświetlanego pliku.

Pojawiający się w przykładzie idiom Ruby `||=`, działa
następująco: jeśli zmienna stojąca po lewej posiada już jakąś wartość,
to nie jest ona zmieniana. W przeciwnym razie przypisywana jest jej wartość
stojąca po prawej stronie instrukcji przypisania.

Bloki
-----

Bloki, to jedna z tych cech Rubiego, która sprawia, że pisanie w nim
jest bardzo przyjemne. Jednocześnie, dla osób niezaznajomionych z językami
takimi jak Lisp czy Smalltalk, konstrukcja ta może być nieco problematyczna.
Dlatego też, postaramy się omówić bloki w sposób szczegółowy, aby
rozwiać wszelkie związane z nimi wątpliwości oraz pokazać, że programowanie
z ich użyciem jest naprawdę przyjemne.

Czym są bloki? Najogólniej rzecz biorąc są to fragmenty kodu, które
mogą być przypisywane do zmiennych i przekazywane jako parametry
wywołań funkcji. Konstrukcje podobnego typu są oczywiście spotykane
w innych językach programowania - np. w C++ odpowiednikiem bloku byłby
wskaźnik do funkcji lub metody, zaś w Javie ich odpowiednikiem byłby
anonimowe klasy implementujące prosty interfejs posiadający tylko jedną metodę.

Dlaczego zatem konstrukcje tego rodzaju nie są powszechnie wykorzystywane
w tych językach programowania? Otóż każdy kto programował w C++ wie, że
definiowanie funkcji, która przyjmowałaby jako swój parametr inną funkcję
nie należy do najprzyjemniejszych rzeczy. Podobnie w Javie - rzadko kiedy
chcemy definiować interfejs, który posiadałby tylko jedną metodę. Co więcej -
bloki tworzą tzw. **domknięcie** nad zmiennymi, które znajdują się w ich
kontekście leksykalnym. Cecha ta byłaby trudna do zrealizowania w C++,
natomiast w Javie zmienne należące do zewnętrznego kontekstu leksykalnego,
aby być wykorzystane wewnątrz anonimowej klasy, muszą posiadać modyfikator `final`.
Rozwiązanie takie nie jest jednak tożsame z domknięciem, ponieważ wartości
przechowywane w zmiennych domknięcia pozostają modyfikowalne.

Dzięki temu, że w Ruby bloki stanowią inherentną część języka, ich definiowanie
i wywoływanie jest niezwykle proste, co sprzyja ich używaniu. Podobnie jak
funkcje, które również stanowią pewien fragment kodu wielokrotnego wykorzystania,
bloki można **definiować** i **wywoływać**. Istnieją dwie postaci definicji
bloku:

-   kod ujęty w **nawiasy klamrowe {}**
-   kod ujęty w **słowa kluczowe `do` ... `end`**

W obu przypadkach blok może przyjmować parametry, które ujmowane są w pałki - |, a
oddzielone przecinkiem, natomiast wartością zwracaną przez blok jest ostatnie
ewaluowane wyrażenie. Obie definicje bloku przedstawione są poniżej:

code(ruby).
{|x,y,z| x + y + z }
do |x,y,z|
x + y + z
end

W obu przypadkach definiowany jest ten sam blok kodu, który zwraca sumę
trzech argumentów do niego przekazanych. Istnieje jednak drobna różnica pomiędzy
powyższymi definicjami: otóż pierwsza postać ma wyższy priorytet w kontekście
wiązania operatorów. Dlatego też z pomocą pierwszej postaci łatwiej jest
zapisywać ciągi przekształceń danych, gdyż po nawiasie zamykającym można
bezpośrednio umieścić kropkę (czyli wywołanie metody obiektu), a po słowie `end` - nie.

Chociaż przedstawione zostały definicje bloków, to w tej gołej postaci nie mogą
być one używane. Bloki należy bowiem definiować w odpowiednim kontekście,
w zależności od tego jak mają być używane.

Jeśli chcemy przekazać blok tylko jako **parametr wywołania pewnej metody lub funkcji**,
to umieszczamy go po liście jej parametrów:

**Przykład**

code(ruby).
a = \[1,2,3\].reject{|e| e % 2 == 1}

W powyższym przykładzie wykorzystana jest metoda `reject` klasy `Array`, która
nie przyjmuje żadnych parametrów, a powoduje usunięcie z
tablicy obiektów, dla których blok zwrócił wartość `true`.
Stąd też z tablicy zostaną usunięte elementy nieparzyste i pozostanie w niej
tylko element 2.

W powyższym przykładzie wykorzystaliśmy pierwszą z postaci bloku i
podobnie będziemy postępować w następnych. Postać `do...end`
zazwyczaj stosuje się, jeśli kod bloku nie mieści się w jednej linijce.

W przypadku gdy dany blok kodu **chcemy wykorzystać wielokrotnie**, zamiast definiować
go przy każdym wywołaniu funkcji, która go używa, można \*przekształcić go w obiekt
i przypisać do zmiennej\*. W tym celu można posłużyć się słowem kluczowym **`lambda`**,
które przekształca blok w obiekt klasy `Proc`. Jeśli chcemy użyć zmiennej,
do której przypisany został obiekt `Proc`, musimy jej nazwę poprzedzić znakiem &.
Bloki mogą być przekształcane w obiekty klasy `Proc` poprzez bezpośrednie
wywołanie konstruktora tej klasy, ale nie jest to rozwiązanie zalecane.

**Przykład**

code(ruby).
odd = lambda {|e| e % 2 != 0}
even\_numbers = \[1,2,3\].reject &odd
odd\_number = \[1,2,3\].select &odd

W powyższym przykładzie definiowany jest blok `odd`, który dla elementów nieparzystych
zwraca wartość `true`. Jest on wykorzystywany w dwóch metodach klasy `Array`: `reject`
i `select`. W pierwszym przypadku z tablicy usuwane są elementy nieparzyste, w
drugim zaś tylko te elementy są pozostawiane w tablicy.

Blok przypisany do zmiennej **może zostać bezpośrednio wywołany** za pomocą metody
**`call`**, która przyjmuje tyle parametrów ile zostało wymienionych w definicji
bloku. Przekazanie innej liczby argumentów powoduje wygenerowanie ostrzeżenia.

**Przykład**

code(ruby).
odd = lambda {|e| e % 2 != 0}
odd.call(3)
\#=&gt; true
odd.call(2)
\#=&gt; false
odd.call(2,3)
\# warning: multiple values for a block parameter (2 for 1)
\# NoMethodError: undefined method \`%' for \[2, 3\]:Array

W powyższym przykładzie blok `odd` wywoływany jest dla parametrów 3, 2 i pary 2,3.
Ostatnie wywołanie powoduje wygenerowanie ostrzeżenia spowodowanego
przekazaniem niewłaściwej liczby parametrów oraz błędu spowodowanego brakiem
definicji metody % dla obiektu klasy `Array`.

Wywoływanie bloków za pomocą metody `call` jest tylko jedną z możliwości. W przypadku
gdy implementujemy metodę lub funkcję, która ma przyjmować blok, możemy
skorzystać ze słowa kluczowego **`yield`**, które powoduje \*wywołanie bloku
przekazanego jako parametr naszej funkcji lub metody\*.

**Przykład**

code(ruby).
def three\_times
yield
yield
yield
end
three\_times { puts "Yo" }
\# Yo
\# Yo
\# Yo

W powyższym przykładzie definiowana jest funkcja `three_times`, która powoduje
trzykrotne wywołanie przekazanego do niej bloku. Oczywiście jej przydatność jest
niewielka. Poniżej przedstawimy przykład, który pokaże, że technika ta
może być jednak bardzo przydatna.

Jeśli chcemy przekazać jakieś parametry do bloku wykorzystując wywołanie
`yield`, to muszą się one znaleźć po tym słowie kluczowym. Parametry
te wiązane są z parametrami formalnymi bloku, które umieszczamy pomiędzy znakami
|.

**Przykład**

code(ruby).
def three\_times
yield 1
yield 2
yield 3
end
three\_times {|i| puts "\#{i}. raz: Yo"}
\# 1. raz: Yo
\# 2. raz: Yo
\# 3. raz: Yo

W powyższym kodzie do bloku przekazywany jest za każdym razem numer
wywołania. W bloku numer ten jest przypisywany do zmiennej, co pozwala
zasygnalizować, który raz wykonywany jest blok.

Aby wywołać blok przekazany jako parametr funkcji lub metody, poza wykorzystaniem
słowa `yield`, można również użyć innej techniki:
**ostatni jej parametr poprzedzić znakiem &**. Wtedy blok zostanie przekształcony
w obiekt klasy `Proc` i przypisany do tej zmiennej. Na zmiennej tej
można oczywiście wywołać metodę `call`. Powyższy przykład może zatem
przyjąć następującą postać:

code(ruby).
def three\_times(&block)
block.call 1
block.call 2
block.call 3
end
three\_times {|i| puts "\#{i}. raz: Yo"}
\# 1. raz: Yo
\# 2. raz: Yo
\# 3. raz: Yo

Dzięki przypisaniu bloku do zmiennej można np. sprawdzić \*liczbę parametrów,
które on akceptuje\* (metoda **`arity`**) albo zbadać \*czy blok w ogóle został
przekazany\*, porównując jej wartość z **wartością pustą**. Ten drugi test
może być również przeprowadzony poprzez wywołanie **`block_given?`**, które
zwraca wartość `true`, jeśli do metody przekazano blok. Wywołanie to
działa niezależnie od tego, czy wśród parametrów funkcji wymieniliśmy
zmienną dla bloku.

Jedną z cech bloków, o której była już mowa wcześniej,
jest to, że **zapamiętują one swój kontekst leksykalny** (innymi słowy: tworzą **domknięcie**
nad tymi zmiennymi). Mówiąc bardziej po ludzku,
chodzi o to, że wartości zmiennych lokalnych, które wykorzystywane są w bloku,
brane są z kontekstu (czyli fragmentu kodu, w których zmienne lokalne zachowują
swoją tożsamość), w którym został **zdefiniowany** on, a nie z kontekstu gdzie jest
on **wywoływany**.

Aby zilustrować tę własność, konieczne jest określenie dwóch różnych kontekstów.
Ponieważ funkcje tworzą odrębny kontekst (tzn. zmienne lokalne używane w ramach
funkcji nie są widoczne poza nią), użyjemy właśnie ich:

code(ruby).
def use\_local
x = 10
lambda{puts x; x += 10}
end
x = 20
p1 = use\_local
p2 = use\_local
p1.call
\# 10
\#=&gt; 20
p1.call
\# 20
\#=&gt; 30
x
\#=&gt; 20
p2.call
\# 10
\#=&gt; 20

W powyższym przykładzie w funkcji `use_local` definiowany jest blok, który
powoduje wyświetlenie wartości zmiennej x oraz zwiększenie jej o 10.
W pozostałym kodzie, który tworzy odrębny kontekst, używana jest również zmienna
x, która zainicjowana jest inną wartością. Wartość funkcji `use_local` (czyli blok)
przypisywana jest do zmiennych `p1` i `p2`. Widzimy, że każdy z bloków posiada
własną zmienną x, która modyfikowana jest w kolejnych ich wywołaniach.
Zmienna x, zdefiniowana poza funkcją `use_local` również posiada własną,
odrębną wartość.

Nic nie stoi na przeszkodzie, aby zmienna, która używana jest w bloku,
była przekazana jako parametr wywołania funkcji:

code(ruby).
def use\_local(x)
lambda { puts x; x += 10}
end
x = 10
p1 = use\_local(x)
x = 100
p2 = use\_local(x)
x = 200
p1.call
\# 10
\#=&gt; 20
p1.call
\# 20
\#=&gt; 30
p2.call
\# 100
\#=&gt; 110
x
\#=&gt; 200

Ten sposób użycia bloków stosowany jest najczęściej w przypadku, gdy
chcemy mieć strukturę podobną do klasy z jedną, sukcesywnie wywoływaną
metodą.

Inne często spotykane zastosowania bloków zostały przedstawione w
poprzednim rozdziale - wiele typów podstawowych posiada metody, które
akceptują bloki i pozwalają w wygodny sposób operować na ich obiektach.
Poza tym bloki wykorzystywane są wszędzie tam, gdzie
wykonanie pewnego kodu powinno być poprzedzone i zakończone pewnymi
operacjami pomocniczymi - jak to ma miejsce w przypadku operacji na
plikach (gdzie plik przed użyciem musi zostać otwarty, a po zakończeniu
zamknięty), czy w transakcyjnej bazie danych (gdzie transakcja powinna
być zatwierdzona bądź wycofana w zależności od wystąpienia wyjątku).

Tym niemniej bloki nadają się do wielu innych zastosowań. Aby się
o tym przekonać rozważmy następujący problem związany z testowaniem
aplikacji webowych. Często zdarza się, że dostęp do pewnych
operacji w serwisie dostępny jest tylko dla zarejestrowanych
użytkowników albo administratorów. Jak możemy przypuszczać wystąpienie określonego
błędu może zależeć od tego, czy ktoś jest zalogowany lub nie.
Najprostszym zabezpieczeniem przed tego rodzaju wypadkiem byłoby
dwukrotne napisanie identycznego kodu, który raz wywoływany jest
bez logowania, a drugi raz po nim. Przykładowy test mógłby
wyglądać następująco:

code(ruby).
\# testujemy wyświetlanie elementów
def test\_show
\# bez logowania
get :show, :id =&gt; 10
test\_not\_nil assigns(:item)
\#... inne testy
\# z logowaniem
login
get :show, :id =&gt; 10
test\_not\_nil assigns(:item)
\#... inne testy, j.w.
end

Powyższy kod (który *de facto* zaczerpnięty jest z projektu pisanego w frameworku Rails),
symuluje wyświetlenie strony (`get :show, :id => 10`), a następnie testuje,
czy odpowiednie zmienne zostały ustawione (`test_not_nil assings(:item)`), etc.
Widzimy wyraźnie, że wykonywane testy są identyczne w przypadku gdy jesteśmy zalogowani
i niezalogowani. Różnica dotyczy tylko metody `login`, która powoduje zalogowanie
domyślnego użytkownika.

Aby uniknąć nadmiarowości (która może w przyszłości prowadzić do rozjechania się
całego testu), możemy użyć bloku:

code(ruby).
def test\_show
no\_login do
get :show, :id =&gt; 10
test\_not\_nil assigns(:item)
\#... inne testy
end
end

Metoda no\_login zdefiniowana jest następująco:

code(ruby).
def no\_login
yield
login
yield
end

Akceptuje ona blok kodu i powoduje jego dwukrotne wykonanie przed i po zalogowaniu.
Nic nie stoi na przeszkodzie aby użyć jej również w innych testach. Takie
rozwiązanie pozwala również w banalny sposób ulepszyć nasze testy, jeśli
będziemy musieli dodać nowy profil użytkownika, np. admin. Wystarczy wtedy
zmodyfikować metodę `no_login`:

code(ruby).
def no\_login
yield
login
yield
logout
login :admin
yield
end

Tym prostym sposobem wszystkie nasze dotychczasowe testy, które korzystały
z tej metody zostaną automatycznie uzupełnione o schemat, w którym loguje
się administrator (oczywiście jeśli odpowiednio zaimplementowaliśmy metodę login...).
Jest to o tyle istotne, że w żaden sposób nie zmodyfikowaliśmy kodu oryginalnych testów.
Możemy również przygotować inne wersje tej metody, w których będzie sprawdzane, czy
test nie przechodzi, gdy użytkownik się nie zalogował. Najważniejsze jest to, że
dzięki takiemu rozwiązaniu styl naszych testów pozostanie spójny - w klasie
zawierającej testy główny kod będzie dotyczył samego testu, a nie powtarzalnych,
pobocznych operacji.

Wyjątki
-------

W języku Ruby, tak jak w innych współczesnych językach programowania, \*obsługa
błędów\* może być realizowana z wykorzystaniem **mechanizmu wyjątków**. Jeśli spodziewamy się,
że w wykonywanym fragmencie kodu może wystąpić wyjątek (spowodowany np. błędem
czasu wykonania związanym z dostępem do dysku) i chcemy go
obsłużyć, musimy objąć go w słowa kluczowe `begin` oraz `rescue`, po których
pojawia się kod obsługi wyjątku zakończony słowem `end`.

code(ruby).
begin
\# kod w którym może wystąpić wyjątek
rescue
\# kod obsługi wyjątku
end

Aby obsłużyć tylko wyjątki określonego typu i dodatkowo mieć
dostęp do obiektu wyjątku, po słowie `rescue` należy dodać \*parę
postaci `TypWyjątku => obiektWyjątku`\*. Jeśli określamy typ wyjątku,
to możemy użyć kilku sekcji obsługi wyjątków, dla różnych typów. Przy
obsłudze wyjątku zostanie wykonana pierwsza sekcja, której typ
odpowiada typowi wyjątku lub jest typem nadrzędnym wobec jego
typu.

code(ruby).
def file\_operation(file\_name)
begin
file = File.open(file\_name)
\# operacje na pliku
rescue Errno::ENOENT =&gt; e
puts "Plik \#{file\_name} nie istnieje"
rescue Errno::EACCES =&gt; e
puts "Nie można odczytać pliku \#{file\_name}"
rescue Exception =&gt; e
puts "Wystąpił nieoczekiwany problem " + e
end
end
file\_operation("nieistniejacy\_plik.txt")
\# Plik nieistniejacy\_plik.txt nie istnieje
\#=&gt; nil
file\_operation("plik\_nieodczytywalny.txt")
\# Nie można odczytać pliku plik\_nieodczytywalny.txt
\#=&gt; nil

W powyższym przykładzie w funkcji `file_operation` obsługiwane są wyjątki
typu `Errno::ENOENT`, `Errno::ENOACCES` oraz `Exception`.
Pierwszy może wystąpić, jeśli plik, który ma zostać otwarty nie istnieje;
drugi - jeśli program wykonujący operację odczytania pliku nie ma do tego
wystarczających uprawnień. Ostatnia sekcja `rescu` obsługuje wszystkie inne
wyjątki, które mogłyby się pojawić w trakcie wykonywania kodu "operacje na pliku".

Jeśli chcemy aby pewien kod został wykonany \*niezależnie od tego, czy wyjątek wystąpił
czy nie\*, po bloku obsługi wyjątku dodajemy słowo kluczowe **`ensure`** i odpowiedni kod.
W ten sposób możemy zwolnić np. zajęte zasoby systemowe, itp.

Jeśli obsługa wyjątków **obejmuje całe ciało funkcji**, to można zrezygnować
ze słów kluczowego `begin` oraz `end`. Wtedy wyjątki obsługiwane są
w całym kodzie pojawiającym się pomiędzy sygnaturą funkcji, a słowem `rescue`.

Te dwie własności przedstawione są w poniższym kodzie:

code(ruby).
def average\_int(file\_name)
file = File.open(file\_name)
sum = 0
count = 0
file.each do |l|
sum += l.chomp.to\_i
count += 1
end
avg = sum/count
rescue ZeroDivisionError
avg = 0
ensure
file.close
avg
end

W powyższym przykładzie obliczana jest średnia całkowita wartość liczba znajdujących
się w kolejnych wierszach pliku przekazanego jako parametr. Jeśli liczba wiersz
wynosi zero, to pojawi się błąd `ZeroDivisionError`. Niezależnie od tego,
przed opuszczeniem funkcji, należy zamknąć otwarty zasób plikowy.
Odpowiedzialna jest za to sekcja `ensure`. (Uwaga: w kodzie obliczana jest
średnia całkowita, czyli *podłoga* z średniej, gdyż użycie wartości
rzeczywistych zamiast całkowitych, nie spowodowałoby wystąpienia błędu
`ZeroDivisionError`).

Instrukcja obsługi wyjątków w Ruby ma jeszcze jedną interesującą własność -
otóż poza kodem obsługi wyjątku, można określić kod, który zostanie wykonany jeśli
wyjątek nie wystąpi. Kod taki sygnalizowany jest za pomocą słowa kluczowego
`else`. Zatem pełna struktura instrukcji obsługi wyjątków wygląda następująco:

code(ruby).
begin
\# kod, w którym może wystąpić wyjątek
rescue TypWyjatku1 =&gt; obiektWyjatku1
\# kod obsługi wyjątku typu TypWyjatku1
rescue TypWyjatku2 =&gt; obiektWyjatku2
\# kod obsługi wyjątku typu TypWyjatku2
...
else
\# kod, który zostanie wykonany, jeśli nie wystąpił wyjątek
ensure
\# kod, który zostanie wykonany, niezależnie od tego czy wystąpił wyjątek, czy nie
end

**Aby zgłosić wyjątek** należy użyć słowa kluczowego **`raise`**, po który może
pojawić się obiekt typu dziedziczącego z **klasy `Exception`** lub **łańcuch znaków**.
W drugim przypadku generowany jest błąd typu `RuntimeError`, którego treść
jest taka, jak łańcuch znaków przekazany po słowie kluczowym `raise`.

code(ruby).
def transfer(amount\_of\_money, account\_from, account\_to)
raise "Wartość przelewu musi być większa od zera." if amount\_of\_money &lt;= 0
...
end

W powyższym przykładzie zgłaszany jest wyjątek typu `RuntimeError` jeśli argument
`amount_of_money` jest mniejszy lub równy 0.

Po słowie kluczowym `raise` nie musi w ogóle pojawiać się obiekt wyjątku czy
komunikat. Semantyka takiego wywołania zależy jednak od kontekstu w jakim
pojawia się to słowo. Jeśli jest to blok obsługi wyjątku, to zwracany jest
ten sam wyjątek, który jest obsługiwany. W przeciwnym razie jest zgłaszany
wyjątek `RuntimeError` z pustym komunikatem. To drugie rozwiązanie jest
oczywiście niezalecane, gdyż nie informuje w żaden sposób o charakterze
problemu, który się pojawił.

code(ruby).
begin
File.open(file\_name)
...
rescue Errno::ENOENT =&gt; e
logger.error(e)
raise
end

W powyższym przykładzie, w przypadku wystąpienia błędu związanego z brakiem
odpowiedniego pliku, informacja o tym jest odnotowywana w loggerze, ale
wyjątek `Errno::ENOENT` jest propagowany dalej.

[Poprzedni rozdział](/dydaktyka/ruby/intro/typy-danych) |
[Następny rozdział](/dydaktyka/ruby/intro/klasy)
