---
title: Obiektowość
date: '2007-08-27T11:11:00Z'
lastmod: '2009-03-08T17:57:05Z'
draft: false
tags:
- ruby
author: 193.138.140.10
toc: true
---

[Poprzedni rozdział](/dydaktyka/ruby/intro/struktury-jezyka) |
[Następny rozdział](/dydaktyka/ruby/intro/zagadnienia-zaawansowane)

W dotychczas zaprezentowanym materiale przedstawione zostały te własności języka,
które występują również w innych, obecnie używanych językach skryptowych.

Tym co czyni Ruby wyjątkowym językiem, jest silny nacisk jaki jego
twórca, czyli Yukihiro Matsumoto położył na obiektowość. Na wstępie
wspomniałem, że Ruby jest językiem w pełni obiektowym, co znaczy tyle,
że każda wartość, która może być przypisana do zmiennej lub stałej, jest
obiektem.

Podstawowe pytanie brzmi zatem: czym są obiekty w Ruby? Wydawać
by się mogło, że programowanie zorientowane obiektowo jest pojęciem
tak dobrze znanym, że nie wymaga żadnej dalszej klaryfikacji. Tym
niemniej w Ruby obiektowość jest rozumiana trochę inaczej niż w pozostałych
językach programowania, a w szczególności w najpopularniejszym języku tego
rodzaju, czyli Javie.

W tej części przewodnika postaram się przedstawić podstawowe
zagadnienia obiektowości w Ruby. Natomiast w [części następnej](/dydaktyka/ruby/intro/zagadnienia-zaawansowane) przedstawione zostaną
zaawansowane własności języka, które zdecydowanie wyróżniają
go na tle innych, popularnych języków programowania.

Obiekty
-------

W Ruby **obiektem** jest wszystko to co jest wynikiem ewaluacji dowolnego
wyrażenia, innymi słowy to, \*co może pojawić się po prawej stronie
instrukcji przypisania\*. Zasadniczo obiekty posiadają pewien **stan**, który
można utożsamić z **wartościami ich atrybutów** (zwanych również **polami**).
Wartości atrybutów nie są jednak dostępne bezpośrednio, lecz jedynie
poprzez **metody**, które pozwalają zmieniać stan obiektu. W Ruby, w przeciwieństwie
do Javy, czy C++, nie można manipulować bezpośrednio na wartościach atrybutów.
Tym niemniej nieraz spotkamy się z wyrażeniami, które z pozoru wyglądają,
jakby bezpośrednio modyfikowały wartość jakiegoś atrybutu, np.

```ruby
person = Person.new
person.name = "Aaron"
\#=&gt; "Aaron"
his\_name = person.name
\#=&gt; "Aaron"
```

Przypisanie pojawiające się w drugiej linii kodu wygląda jakby modyfikowało
wartość atrybutu `name` obiektu `person`. W czwartej linii
kodu pojawia się natomiast odwołanie do wartości atrybutu `name`, które
również może wyglądać jak jego bezpośrednie odczytanie. Tym niemniej wyrażenia to
są *de facto* wywołaniami metod, która
odpowiednio ustawiają oraz odczytują wartość atrybutu `name`
obiektu `person`. Nie wchodząc w szczegóły implementacji tego mechanizmu
(które omówione są dalej) widzimy, że Ruby pozwala na bardzo wygodne
manipulowanie stanem obiektów, przy jednoczesnym zachowaniu jednego
z podstawowych mechanizmów języków obiektowych, czyli *enkapsulacji*.

Drugą istotną cechą obiektów jest to, że są one \*instancjami pewnej
klasy\*. W rzeczywistości problem jest nieco bardziej złożony, niż
może to się wydawać na pierwszy rzut oka, ale zostanie on
omówiony dopiero w rozdziale zatytułowanym "zagadnienia
zaawansowane". Czym zatem są klasy w Ruby?

Klasy
-----

W poprzednim punkcie wskazaliśmy, że do stanu obiektu można
dostać się jedynie poprzez metody. Stwierdzenie to mogłoby prowadzić
do mylnego wniosku, że z obiektami bezpośrednio stowarzyszone
są metody. Oczywiści nic takiego nie ma miejsca - metody mogą
być związane jedynie z klasami, które... również są obiektami!
Zatem, aby uniknąć sprzeczności, należy ostatecznie stwierdzić, że
z obiektami, które nie są klasami, stowarzyszony jest jedynie stan,
ukryty w ich atrybutach. Metody mogą natomiast być związane jedynie z tymi
obiektami, które są klasami.

### Definiowanie klas

Czy istnieją jeszcze jakieś inne różnice pomiędzy zwykłymi obiektami
a klasami? Otóż tak. Pierwsza z nich dotyczy sposobu tworzenia
tych obiektów. W rozdziale dotyczącym typów danych widzieliśmy, że
chociaż wszystkie obiekty mogą być tworzone za pomocą wyrażenia
`NazwaKlasy.new`, to niektóre typy danych, np. łańcuchy mogą być
tworzone w nieco bardziej wygodny i naturalny sposób.
Dla klas sytuacja jest podobna - chociaż możemy tworzyć je wykorzystując
następującą konstrukcję:

```ruby
Person = Class.new
```

to język dostarcza konstrukcji pozwalających na znacznie wygodniejsze
definiowanie klas. W szczególności powyższa klasa może być zdefiniowana
z wykorzystaniem słowa kluczowego `class` w sposób następujący:

```ruby
class Person
end
```

Na pierwszy rzut oka definicja ta jest bardziej rozwlekła. Z drugiej jednak
strony pozwala na znacznie łatwiejsze definiowanie podstawowych
własności klasy, jakie są stowarzyszone z nią metody.

Zanim jednak przystąpimy do omówienia sposobu definiowania metod
musimy jeszcze wskazać pozostałe właściwości klasa.
Kolejna różnica, którą można było zauważyć już w poprzednich
przykładach, dotyczy sposobu tworzenia klas - są one przypisywane
do stałych, które w języku Ruby odróżniają się tym od zmiennych,
że pierwsza litera ich nazwy jest wielka.

```ruby
PI = 3.141
pi = 3.141
```

Zatem w powyższym kodzie występują dwie operacja przypisania, spośród których
pierwsza przypisuje wartość do stałej, a druga do zmiennej. Różnica wynika
tylko i wyłącznie z tego, że w pierwszej instrukcji nazwa zaczyna się od
dużej litery.

Nazwa klasy musi być stałą, zatem w konstrukcji `class NazwaKlasy` *NazwaKlasy*
musi zaczynać się od wielkiej litery. Dzięki temu, po zdefiniowaniu
klasy możemy odwołać się do niej w dowolnym kontekście leksykalnym.

Nie zmienia to jednak faktu, że w Ruby można również tworzyć klasy
anonimowe, wykorzystując właśnie konstrukcję `nowa_klasa = Class.new`. Rozwiązanie
takie nie jest zbyt często stosowane, ale może być przydatne, jeśli
nie chcemy *zanieczyszczać* przestrzeni nazw programu.

### Tworzenie obiektów

Kolejna właściwość klas dotyczy klasy, której są one instancjami - jest
to oczywiście klasa `Class`. Wśród wielu metod definiowanych
przez tę klasę, jedne zasługuje na szczególną uwagę - metoda `new`.
Otóż metoda ta pozwala tworzyć nowe obiekty danej klasy. Metoda
ta jest oczywiście wywoływana jak każda inna metoda - poprzez
operator . (kropka):

```ruby
class Person
end
person = Person.new
\#=&gt; \#<Person:0xb7955314>
```

W powyższym przykładzie najpierw definiowana jest klasa `Person`, następnie
tworzony jest obiekt tej klasy, który przypisywany jest do zmiennej `person`.
Uwidoczniona domyślna reprezentacja obiektu składa się z nazwy klasy
oraz wewnętrznego, unikalnego identyfikatora obiektu.

Powyższy wywód dokładnie ilustruje to jak rozumiana jest obiektowość
w Ruby - klasy są obiektami, przez co np. sposób tworzenia nowych
obiektów jest "w pełni obiektowy", tzn. wykorzystywana jest do tego
definiowana w klasie `Class` metoda `new`.
Nie ma tutaj żadnej magii - tworzenie
nowego obiektu nie różni się (przynajmniej pod względem składni)
od wywołania dowolnej innej metody. To, że przypomina ono znane
np. z Javy `new Person()` wynika jedynie z tego, że nazwy klas,
jako stałe muszą zaczynać się od wielkiej litery. Zwodnicze
jest również podobieństwo słowa `new`, które w języku `Java` jest
słowem kluczowym, a w Ruby jest po prostu nazwą jednej z metod!

Bardzo ważną metodą związaną z `new` jest `initialize`, która
pozwala zainicjować nowotworzony obiekt. Jest ona wywoływana za każdym
razem, gdy tworzony jest nowy obiekt za pomocą `new`. Dzięki temu
możemy w niej ustawić wartości odpowiednich atrybutów tworzonego obiektu.
Jest to znany z języków obiektowych *konstruktor*, który pozwala uniknąć
błędów wynikających z użycia jakiejś struktury danych, przed inicjalizacją
jej atrybutów.

Metoda `initialize` może przyjmować dowolną ilość argumentów, które
przekazywane są do niej z metody `new`:

```ruby
class Person
def initialize(name, surname)
puts name + " " + surname
end
end
person = Person.new("Franz", "Kafka")
\# Franz Kafka
\#=&gt; \#<Person:0xb7926690>
```

W powyższym przykładzie widzimy w jaki sposób obie metody współdziałają
przy tworzenie nowego obiektu. Oczywiste jest, że metoda `new` powoduje
wywołanie metody `initialize`. Zastanawiające może być jednak to, że
przekazanie niewłaściwej liczby argumentów do metody `new` powoduje
wywołanie wyjątku `ArgumentError`:

```ruby
class Person
def initialize(name, surname)
puts name + " " + surname
end
end
person = Person.new("Franz")
\# ArgumentError: wrong number of arguments (1 for 2)
```

Skąd metoda `new`, która zdefiniowana jest w klasie `Class` może
wiedzieć ile argumentów wymaga metoda `initialize`, która zdefiniowana
jest w klasie `Person`? Odpowiedź jest prosta - nie wie. Metoda `new`
zdefiniowana w `Class` akceptuje dowolną liczbę argumentów i przekazuje
wszystkie do `initialize`. Jeśli ich ilość jest niewłaściwa, to
zgłaszany jest wyjątek.

Z metodą `initialize` związana jest jeszcze jedna ciekawa właściwość -
w przeciwieństwie do innych metod, które domyślnie są publiczne, jest
ona metodą prywatną. Co nie zmienia faktu, że można ją upublicznić
i wywoływać na już stworzonych obiektach (nie jest to jednak praktyka
zalecana).

### Dziedziczenie

Jedną z zasadniczych cech języków obiektowych jest występowanie mechanizmu
*dziedziczenia*. Mechanizm ten w założeniu pozwala na wielokrotne,
łatwe użytkowanie tego samego kodu. Jeśli manipulujemy pewną grupą
obiektów wykorzystując do tego identyczne metody, możemy
zgrupować je w pewnej klasie, z której będą dziedziczyć inne klasy.
Typowy przykład pochodzi z graficznych interfejsów użytkownika:
definiowana jest klasa `Figure` dostarczająca metod
pozwalających np. na dokonywanie translacji o wektor oraz
kilka dziedziczących z niej klas,
np. `Circle`, `Triangle`, `Square`, z których każda implementuje
metodę `draw` rysującą figurę należącą do danej klasy, w specyficzny
dla niej sposób.

W Ruby występuje mechanizm dziedziczenia jednokrotnego. Innymi słowy
każda klasa może dziedziczyć co najwyżej z jednej klasy i jeśli nie podamy
jej *explicite*, to dziedziczy ona z klasy `Object`, czyli korzenia
drzewa dziedziczenia. Aby wskazać, że dana klasa dziedziczy z innej
klasy niż `Object` należy w definicji klasy po jej nazwie dodać znak mniejszości
oraz nazwę klasy nadrzędnej.

```ruby
class Person
end
```

```ruby
class Player &lt; Person
end
```

W powyższym przykładzie dla klasy `Person` nie została jawnie określona
jej klasa nadrzędna, zatem przyjmowana jest klasa `Object`. Natomiast
klasa `Player` dziedziczy z klasy `Person`.

Ponieważ klasy stowarzyszone są z metodami, to dziedzicznie sprowadza się do
tego, że w danej klasie dostępne są wszystkie metody zdefiniowane we
wszystkich klasach nadrzędnych wobec niej. Jeśli kilka klas w hierarchii
dziedziczenia definiuje metodę o tej samej nazwie, to wybierana jest ta
metoda, która leży w klasie znajdującej się najbliżej klasy danego obiektu
(w szczególności może to być metoda zdefiniowana w tej klasie):

```ruby
class Person
def foo
puts "person"
end
end
class Player &lt; Person
def foo
puts "player"
end
end
p1 = Person.new
p1.foo
\# "person"
p2 = Player.new
p2.foo
\# "player"
```

W powyższym przykładzie zarówno klasa `Person` jak i `Player` definiuje
metodę `foo`. Wywołanie tej metody dla obiektu klasy `Person` powoduje
wykorzystanie definicji z klasy `Person`, natomiast
wywołanie jej dla obiektu klasy `Player`, powoduje wykorzystanie
definicji z klasy `Player`.

Aby odwołać się do definicji znajdującej się w klasie nadrzędnej
korzystamy ze słowa kluczowego `super`, które powoduje wywołanie
metody o tej samej nazwie, tyle, że w klasie nadrzędnej:

```ruby
class Person
def foo
puts "person"
end
end
class Player &lt; Person
def foo
super
puts "player"
end
end
p2 = Player.new
p2.foo
\# "person"
\# "player"
```

W powyższym przykładzie w definicji metody `foo` znajdującej się
w klasie `Player` najpierw wywoływana jest metoda `foo` z klasy
nadrzędnej.

Mechanizm jednokrotnego dziedziczenia, pozwala zachować prostą hierarchię
dziedziczenia, a także uniknąć tzw. problemu *diamentu*, pojawiającego
się w językach pozwalających na wielokrotne dziedziczenie.
Tym niemniej czasami ograniczenia wprowadzane przez jednokrotne
dziedziczenie powodują, że kod, który mógłby być wielokrotnie
wykorzystany, musi być ponownie implementowany lub przynajmniej
muszą istnieć metody delegujące wywołania o identycznej semantyce
do innych klas.

### Moduły

Rozwiązaniem tego problemu w języku Ruby jest koncepcja **modułów**, czyli
zbiorów metod, które mogą być dołączane (*mixin*, wmiksowane) do klas
za pomocą słowa kluczowego `include`. Z założenia, metody
definiowane w modułach nie powinny modyfikować stanu obiektu. Mogą
natomiast odwoływać się do metod zdefiniowanych w danej
klasie.

Typowym przykładem wykorzystania modułów jest moduł `Comparable`, który
dostarcza metod pozwalających na porównywanie obiektów danej klasy.
Klasa, która chce skorzystać z metod modułu `Comparable` musi
definiować jedynie metodę `<=>(another)`, która zwraca 0
jeśli porównywany obiekt jest takie same
(w kontekście danego porównania), 1 jeśli dany obiekt jest większy od
porównywanego oraz -1 jeśli jest mniejszy. Jeśli te warunki są spełnione, to
moduł `Comparable` dostarcza metod `<, >, <=, ==, >=` oraz
`between?`.

```ruby
class Player
include Comparable
attr\_reader :score
def initialize(score)
@score = score
end
def &lt;=&gt;(other)
self.score &lt;=&gt; other.score
end
end
p1 = Player.new(10)
p2 = Player.new(20)
p1 &lt; p2
\#=&gt; true
```

W powyższym przykładzie definiowana jest klasa `Player`, do której dołączany
jest (za pomocą słowa kluczowego `include`) moduł `Comparable`. Klasa
ta definiuje metodę `<=>(other)` w taki sposób, że porównywane są wartości
atrybutu `score` (szczegóły związane z dostępem do atrybutów opisane
są w następnym punkcie). Dzięki temu obiekty klasy `Player` mogą być
porównywane np. za pomocą operatora mniejszości, co widzimy w ostatniej
linijce przykładu.

Wyjaśnienie wymaga sytuacja, w której kilka modułów definiuje metodę
o tej samej nazwie, bądź klasa nadrzędna definiuje taką samą metodę
jak dołączony moduł. W pierwszym przypadku wywołana zostanie metoda
zdefiniowana w module, który został dołączony jako ostatni. Podobnie w drugim
przypadku - wywołana zostania metoda dołączonego modułu. Zatem można
powiedzieć, że dołączone moduły mają pierwszeństwo przed klasami nadrzędnymi, a
moduły dołączone później przed modułami dołączonymi wcześniej. Oczywiście
jeśli dana klasa również definiuje metodę taką jak dołączony moduł, to
metoda zdefiniowana w klasie przesłoni metodę modułu.

Na zakończenie warto dodać, że klasa `Class` dziedziczy z klasy `Module`
(zatem każda klasa jest zarazem modułem), a moduły poza tym, że pozwalają
na dołączanie metod do klas, tworzą również osobną przestrzeń nazw.
Dzięki temu, jeśli tworzymy np. jakąś bibliotekę, która ma być
wykorzystywana w nieznanym środowisku, możemy definicje wszystkich
klas zawrzeć w module (lub modułach) posiadających unikalną nazwę.
Dzięki temu można uniknąć sytuacji, w której definicje dwóch klas posiadających
odmienną semantykę lecz identyczne nazwy, kolidują ze sobą.

Aby odwołać się do klasy, która leży wewnątrz jakiegoś modułu,
należy jej nazwę poprzedzić nazwą modułu oraz
dwoma dwukropkami:

```ruby
module Apohllo
class Node
\# definicja klasy
end
end
node = Apohllo::Node.new
```

W powyższym przykładzie widzimy odwołanie do klasy `Node`, która leży
wewnątrz przestrzeni nazw (modułu) `Apohllo`.

Atrybuty
--------

Na początku tego rozdziału napisaliśmy, że obiektu posiadają stan, a
klasy definiują metody. Dotychczas dosyć szczegółowo opisaliśmy
wysokopoziomowe zagadnienia związane z klasami (np. dziedziczenie), ale
nie wspomnieliśmy słowem ani o zmianie stanu pojedynczego obiektu, ani
nie opisaliśmy dokładnie sposobu definiowania metod. Nadszedł najwyższy
czas aby przedstawić te podstawowe zagadnienia.

### Atrybuty instancyjne

**Atrybuty** są własnościami obiektów, które pozwalają na przechowywanie
ich stanu. Najbardziej typowym przypadkiem atrybutów, są \*atrybuty
instancyjne\*, czyli atrybuty związane z obiektem, który nie jest klasą.
Atrybuty takie odróżniane są od zmiennych za pomocą pojedynczego zmaku @,
który pojawia się przed nazwą atrybutu. Typowy przykład wykorzystania
atrybutów przedstawiony jest poniżej:

```ruby
class Person
def initialize(name, surname)
`name = name
    `surname = surname
end
def name
`name
  end
  def surname
    `surname
end
end
p1 = Person.new("Frank","Sinatra")
p1.name
\#=&gt; "Frank"
p1.surname
\#=&gt; "Sinatra"
```

W powyższym przykładzie definiowana jest klasa `Person`, w której konstruktorze
inicjalizowane są dwie zmienne klasowe `@name` oraz `@surname`, na podstawie
parametrów przekazanych do konstruktora. Ponadto definiowane są dwie metody
`name` oraz `surname`, które zwracają wartości tych atrybutów.
Jak widzimy w powyższym przykładzie wykorzystane atrybuty nie muszą być
nigdzie deklarowane (jak to ma miejsce np. w Javie).

Standardowo wszystkie niezainicjowane atrybuty posiadają wartość `nil`, zatem
nie musimy obawiać się, że odwołanie do atrybutu, do którego nie przypisano
wcześniej żadnej wartości skutkuje pojawieniem się błędu `NameError`.

Definiowanie metod pozwalających na odczytanie lub zapisanie wartości
atrybutów instancyjnych jest zjawiskiem tak powszechnym, że twórca języka
Ruby czyli Matz, uznał za stosowne wprowadzenie pewnych pomocniczych metod, które
pozwoliłyby na realizację tego zadania w sposób bardziej zwięzły.
Metody o których mowa (zwane również makrami) to **`attr_reader, attr_writer`**,
**`attr_accessor`** oraz **`attr`**.
Każda z nich ma nieco inną semantykę, ale skoncentrujemy
się na trzech pierwszych, gdyż wywołania ostatniej mogą być z powodzeniem
zastąpione wywołaniami jednej z trzech pierwszych.

Metoda `attr_reader` akceptuje listę symboli i dla każdego z nich tworzy
metody pozwalające na **odczytanie wartości** atrybutu o takiej samej
nazwie jak nazwa symbolu. Metoda `attr_writer` ma podobną składnię,
z tą różnicą, że tworzy metody pozwalające na **ustawienie wartości**
odpowiednich atrybutów. Ostatnia metoda jest jakby sumą dwóch wcześniej
opisanych metod, gdyż tworzy metody pozwalające \*zarówno na odczytanie,
jak i ustawienie wartości\* odpowiednich atrybutów.

```ruby
class Program
attr\_reader :java\_code
attr\_writer :perl\_code
attr\_accessor :ruby\_code
def initialize(java)
`java_code = java
  end
  def run
    puts "In Ruby"
    eval "#{`ruby\_code}"
puts "In Perl"
Kernel.system "perl -e '\#{@perl\_code}'"
end
end
hello\_world = Program.new(&lt;&lt;-END
class Hello {
public static void main(String\[\] args){
System.out.println("Hello world![](");
  }
}
END
)
hello_world.java_code = "class Nothing{}"
 # NoMethodError: undefined method `java_code=' for...
hello_world.perl_code = 'print "Hello world)\\n"'
hello\_world.ruby\_code = "puts 'Hello world!'"
puts hello\_world.java\_code
\#class Hello {
\# public static void main(String\[\] args){
\# System.out.println("Hello world![](");
 #  }
 #}
puts hello_world.perl_code
 # NoMethodError: undefined method `perl_code' for #<Program:0xb789be8c>
puts hello_world.ruby_code
 # puts 'Hello world)'
hello\_world.run
\# In Ruby
\# Hello world!
\# In Perl
\# Hello world!
```

W powyższym (nieco zagmatwanym) przykładzie definiujemy klasę
`Program`, która potrafi reprezentować kod programu w językach: Perl,
Ruby oraz Java. Ponieważ praca z Javą powoduje czasami powstawanie
olbrzymich ilości kodu, który trudno jest pielęgnować uznaliśmy, że
kod w Javie będzie tylko do odczytu. Z kolei Perl czasami zwany
jest "write only languge" (język tylko do zapisu), dlatego też
kod w Perlu może być w naszym programie tylko zapisywany, ale
nie odczytywany. Na koniec zaś - kod w Ruby może być zarówno
odczytywany jak i zapisywany. Metoda `run` pozwala uruchomić
kod zapisany w Ruby za pomocą wywołania `eval` oraz kod
zapisany w Perlu, za pomocą wywołania systemowego.

### Atrybuty klasowe

Drugi typ atrybutów, który często spotykany jest w obiektowych
językach programowania to tzw. **atrybuty klasowe**. W przybliżeniu
można powiedzieć, że atrybuty te są dostępne dla wszystkich obiektów
danej klasy, ale stowarzyszone są z tylko z klasą. Tym niemniej błędne
byłoby przypuszczenie, że są to atrybuty instancyjne obiektu klasy `Class`
(czyli obiektu danej klasy). Sprawa jest nieco zagmatwana i zostanie
wyjaśniona w następnym rozdziale. To co należy zapamiętać o zmiennych
klasowych w języku Ruby, to fakt, że są one współdzielone przez
wszystkie klasy w hierarchii dziedziczenia.

Do zmiennych klasowych odwołujemy się poprzedzając ich nazwę dwoma znakami
@@, np.

```ruby
class Figure
`@instances = 0
  def initialize(shape)
    `shape = shape
`@instances += 1
    `id = `@instances
  end
  def to_s
    "[#{`id}\] \#{@shape}"
end
end
f1 = Figure.new("oval")
puts f1
\# \[1\] oval
f2 = Figure.new("triangle")
puts f2
\# \[2\] triangle
```

W powyższym przykładzie definiujemy klasę `Figure`, która posiada zmienną
klasową `@`instances`, w której przechowywana jest liczba instancji klasy
`Figure`. Klasa ta definiuje również metodę `to\_s@, która wywoływana jest
w momencie, gdy potrzebna jest reprezentacja obiektu w postaci łańcucha
znaków. Widzimy, że pierwsza stworzona figura ma identyfikator o
wartości 1, natomiast druga - o wartości 2. Nieco bardziej interesujący
jest przykład następny:

```ruby
class Figure
`@instances = 0
  def initialize
    ``instances += 1
    `id = `@instances
  end
  def to_s
    "[#{`id}\] " + self.class.to\_s
end
end
class Oval &lt; Figure
`@instances = 0
end
class Triangle < Figure
  `@instances = 0
end
oval = Oval.new
puts oval
\# \[1\] Oval
triangle = Triangle.new
puts triangle
\# \[2\] Triangle
```

W powyższym przykładzie definiowane są trzy klasy: `Figure, Oval` i `Triangle`.
W klasie `Figure` definiowana jest zmienna klasowa `@`instances`, która,
podobnie jak w poprzednim przykładzie, służy do inicjowania identyfikatorów
obiektów. Ciekawe jest jednak to, że pomimo ponownego zdefiniowania
tej zmiennej w klasach potomnych, we wszystkich obiektach tych klas
dostępna jest tylko jedna zmienna klasowa. Widzimy wyraźnie, że
obiekty `oval@ i `triangle` należą do innych klas, a mimo to współdzielą
zmienną klasową `@`instances@. Ta własność Ruby przez niektórych uznawana
jest jako mało intuicyjną. Trudno też wyjaśnić dokładnie z jakimi
obiektami stowarzyszone są zmienne klasowe.

Metody
------

**Metody**, obok atrybutów, stanowią podstawowe instrumentarium języków zorientowanych
obiektowo. Chociaż w tym rozdziale pojawiły się już definicje wielu metod,
to nie poświęcono im dotychczas szczególnej uwagi. W tym punkcie przedstawimy zatem
podstawowe informacje dotyczące metod: ich definiowania, widoczności, etc.

### Metody instancyjne

Definicje metod, podobnie jak definicje funkcji, rozpoczynają się słowem
kluczowym `def`, po którym następuje nazwa metody oraz lista jej parametrów.
Jedyna różnica w definicji metody w stosunku do definicji funkcji polega
na tym, że definicja tej pierwszej pojawia się wewnątrz definicji klasy:

```ruby
def function(param)
puts param
end
class Example
def method(param)
puts param
end
end
```

Wywołanie metody, w przeciwieństwie do wywołania funkcji może być dokonywane
tylko na rzecz określonego obiektu. Obiekt ten dostępny jest w ciele metody
poprzez słowo kluczowe `self`. W rzeczywistości w funkcjach pod tym słowem
również kryje się pewien obiekt, ale nie pojawia się on w wywołaniach funkcji:

```ruby
def function
self
end
class Example
def method
self
end
end
function
\#=&gt; main
obj1 = Example.new
obj2 = Example.new
obj1.method
\#=&gt; \#<Example:0xb79ae310>
obj2.method
\#=&gt; \#<Example:0xb79ac254>
```

W powyższym przykładzie w metodzie `method` widnieje odwołanie do obiektu,
na rzecz którego metoda ta jest wywoływana. Widzimy zatem, że metoda
`method` wywołana na rzecz obiektów `obj1` oraz `obj2` zwraca różne wartości,
zatem w dwóch jej wywołaniach pod słowem kluczowym `self` ukrywa się inny obiekt.

Poza dostępem do obiektu, na rzecz którego wywołana jest dana metoda, w jej
definicji mogą się również bezpośrednio pojawić atrybuty instancyjne danego obiektu,
a także atrybuty klasowe klasy, której jest on egzemplarzem (lub jednej z klas
nadrzędnych wobec niej). Własności te były już zaprezentowane przy omawianiu atrybutów.

### Metody klasowe

Oczywiście wszystkie wymienione własności odnoszą się do **metod instancyjnych**
zdefiniowanych w danej klasie. Obok nich, podobnie jak w przypadku atrybutów,
mogą występować **metody klasowe**, które mogą być definiowane aż na 3 różne
sposoby. W tym miejscu zaprezentujemy tylko dwa z nich, ponieważ wprowadzenie
trzeciego sposobu (który *nota bene* dosyć często pojawia się w kodzie), musi
być uzupełnione pewnymi dodatkowymi uwagami, które zostaną przedstawione w
rozdziale następnym.

Pierwszy sposób definiowania metod klasowych polega na \*poprzedzeniu nazwy metody
nazwą klasy\* zakończonej kropką:

```ruby
class Figure
`@instances = 0
  def Figure.instances
    `@instances
end
end
```

Drugi sposób polega na **poprzedzeniu nazwy metody słowem kluczowym `self`**:

```ruby
class Figure
`@instances = 0
  def self.instances
    `@instances
end
end
```

W powyższych przykładach definiowana jest metoda klasowa `Figure.instances`,
która zwraca wartość zmiennej klasowej `@`instances`. W rzeczywistości
obie definicje są tożsame, gdyż `Figure@ oraz `self` odnoszą się do tego
samego obiektu - obiektu klasy `Class`, czyli definiowanej klasy. Przypomnijmy -
zdefiniowanie klasy powoduje utworzenie obiektu klasy `Class`, który automatycznie
przypisywany jest do stałej takiej samej jak nazwa definiowanej klasy.

### Metody specjalne

Ciekawą własnością języka Ruby jest to, że w nazwach metod mogą pojawiać się
\*znaki specjalne ![](,?* a także *operatory +, -, =,* etc. Ta druga cecha obecna
jest np. w języku C++, tym niemniej definiowanie operatorów w Ruby jest
znacznie przyjemniejsze. Natomiast znaki specjalne ) i ?, choć nie wpływają
w żaden sposób na konstrukcję wyrażeń (operatory mogą być wywoływane bez
kropki występującej pomiędzy obiektem, a nazwą wywoływanej metody), to
jednak, ze względu na konwencje stosowane w języku, również pozwalają poprawić
czytelność kodu. Konwencja ta zakłada, że \*metody zakończone znakiem zapytania to
predykaty\*, czyli metody zwracające wartości logiczne. Z kolei \*wykrzyknik
na końcu metody\* oznacza, że jest ona \*potencjalnie niebezpieczną wersją metody
o takiej samej nazwie, lecz bez wykrzyknika\*. Tę konwencję
mogliśmy zaobserwować przy omówieniu podstawowych typów język Ruby.
(Więcej na temat tej konwencji można przeczytać na [Blogu Radarka](http://radarek.jogger.pl/2009/02/21/ruby-a-metody-z-i-w-nazwie/) )

```ruby
class Mind
INNATE\_IDEAS = \[
"God exists",
"2 + 2 = 4",
"I think therefore I am"
\]
def initialize
`ideas = []
  end
  def any_ideas?
    !`ideas.empty?
end
def brain\_wash!
`ideas.clear
  end
  def say_something
    `ideas\[rand(`ideas.size)].to_s
  end
  def <<(idea)
    `ideas &lt;&lt; idea
end
def think(ideas)
`ideas += ideas
  end
  def Mind.new_idea
    Idea.new(INNATE_IDEAS[rand(3)])
  end
end
class Idea
  attr_reader :verbal_expression
  def initialize(content)
    `verbal\_expression = content
end
def +(other)
Idea.new(`verbal_expression + "." +  other.verbal_expression)
  end
  def to_ary
    `verbal\_expression.split(".").collect{|ve| Idea.new(ve)}
end
def to\_s
@verbal\_expression
end
end
cartesian\_mind = Mind.new
cartesian\_mind.any\_ideas?
\#=&gt; false
cartesian\_mind &lt;&lt; Mind.new\_idea
cartesian\_mind.any\_ideas?
\#=&gt; true
cartesian\_mind.say\_something
\#=&gt; "I think therefore I am"
cartesina\_mind.brain\_wash!
cartesian\_mind.any\_ideas?
\#=&gt; false
stupid\_idea1 = Idea.new("Pineal gland is the seat of the soul")
stupid\_idea2 = Idea.new("Animals are machines")
cartesian\_mind.think(stupid\_idea1 + stupid\_idea2)
cartesian\_mind.say\_something
\#=&gt; "Pineal gland is the seat of the soul"
```

W powyższym przykładzie można zaobserwować w jaki sposób metody operatorowe oraz
metody zakończone znakami specjalnymi poprawiają czytelność kodu. Zdefiniowane zostały
dwie klasy `Mind` oraz `Idea`. W pierwszej klasie metoda `any_idea?` wartość `true`,
jeśli w umyśle znajdują się jakieś myśli, natomiast `brain_wash!` powoduje, że
wszystkie myśli są usuwane (niestety nie jest to najlepszy przykład użycia wykrzyknika...).
Ponadto dla umysłu został zdefiniowany operator `<<`, który
pozwala dodawać do niego nowe myśli.

W klasie `Idea` pojawiają się natomiast dwie dodatkowe metody `to_s` oraz `to_ary`.
Metody zaczynające się na `to_` stosowane są do konwertowania obiektów jednych
klas na obiekty innych klas. W pierwszy wypadku obiekt zamieniany jest na łańcuch
znaków, a metoda ta jest standardowo używana do wyświetlania tekstowej reprezentacji
danego obiektu. Dlatego też, pomimo tego, że w umyśle przechowywane są obiekty
klasy `Idea`, metoda `say_something` powoduje wyświetlenie odpowiedniego łańcucha znaków.
Metoda `to_ary` pozwala natomiast przekształcić obiekt danej klasy w tablicę - bez
jej zdefiniowania niemożliwe byłoby przekazanie do metody `think` sumy dwóch myśli.

### Dostępność metod

Jedną z ważnych własności języków zorientowanych obiektowo jest możliwość ukrywania implementacji
pod ściśle określonym interfejsem, za pomocą którego można zmieniać stan obiektu.
Jak pokazaliśmy wcześniej - dostęp do atrybutów danego obiektu odbywa się za pomocą
metod o nazwie takiej jak nazwa atrybutu. Ukrywanie atrybutów nie pokrywa jednak
w pełni problemu ukrywania implementacji - często w trakcie rozwoju danej klasy
pojawiają się w niej metody pomocnicze, które nie powinny być udostępniane w jej
publicznym interfejsie. Z tego też względu w językach zorientowanych obiektowo
pojawiają się metody o różnym dostępie, najczęściej: **publiczne, chronione i prywatne**.
W Ruby również można specyfikować dostępność danej metody, ale semantyka poszczególnych
trybów jest nieco inna niż np. w Javie.

Przypomnijmy - Ruby jest językiem zorientowanym obiektowo, zatem tym podstawowym kontekstem,
wobec którego określa się semantykę różnych konstrukcji języka są obiekty, a nie np. klasy.
Dlatego też dostępność metod określana jest w kontekście obiektów. I tak: **metody prywatne** to
metody, które mogą być wywoływane **tylko przez dany obiekt na rzecz samego siebie**.
Innymi słowy są one tylko i wyłącznie wywoływane na rzecz obiektu, który kryje się
pod słowem kluczowym `self`. Nie ma jednak znaczenia, gdzie zdefiniowana jest dana metoda!
W przeciwieństwie do Javy, w Ruby metody prywatne mogą być zatem wywoływane również
w metodach zdefiniowanych w klasach potomnych. Z drugiej strony - obiekty należące do
tej samej klasy **nie mogę wywoływać swoich metod prywatnych**.

**Metody chronione** to metody, które mogą być wywoływane przez obiekty \*tej samej klasy
oraz jej klas potomnych\*. **Metody publiczne** mogą być zaś wywoływane w **dowolny kontekście**,
czy to przez obiekty innych klas, czy też z głównego poziomu programu, byleby określony
był obiekt, na rzecz którego wywoływana jest dana metoda.

Dostępność metod określana jest za pomocą słów kluczowych **`private`**, **`protected`** oraz **`public`**.
Domyślnie jeśli w definicji klasy nie określimy dostępności metody, to jest ona publiczna.
Jeśli zaś chcemy zawęzić jej dostępność, możemy skorzystać z dwóch sposobów.
Pierwszy polega na użyciu specyfikatora dostępu (np. `private`), po którym następuje
lista symboli odpowiadających nazwom metod prywatnych. Istotne jest to, że definicje
metod, które pojawiają się na liście muszą pojawić się **przed** specyfikatorem dostępu.
Drugi sposób polega na użyciu
specyfikatora dostępu bez listy argumentów - wtedy wszystkie metody, aż do następnego
specyfikatora (lub końca definicji klasy) otrzymają określony dostęp.

```ruby
class Accessible
\# public method
def foo
end
\# private methods
def fus
end
private :fus
private
def bar
end
def baz
end
\# protected methods
protected
def dip
end
def dup
end
end
```

W definicji powyższej klasy tylko metoda `foo` jest publiczna. Metody `fus`, `bar` i `baz` są
prywatne, natomiast metody `dip` i `dup` są chronione.

TODO: więcej przykładów

Podsumowanie
------------

W niniejszym rozdziale przedstawiliśmy podstawowe własności obiektowe języka Ruby.
Omówiona została ogólna filozofia stojąca za takimi pojęciami jak obiekty i klasy, przedstawione
zostały też podstawowe mechanizmy języków zorientowanych obiektowo takie jak dziedziczenie,
czy ukrywanie implementacji.

Jednakże język Ruby oferuje znacznie więcej ponad to, co zostało przedstawione w tym rozdziale.
Właśnie te zaawansowane własności powodują, że zdobywa on tak dużą popularność.
Najważniejsze z nich zostały omówione w rozdziale zatytułowanym [Zagadnienia zaawansowane](/dydaktyka/ruby/intro/zagadnienia-zaawansowane).

[Poprzedni rozdział](/dydaktyka/ruby/intro/struktury-jezyka) |
[Następny rozdział](/dydaktyka/ruby/intro/zagadnienia-zaawansowane)
