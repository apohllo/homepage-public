---
title: Metaprogramowanie
date: '2008-01-31T08:31:00Z'
lastmod: '2008-02-20T17:26:34Z'
draft: false
tags:
- java
- ruby
- rails
- eclipse
author: 83.175.191.74
toc: true
---

[Poprzedni rozdział](/dydaktyka/ruby/intro/zagadnienia-zaawansowane) |
[Następny rozdział](/dydaktyka/ruby/intro/co-dalej)

Metaprogramowanie to temat, który w kontekście języka Ruby zyskał szczególnego
znaczenia. Niektóre z omówionych wcześniej technik (np. introspekcja,
rozszerzanie klas wbudowanych, aliasowanie metod) mogłyby zostać
w pewnym stopniu objęte tym terminem. W rzeczywistości metaprogramowanie
nie sprowadza się do jednej konstrukcji językowej - obejmuje szereg
instrumentów dostarczonych przez język.

Jak napisaliśmy w poprzednim rozdziale - metaprogramowanie to programowanie na poziomie
klas, czyli obiektów klasy `Class`, które stoi w opozycji do zwykłego
programowania, którego przedmiotem są instancje tych klas.
Postawienie wyraźnej granicy pomiędzy tymi sposobami programowania nie jest
wcale takie proste, gdyż wywołanie metody `is_a?`, która sprawdza pewne
własności klasy danego obiektu, może być już potraktowane jako przejaw
metaprogramowania.

Tym niemniej w kontekście języka Ruby termin metaprogramowanie ma zazwyczaj
nieco inny sens - chodzi o możliwość \*dodawania pewnych własności do klas
wykorzystując do tego pewien algorytm\*. Można powiedzieć, że te nowe
własności są dopiero obliczane w trakcie wykonania programu. Oczywiści
taka sytuacja nie dziwi nas w kontekście programowania obiektów -
wiadomo, że stan danego obiektu, zależy od wcześniejszych obliczeń, które
zostały wykonane z jego udziałem. Teraz jednak obiektem tym jest klasa.
Zatem zachowanie *klasy obiektów* określane jest przez pewne obliczenie,
które dokonuje się dopiero w trakcie wykonania programu.

Metaprogramowanie zatem często będzie sprowadzało się do dodawania, modyfikowania
a nawet usuwania metod w klasach, które obejmuje.

Wykonywanie kodu w kontekście klasy
-----------------------------------

Aby uczynić nasze rozważania bardziej konkretnymi, pokażmy prosty przykład
zastosowania tej techniki. Wykorzystana jest w nim metoda **`class_eval`**,
która przyjmuje kod w postaci bloku lub łańcucha znaków i
powoduje dołączenie go do klasy, w kontekście której jest wywoływana:

code(ruby).
class Alphabet
('a'..'z').each do |letter|
class\_eval &lt;&lt;-END
def \#{letter}
"\#{letter}"
end
END
end
end
alpha = Alphabet.new
alpha.a
\#=&gt; "a"
alpha.b
\#=&gt; "b"

Uwaga

Stosowana przeze mnie bibliotek do kolorowania składni nie jest doskonała,
dlatego pomimo tego, że wszystko co znajduje się pomiędzy słowami END
jest zwykłym łańcuchem znaków, rozpoznaje w nim słowa kluczowe.

W powyższym przykładzie w klasie `Alphabet` dla każdej małej litery
łacińskiego alfabetu definiowana jest metoda o takiej samej nazwie,
zwracająca tę literę. Całość opiera się na tym, że metoda `class_eval`
wywoływana jest wielokrotnie dla łańcucha znaków uzupełnianego
kolejnymi literami alfabetu. Powyższy kod w tradycyjny sposób
można by zapisać następująco:

code(ruby).
class Alphabet
def a
"a"
end
def b
"b"
end
def c
"c"
end
\# itd.
end

Widzimy zatem, że kod, który zapisany w tradycyjny sposób byłby bardzo
długi, z wykorzystaniem metaprogramowania, uległ znacznemu skróceniu.

Oczywiście rzadko kiedy przydatne jest definiowanie klasy, która
posiadałaby tak nieprzydatne metody. Co nie znaczy, że sama technika
jest nieprzydatna - wręcz przeciwnie. Jest ona przedstawiona
np. w książce "Rails - przepisy" do stworzenia własnych wersji
metod pomocniczych dla formularzy wykorzystywanych na stronach
internetowych. Jeśli chcemy zachować spójny wygląd różnych elementów
formularza (np. dodać etykietę, otoczyć paragrafem lub umieścić w tabeli),
nie wystarczy nam czysty `CSS` - konieczne jest wygenerowanie
odpowiedniego HTML-a. Każdy element formularza modyfikowana jest jednak
w taki sam sposób, a biorąc pod uwagę ich dosyć dużą liczbę,
zastosowanie tej techniki przynosi realne korzyści.

Meta-definiowanie metod instancyjnych
-------------------------------------

Przywołane rozwiązanie jest o tyle niedoskonałe, że dołączany
kod jest ukryty w łańcuchu znaków. Bezpieczniej byłoby jednak zamiast niego
zastosować bloki kodu. (Nie chodzi tutaj tylko o poprawność
syntaktyczną, która może być poprawiona przez odpowiedni edytor,
ale np. o to, że część łańcucha może pochodzić od użytkownika, który nie
zawsze ma chlubne zamiary.)

Aby w powyższym przykładzie uniknąć tego problemu można wykorzystać
metodę **`define_method`**, która jak sama nazwa wskazuje, powoduje
zdefiniowanie metody w kontekście klasy, na rzecz której została wywołana.
To co różni ją od słowa kluczowego `def`, to
określanie nazwy metody poprzez symbol lub łańcuch znaków.
Przyjrzyjmy się najpierw
dwóm definicjom tej samej metody z wykorzystaniem słowa kluczowego
`def` oraz metody `define_method`:

code(ruby).
class Hello
def say(message)
puts "Hello " + message
end
define\_method :say do |message|
puts "Hello " + message
end
end
Hello.new.say "metaworld"
\#=&gt; "Hello metaworld"

W powyższym przykładzie obie definicje metody `say` są sobie równoważne.
Definicja wykorzystująca wywołanie `define_method` jest oczywiście
bardziej rozwlekła, a argumentu metody pojawiają się jako parametry
bloku, co czyni jej zapis bardziej skomplikowanym. Oczywiście stosowanie
tego wywołania w tej postaci mija się z celem. Możemy je natomiast
wykorzystać do poprawienia wcześniejszego przykładu z alfabetem:

code(ruby).
class Alphabet
('a'..'z').each do |letter|
class\_eval do
define\_method letter do
letter
end
end
end
end
alpha = Alphabet.new
alpha.a
\#=&gt; "a"
alpha.b
\#=&gt; "b"

Bingo! Możemy zatem definiować nowe metody w czasie wykonania programu.
Co więcej - ich nazwa może być również "obliczana". Zatem pierwsze
kroki na drodze do metaprogramowania zostały zrobione. Czas na kolejne.

Meta-definiowanie metod klasowych
---------------------------------

Przedstawiony sposób rozszerzania własności klas pozwala w zasadzie na
dodawanie dowolnych metod instancyjnych. Tym co stanowi o prawdziwej
sile metaprogramowania jest jednak możliwości dodawania i modyfikowania
**metod klasowych**. Oczywiście jeśli uważnie przeczytaliśmy rozdział
poświęcony programowaniu obiektowemu, a także poprzedni punkt - nie
jest dla nas zaskoczeniem, że w Ruby - skoro można dodawać metody
instancyjne - można również dodawać metody klasowe. Wszak klasy
są obiektami, a metody klasowe są po prostu metodami singletonowymi
tych obiektów. Tym niemniej właśnie to niezwykle spójne podejście
do obiektowości powoduje, że metaprogramowanie niewiele różni się
od zwykłego programowania, a w konsekwencji stanowi o sile tego języka.

### Klasa singletonowa zwykłej klasy

Jak zatem możemy **dodać metody klasowe** wykorzystując metaprogramowanie?
W stosunku do wcześniejszej metody istnieje tylko jedna różnica:
wywołanie `class_eval` powinny odbywać się nie na rzecz modyfikowanej
klasy, lecz jej **klasy singletonowej**. Reszta pozostaje identyczna:
Jak zatem można *dostać się do klasy singletonowej danej klasy?*
Istnieje idiom Ruby, który służy właśnie do tego:

code(ruby).
class &lt;&lt; self; self; end

Wywołany w kontekście klasy zwraca jej klasę singletonową.

Na pierwszy rzut oka wywołanie to jest bardzo dziwne. Problem bierze się
stąd, że występujące w nim słowo kluczowe `self` reprezentuje \*dwa
różne obiekty!\* Pierwsze wystąpienie odnosi się do obiektu klasy, do czyjej
klasy singletonowej chcemy się dostać. Drugie wystąpienie zaś odnosi
się właśnie do tej klasy singletonowej. Wyrażenie `class << self` "otwiera"
kontekst klasy singletonowej, zatem wewnątrz tego kontekstu słowo `self`
odnosi się właśnie do niej. W wyniku ewaluacji całego wyrażenia
zostaje właśnie zwrócona obiekt, który ukrywa się pod drugim słowem
`self`, którym będzie właśnie poszukiwana klasa singletonowa.

code(ruby).
class Person
def self.meta
class &lt;&lt; self
self
end
end
end
Person.meta
\#=&gt; \#<Class:Person>

W powyższym przykładzie w klasie `Person` zdefiniowana jest metoda klasowa
`meta`. Jej ciało stanowi wyrażenie pozwalające na dostęp do klasy
singletonowej (jest to bardziej rozwlekła postać wyrażenia `class << self; self; end` -
średniki zostały zastąpione znakami końca linii).
Wywołanie tej metody daje w wyniku klasę singletonową klasy `Person`.
Można ją rozpoznać po tym, że jej reprezentacja składa się ze
słowa `Class`, po którym następuje dwukropek oraz domyślna reprezentacja
obiektu, do którego jest ona dołączona (w przypadku klas jest to po
prostu ich nazwa).

### Metody klasowe

Skoro posiadamy już te wszystkie informacje, możemy przystąpić do
dodawania do naszej klasy metod klasowych. Jak wskazaliśmy wcześniej -
w stosunku do metod instancyjnych różnica polega tylko na tym, że
metoda `class_eval` wywoływana jest w kontekście klasy singletonowej,
a nie danej klasy. Zatem nasza definicja klasy `Alphabet` będzie
wyglądała następująco:

code(ruby).
class Alphabet
('a'..'z').each do |letter|
(class &lt;&lt; self; self; end).class\_eval do
define\_method letter do
letter
end
end
end
end
Alphabet.a
\#=&gt; "a"
Alphabet.b
\#=&gt; "b"

Powyższy kod zapisany w sposób tradycyjny wygląda następująco:

code(ruby).
class Alphabet
def self.a
"a"
end
def self.b
"b"
end
\# itd.
end

Poznaliśmy zatem podstawowe sposoby "metadodawania" metod instancyjnych
i klasowych. Najwyższy czas aby pokazać jakieś ciekawe, nietrywialne
przykłady wykorzystania tej techniki.

Przykład 1: `cattr_reader, cattr_writer, cattr_accessor`
--------------------------------------------------------

W rozdziale dotyczącym obiektowości przedstawione zostały m.in.
dwa zagadnienia: możliwość łatwego definiowania akcesorów dla zmiennych
instancyjnych (za pomocą konstrukcji `attr_accessor`), a także
dziwna własność zmiennych klasowych, polegająca na tym, że po ich
zdefiniowaniu w jakiejś klasie, ponowne ich zdefiniowanie w
klasach potomnych nie jest możliwe. Być może bardziej odpowiadałyby
nam nieco inne "atrybuty klasowe" - takie, które byłby związane
faktycznie z wybraną klasą, a nie całym drzewem dziedziczenie,
które z niej wyrasta. Co więcej, chcielibyśmy mieć możliwość
definiowania akcesorów dla tych atrybutów w taki sam sposób jak
definiowane są akcesory dla atrybutów instancyjnych, np.
przez wywołania `cattr_reader, cattr_writer` i `cattr_accessor`.

Aby spełnić pierwsze wymaganie można posłużyć się atrybutami
instancyjnymi obiektów klas. Każda klasa, jako obiekt, posiada
swoje własne zmienne instancyjne, dlatego też ich wykorzystanie
nie powoduje "zaśmiecenia" drzewa dziedziczenia.

Aby spełnić drugie wymaganie konieczne jest rozszerzenie klasy `Class`.
Dodanie do niej odpowiednich metod, spowoduje, że będą one mogły
być wykorzystywane dokładnie tak samo, jak wykorzystywane są wyrażenia
`attr_reader` i pozostałe.

code(ruby).
class Class
def meta
class &lt;&lt; self; self; end
end
def cattr\_reader(\*names)
meta.class\_eval do
attr\_reader \*names
end
end
def cattr\_writer(\*names)
meta.class\_eval do
attr\_writer \*names
end
end
def cattr\_accessor(\*names)
cattr\_reader(\*names)
cattr\_writer(\*names)
end
end
class A
cattr\_accessor :instances
self.instances = 0
def initialize
self.class.instances += 1
end
end
class B &lt; A
cattr\_accessor :instances
self.instances = 0
end
a = A.new
A.instances
\#=&gt; 1
B.instances
\#=&gt; 0
b = B.new
B.instances
\#=&gt; 1
A.instances
\#=&gt; 1

W powyższym przykładzie w klasie `Class` definiowane są metody `cattr_reader`,
`cattr_writer` oraz `cattr_accessor`, zgodnie z wcześniejszą propozycją.
Dzięki tym metodom, możemy dla klas definiować akcesory do ich atrybutów
instancyjnych, które mogą funkcjonować jak "poprawione" zmienne klasowe.

W naszym rozwiązaniu zdefiniowaliśmy najpierw metodę `meta`, która
pozwala na wygodny dostęp do klasy singletonowej danej klasy.
Następnie definiowane są metody `cattr_reader`, `cattr_writer` i
`cattr_accessor` korzystające z... wbudowanych konstrukcji `attr_reader`,
`attr_writer`! Rozwiązanie to działa, ponieważ wywołania te są
realizowane w kontekście klas singletonowych poszczególnych klas,
zatem odpowiednie metody dostępowe, stają się metodami klasowymi
tych klas.

Przykład ten jest na tyle pouczający, że warto go jeszcze trochę poeksploatować.

### Rozszerzanie języka

Pierwszy powód jest bardzo praktyczny - pozwala ukazać, że rozszerzanie
języka Ruby nie jest trudne. Metody `cattr_reader` i pozostałe
są na tyle przydatne, że pojawiły się np. w rozszerzeniach klas wbudowanych
dostarczonych w frameworku Ruby on Rails (ich definicje są jednak trochę inne,
ponieważ operują na zmiennych klasowych, a nie klasowo-instancyjnych).
Nie jest wykluczone,
że podobne konstrukcje będą wbudowane w sam język w przyszłych jego wersjach.
Tym niemniej przykład ten pokazuje, że \*dostosowanie języka do własnych
potrzeb\* jest możliwe i nie nastręcza poważniejszych problemów, o ile
opanujemy podstawowe zagadnienia metaprogramowania.

### Przesada

Drugi powód związany jest z zaleceniem, które pojawiło się na początku tego
rozdziału - nie powinniśmy przesadzać z tymi wszystkimi magicznymi
własnościami języka. Za przesadę uważam następujące rozwiązanie przedstawionego
problemu:

code(ruby).
class Class
def meta
class &lt;&lt; self; self; end
end
%w{reader writer accessor}.each do |postfix|
class\_eval do
define\_method "cattr\_" + postfix do |\*names|
meta.class\_eval do
send("attr\_" + postfix, \*names)
end
end
end
end
end

Oczywiście jeśli chcemy wygrać konkurs na */-/4xor4* roku, to możemy
tworzyć konstrukcje tego rodzaju. Niestety bardzo ujemnie wpływają one
na czytelność kodu. Przebywanie na meta-meta-meta-poziomach niech
pozostanie zarezerwowane dla filozofów. Programiści powinni jednak
bardziej twardo stąpać po ziemi (korzystając z terminologii Tarskiego:
wyrażać swoje myśli w języku przedmiotowym (nie mylić z obiektowym ;P )).

### Modyfikowanie atrybutów instancyjnych

Trzeci powód ma charakter dydaktyczny - otóż przykład ten możemy
wyrazić w nieco bardziej rozwlekły sposób, prezentując jednocześnie
pewne metody ważna w metaprogramowaniu. Przyjrzyjmy się
poniższemu kodowi:

code(ruby).
class Class
def meta
class &lt;&lt; self; self; end
end
def cattr\_reader(\*names)
names.each do |name|
meta.class\_eval do
define\_method name do
instance\_variable\_get("`"+name.to_s)
        end
      end 
    end
  end
  def cattr_writer(*names)
    names.each do |name|
      meta.class_eval do 
        define_method name.to_s + "=" do |val|
          instance_variable_set("`"+name.to\_s,val)
end
end
end
end
def cattr\_accessor(\*names)
cattr\_reader(\*names)
cattr\_writer(\*names)
end
end

Oczywiście powyższy kod realizuje to samo zadanie co wcześniej.
Na czym zatem polega różnica? Otóż nie idziemy w nim na skróty
korzystając z metod `attr_reader`,... ale definiujemy
każdą z metod z osobna. Dzięki temu możemy dokładnie zobaczyć
co dzieje się "pod spodem" i wykorzystać to w przypadku, gdy
wcześniejsze rozwiązanie nie będzie wystarczające.

Dokładna implementacja metod `attr_reader` i `attr_writer` jest
bardzo podobna - z grubsza z tą różnicą, że w pierwszej z nich
wykorzysta jest metoda **`instance_variable_get`**, a w drugiej
**`instance_variable_set`**. Cóż to za metody? Jak sama nazwa wskazuje...
pierwsza z nich pozwala odczytać, a druga ustawić wartość \_zmiennej
instancyjnej o nazwie przekazanej jako parametr\_. Hmm...
Czy nie łamie to enkapsulacji, zapyta fan metodyki obiektowej?
Tak, łamie. Co gorsza - metody te są *publiczne!*

Skąd zatem wzięły się tego rodzaju metody i po co nam one?
Zwróćmy po pierwsze uwagę, że nie zostały one omówione w rozdziale
dotyczącym programowania obiektowego, a na pierwszy rzut oka
tam właśnie powinny się znaleźć. Napisałem wręcz, że nie mamy
innego dostępu z zewnątrz do zmiennych instancyjnych, niż poprzez
dobrze zdefiniowane metody. Można napisać, że skłamałem! No możne
nie do końca, bo `instance_variable_get/set` też są metodami,
ale mało komu przyszłoby do głowy reimplementować je we własnej
klasie, tak żeby zabezpieczyć się przed "majstrowaniem" przy stanie
obiektu.

Metody te przewidziane są właśnie do obsługi takich specjalnych
przypadków - z powodzeniem mogą być stosowane w technikach
metaprogramowania, ale na pewno nie powinno się ich wykorzystywać
w zwykłym programowaniu! Od tego mamy interfejs klasy, aby z niego
i tylko z niego korzystać. Z drugiej strony, jeśli weźmiemy pod
uwagą, że w Ruby istnieje wywołanie **`eval`** (którego omówienie
ominąłem aż do tej chwili), pozwalające na wykonanie \*dowolnego
kodu przekazanego jako łańcuch znaków\*, wszelkie konstrukcje
tego rodzaju są jedynie niewinną igraszką. Aby dostać się
do wartości zmiennej moglibyśmy np. zdefiniować metodę, która
zwracałaby wartość tej zmiennej, wywołać ją, a na koniec
usunąć i żadne mechanizmy nie zabezpieczyłyby nas przed takimi
"czarami". Dzięki metodom takim jak `instanve_variable_get` nie musimy
uciekać się nieustannie do takich sztuczek - ich wykorzystanie
powoduje, że to co mogło być ukryte w łańcuchu znaków, teraz jest
"powiedziane wprost", innymi słowy - jest bardziej czytelne.

Dzięki takim rozwiązaniom język Ruby wydaje się zachowywać balans
pomiędzy ograniczeniami jaki narzuca, a możliwościami jakie oferuje.
Jeśli chcemy zrobić *coś zwykłego* - możemy to zrobić *w prosty sposób*
(*vide* zdefiniowanie akcesorów dla atrybutów instancyjnych).
Jeśli chcemy zrobić *coś niezwykłego i potencjalnie niebezpiecznego*
- możemy to zrobić, ale *wymaga to pewnego wysiłku* (*vide* dostęp
do metaklasy, manipulowanie zmiennymi instancyjnymi), chociażby
nawet wysiłek ten miał sprowadzać się do wprowadzanie większej
liczby znaków na klawiaturze.

Skoro zatem uznaliśmy sensowność tego rodzaju mechanizmów, możemy
przystąpić do analizy rozwiązania przedstawionego powyżej. W przypadku
metody `cattr_reader`, dla każdego jej argumentu definiowana
jest metoda o takiej samej jak on nazwie, która pobiera wartość
zmiennej instancyjnej też o tej samej nazwie. Metoda `instance_variable_get`
wymaga aby nazwa atrybutu poprzedzona była znakiem @, dlatego
jest on dodawany do nazwy definiowanej metody.

Podobnie jest w przypadku metody `cattr_writer` - definiowane są
metody o nazwach takich jak atrybuty, uzupełnione znakiem =.
Dlatego też metody te mogą stawać po lewej stronie instrukcji przypisania.
Definiowane metody akceptują jeden argument, który przekazywany jest do
metody `instance_variable_set`, ustawiającej wartość odpowiedniego
atrybutu.

Ostatnia metoda sprowadza się do wywołania dówch wcześniejszych - nie
ma tutaj żadnej magii.

Przykład 2: ActiveRecord
------------------------

Możliwość rozszerzania języka, w sposób który tutaj został przedstawiony,
na pewno będzie atrakcyjna dla części programistów. Tym niemniej
z pewnością istnieje grupa nieprzekonanych, którzy myślą sobie -
co mi to właściwie daje? Mam nadzieję, że kolejny przykład pozwoli
ich przekonać. Pochodzi on również z frameworku Ruby on Rails.
Dla osób, które korzystają z niego nie opanowawszy wszystkich
arkanów języka, może on się wydać na tyle znany, że aż oczywisty.
Jednakże jego zrozumienie bez znajomości technik metaprogramowania
jest *de facto* niemożliwe.

Chodzi mi o pierwsze lepsze makro z klasy `ActiveRecord::Base`
(ActiveRecord to system mapowania obiektowo-relacyjnego, stanowiący
jeden z elementów frameworku Ruby on Rails), np.
`has_many` czy `belongs_to`. Pierwsze pozwala na wyrażenie relacji jaka zachodzi
pomiędzy dwoma klasami - wskazuje, że jedna instancja pewnej
klasy może być powiązana z wieloma instancjami drugiej klasy.
Drugie jest odwrotnością pierwszego.

Weźmy klasyczny przykład z koszykiem:

code(ruby).
class Item &lt; ActiveRecord::Base
belongs\_to :cart
end
class Cart &lt; ActiveRecord::Base
has\_many :items
end
my\_cart = Cart.new
item1 = Item.new
item2 = Item.new
my\_cart.items &lt;&lt; item1
my\_cart.items &lt;&lt; item2

W powyższym przykładzie definiowane są dwie klasy dziedziczące
z `ActiveRecord::Base`: `Item` oraz `Cart`. Pierwsza z nich
reprezentuje jakiś obiekt, który może pojawić się w koszyku (np.
oklepaną książkę), natomiast druga właśnie ów koszyk.

Na pierwszy rzut oka - nic specjalnego. Tym niemniej kiedy przyjrzymy
się sposobowi użycia obiektu klasy `Cart`, możemy
zastanawiać się skąd wzięła się metoda `items`? Na pewno nie została
*zdefiniowana* w klasie `ActiveRecord::Base`. Dodam jeszcze, że
powyższa definicja jest całkowicie wystarczająca, aby przedstawione
rozwiązanie zaczęło działać (tzn. pokazana jest cała definicja klasy
`Cart`).

Oczywiście wszystko tkwi w wywołaniu `has_many :items` - to ono musiało
spowodować **dodanie** metody `items` do klasy `Cart`! A czy mogło
zostać dodane bez uciekania się do metaprogramowania?
Oczywiście nie.

Wywołanie makra `has_many` na rzecz danej klasy, powoduje dodanie do niej
metody o nazwie takiej jak jego pierwszy argument. Dodatkowo makro
to akceptuje również opcjonalne parametry (np. nazwę tabeli w bazie danych,
nazwę klucza, itp.) Te informacje składowane są w atrybutach klasowo-instancyjnych
danej klasy i wykorzystywane w utworzonym wywołaniu do skonstruowania adekwatnego
wywołania SQL-a. Ponieważ wykorzystywane są techniki metaprogramowania -
utworzone metody, z punktu widzenia użytkownika tych klas, nie różnią się
niczym od pozostałych metod - mogą być wykorzystywane bezpośrednio w kodzie,
są widoczne w klasach pochodnych, itp.

### ActiveRecord a Hibernate

Jeśli porównamy rozwiązanie zaproponowane w ActiveRecord z rozwiązaniem stosowanym
w popularnej bibliotece ORM języka Java - Hibernate, zobaczymy jak wielka jest
przewaga tego pierwszego nad drugim. Mapowanie w AR (skrót od ActiveRecord) jest definiowane
bezpośrednio w klasie, a nie w zewnętrznych plikach XML, co znacząco ułatwia
utrzymywanie spójności pomiędzy modelem obiektowym a modelem relacyjnym.
Co więcej - w AR nie musimy sami definiować metod służących do tworzenia
asocjacji pomiędzy obiektami, jak ma to miejsce w Java+Hibernate.
Dzięki temu definiowanie asocjacji bardzo przypomina definiowanie atrybutów -
wystarczy zadeklarować je w jednym miejscu i cała sprawa jest załatwiona.

Jednym z rozwiązań przedstawionego problemu dla Javy jest biblioteka XDoclet,
która również pozwala przechowywać mapowanie obiektowo-relacyjne razem
z kodem źródłowym. Ponieważ jednak odpowiednie pliki XML i tak muszą być
stworzone, każdorazowa modyfikacja tego mapowania pociąga za sobą konieczność
wygenerowania tych plików, co negatywnie wpływa na użyteczność tego rozwiązania.

Rozwiązania te zdecydowanie kontrastują z prostotą AR: jedna modyfikacja kodu
jest natychmiastowo odzwierciedlana we wszystkich istotnych miejscach.

Przykład 3: pluginy w Ruby on Rails
-----------------------------------

W poprzednim przykładzie starałem się pokazać jak dzięki technikom
metaprogramowania można tworzyć DSL (Domain Specific Language)-e,
a w konsekwencji wpłynąć na czytelność i spójność tworzonego kodu
(mapowanie obiektowo-relacyjne jest jedną z tych dziedzin, gdzie
stworzenie specjalnego języka mapowania jest wręcz niezbędne).

Tym niemniej w dobie **programowania komponentowego**, gdzie największy
nacisk kładzie się na możliwość ponownego wykorzystania kodu,
należy pokazać w jaki sposób metaprogramowanie może przyczynić się
do zaspokojenia wymagań tej technologii.

Jednym z testów na to, jaki *komponentowy potencjał* posiada
dany język lub platforma, jest możliwość tworzenia **rozszerzeń**,
zwanych często **pluginami**, które często utożsamia się z
reużytkowalnymi komponentami.

Tym czego przede wszystkim oczekuje się od pluginów, to możliwość
wykorzystani ich bez jakichkolwiek modyfikacji oryginalnej
struktury programu, czy samych pluginów, w czym zawiera się również
mechanizm ich automatycznego wykrywania, konfigurowania i uruchamiania.
Ponadto ważne jest
również, aby tworzenie rozszerzeń nie różniło się zbytnio od
tworzenia pozostałych elementów oprogramowania, a także brak
ograniczeń co do dostarczanych przez nie funkcjonalności.

Nie trudno domyśleć się, że spełnienie tych wszystkich, przeciwstawnych
wymagań jest zwykle dosyć trudne. W szczególności wymóg automatycznego
wykrywania oraz uruchamiania pluginów niesie poważne ograniczenia
dla języków które wymagają kompilowania kodu źródłowego przed uruchomieniem.
Zazwyczaj kod taki musi być dodatkowo wyposażony w plik *manifestu*,
w którym określone są jego komponentowe własności. W dalszej części
pokażemy jak problem ten został rozwiązany w popularnym w środowisku
Javy frameworku Eclipse, który posiada jeden z najbardziej rozbudowanych
*ekosystemów pluginów*. Teraz zaś postaramy się przedstawić na
przykładzie platformy Ruby on Rails jak wygląda możliwość
tworzenia komponentów w języku Ruby.

### Ładowanie pluginów

Zanim wskażemy te cechy języka, które są szczególnie przydatne
przy tworzeniu pluginów, musimy powiedzieć kilka słów o tym
jak działa system plugiów frameworku Rails. W największym skrócie
można powiedzieć, że pluginu trafia do katalogu
`vendor/plugins/nazwa_pluginu` i musi zawierać plik `init.rb`, którego kod
wywoływany jest automatycznie przy starcie całej aplikacji.
Dalej zaś katalog `lib`, który znajduje się w głównym katalogu
pluginu dołączany jest do listy katalogów, zawierających
kod źródłowy, które są przeszukiwane w momencie wywołania
dyrektywy `require`.

Choć pluginy mogą rozszerzać framework Ruby on Rails w nieco inny sposób,
to opisany tutaj mechanizm w zupełności wystarcza do zrozumienia dalszych
rozważań, dlatego też na nim poprzestaniemy.

### Modyfikowanie dowolnej metody z określonej klasy

Pierwszą cechą języka Ruby, na którą należy zwrócić uwagę w kontekście pluginów,
jest możliwość **modyfikowania zachowania dowolnych klas**. Wcześniej
pokazywaliśmy ją na przykładzie klas wbudowanych - tym niemniej
nie jest dla nikogo zaskoczeniem, że dotyczy ona dowolnej dostępnej
klasy. Mechanizm ten sprowadza się do tego, że klasa posiada wszystkie
te zachowania, które zostały zdefiniowane jako ostatnie. W szczególności:
jeśli jakaś metoda jest definiowana dwa razy, to zawsze wykorzystywana
jest ta definicja, która pojawiła się później (która później została
wczytana przez interpreter):

code(ruby).
class Changeable
def my\_name
"Changeable"
end
def my\_name
"I'm changing![]("
  end
end
changeable = Changeable.new
changeable.my_name
#=> "I'm changing)"
class Changeable
def my\_name
"Who knows my name?"
end
end
changeable.my\_name
\#=&gt; "Who knows my name?"

Dzięki tej własności języka możemy w zasadzie zmodyfikować każdy fragment
programu, *nie modyfikując a jedynie dodając* nowy kod źródłowy.
Zatem jeśli znamy API programu, dla którego tworzymy plugin, możemy
posunąć się nawet do tego, że *zastępujemy* jedną lub wiele metod w jakiejś
klasie. Tym o co musimy zadbać to właściwa kolejność wczytywania kodu
(musimy zapobiec sytuacji, w której nasza modyfikacja wczytana
jest przed modyfikowanym kodem). Problem ten może być rozwiązany poprzez
jawne dołączenie (za pomocą dyrektywy `require`) klasy, którą chcemy
zmodyfikować albo poprzez określenie kolejności wczytywanych pluginów
w pliku konfiguracyjnym aplikacji.

Podstawowym ograniczeniem tego rozwiązania jest to, że po dołączeniu
pluginu (np. poprzez umieszczenie modyfikacji w pliku `init.rb`),
nie mamy możliwości jej wyłączenia. Zmiana została dokonana,
a dostęp do wersji oryginalnej zmodyfikowanej metody jest
niemożliwy (o ile nie zastosowaliśmy mechanizmu aliasowania).

Znacznie lepszym rozwiązaniem byłaby możliwość uruchamiania
dostarczonej funkcjonalności na żądanie - np. tylko w wybranych
klasach, dziedziczących z modyfikowanej klasy. Takie rozwiązanie
pozwalałoby bowiem na stworzenie bardzo elastycznego mechanizmu
pluginów. Oczywiście dzięki metaprogramowaniu jest ono w zasięgu
ręki.

### Dodawanie opcjonalnych własności

Pożądany schemat modyfikacji dostarczanej przez plugin powinien
wyglądać następująco: nowa własność powinna pojawić się
tylko w niektórych klasach dziedziczących z klas (lub dołączających
moduły) znajdujące się w rozszerzanej aplikacji
(w tym wypadku frameworku Ruby on Rails).
Oczywiście - potencjalnie - własność ta powinna być
dostępna we wszystkich klasach dziedziczących z wybranej klasy
(dołączających moduł).

Najlepszą realizacją tego schematu jest dodanie w klasie bazowej
(tzn. będącej elementem frameworku) pewnej metody singletonowej
(innymi słowy - makra), której wywołanie powodowałoby aktywowanie
danego rozszerzenia w wybranej klasie. Mechanizm ten byłby
aktywowany w sposób podobny do wcześniej przedstawionego
mechanizmu określania asocjacji pomiędzy klasami. Wykorzystywane
rozszerzenie mogłoby nawet dostarczać cały DSL do realizacji
dostarczanych funkcjonalności.

Jako przykład weźmy wykorzystaną wcześniej klasę `ActiveRecord`.
Wyobraźmy sobie, że posiadamy kilka aplikacji opartych o
framework Ruby on Rails, w których potrzebujemy identycznej
funkcjonalności - obiekty niektórych klas modelu powinny posiadać
metody związane z czasem ich powstania i modyfikacji, np. pozwalające
określić czy dany obiekt jest *nowy* czy *stary* (w dziedzinie danego
modelu). Dodatkowe założenie polegałoby na tym, że w obrębie
wybranej klasy, przejście ze stanu *nowy* do *stary* jest
identyczne dla wszystkich obiektów (np. film jest stary jeśli
ma więcej niż 5 lat, a gazeta gdy ma więcej niż miesiąc, itp.)

Pierwsze rozwiązanie, które nie byłoby realizowane w duchu programowania
komponentowego, polegałoby na implementacji stosownych metod, takich
jak:

-   `new?` - zwracającej wartość prawda, jeśli obiekt byłby nowy,
-   `old?` - zwracającej wartość prawda, jeśli obiekt byłby stary,
-   `status` - zwracające stan (nowy/stary) obiektu,
-   `find_new` - zwracającej wszystkie nowe obiekty,
-   `find_old` - zwracającej wszystkie stare obiekty, etc.

w każdej z klas z osobna. Następny krok, mógłby polegać na wyodrębnieniu
wspomnianych metod do postaci modułu i dołączaniu go do każdej
z klas. Tym niemniej moduły te powtarzałyby się w odrębnych aplikacjach.
Ponadto samo dołączenie modułu byłoby niewystarczające - konieczne
byłoby jeszcze wywołanie metod, które dokonałyby stosownej *konfiguracji*
klasy. Kolejny krok polegałby na dołączeniu modułu w klasie bazowej
(w tym wypadku ActiveRecord) i takim zmodyfikowaniu modułu, aby
definiował on jedną metodę, która uruchamiałaby jego funkcjonalność
w danej klasie, a zarazem pozwalała na jej konfigurację.
Ostateczne rozwiązanie polegałoby na wyodrębnieniu wspomnianego
modułu w plugin i dołączeniu go do poszczególnych aplikacji.

Poniżej przedstawiamy ostateczny kształt naszego rozwiązania.
Nasz plugin nazwiemy `acts_as_timed`. Railsy dostarczają
skrypt generujacy pluginy:

`$ script/generate plugin acts_as_timed`

W wyniku jego wywołania, w katalogu `vendor/plugins/acts_as_timed`
pojawia się m.in. plik `init.rb`, który modyfikujemy w sposób
następujący:

code(ruby).
require 'acts\_as\_timed'
class ActiveRecord::Base
include Apohllo::Acts::Timed
end

Na początku dołączany jest (jeszcze niezdefiniowany) plik `acts_as_timed.rb`
z katalogu `vendor/plugins/acts_as_timed/lib`. Dalej zaś do
klasy `ActiveRecord::Base` dołączany jest (jeszcze niezdefiniowany)
moduł `Timed` znajdujący się w przestrzeni nazw `Apohllo::Acts::`.

Poniżej przedstawiona jest zawartość pliku `acts_as_timed.rb`:

code(ruby).
module Apohllo
module Acts
module Timed
def self.included(mod)
mod.extend(ClassMethods)
end
module ClassMethods
def acts\_as\_timed(options={})
extend Apohllo::Acts::Timed::ClassMethods
include Apohllo::Acts::Timed::InstanceMethods
(class&lt;&lt;self; self;end).class\_eval{attr\_reader :old}
`old = options[:old] || 1.year
        end
      end
      module SingletonMethods
        def find_new
          find(:all, :conditions => ["created_at > ?", Time.now - `old\])
end
def find\_old
find(:all, :conditions =&gt; \["created\_at &lt; ?", Time.now - @old\])
end
end
module InstanceMethods
def new?
self.created\_at &gt; Time.now - self.class.old
end
def old?
!new?
end
def status
new? ? :new : :old
end
end
end \# Timed
end \# Acts
end \# Apohllo

W powyższym kodzie kilka rzeczy wymaga wyjaśnienie - zacznijmy od
najprostszych.

Moduł `Timed` znajduje się w przestrzeni nazw `Apohllo::Acts::` -
dzięki temu unikamy problemu konfliktu nazw, który jest szczególnie
niebezpieczny w kontekście wielokrotnego wykorzystania kodu.
Zdefiniowanie tego modułu w globalnej przestrzeni nazw mogłoby
spowodować nieprzewidziane skutki, jeśli użytkownik w swojej aplikacji
również definiowałby moduł `Timed`.

Druga kwestia dotyczy podziału reszty kodu na moduły:
wyraźnie oddzielone są **metody klasowe** (`ClassMethods` - dostępne we wszystkich
klasach dziedziczących z rozszerzanej klasy, w tym wypadku `ActiveRecord::Base`),
**metody instancyjne** (`InstanceMethods` - pojawią się jako *metody instancyjne*,
w klasach, w których zostanie aktywowane to rozszerzenie) oraz
**metody singletonowe** (`SingletonMethods` - pojawią się jako *metody klasowe*,
w klasach, w których zostanie aktywowane to rozszerzenie).

#### Metody - haki (hook)

Szczegóły działania mechanizmu są następujące.
Metoda **`self.included`** jest wywoływana w momencie, gdy dany moduł jest
dołączany do jakiejś klasy. W wyniku jej wykonania, klasa `ActiveRecord::Base`
zostanie wzbogacona o metody klasowe znajdujące się w module
`ClassMethods`. Dzieje się tak dzięki temu, że na parametrze `mod`
(który reprezentuje rozszerzany moduł lub klasę) wywołana jest metoda
**`extend`**. Jej działanie jest podobne do działania słowa kluczowego
`include`, z tą różnicą, że metody dołączanego modułu pojawiają się
jako metody klasowe a nie instancyjne. Pokazane jest to na poniższym
przykładzie:

code(ruby).
module A
def a
"a"
end
end
class B
include A
end
class C
extend A
end
b = B.new
b.a
\#=&gt; "a"
B.a
\# NameError...
c = C.new
c.a
\# NameError...
C.a
\#=&gt; "a"

Teoretycznie zatem zamiast stosować *hak* (hook) `included`,
można by w pliku `init.rb` napisać:

code(ruby).
class ActiveRecord::Base
extend Apohllo::Acts::Timed::ClassMethods
end

Efekt byłby taki sam. Zastosowano jednak wywołanie zwrotne, z
dwóch powodów: po pierwsze - dołączanie modułów za
pomocą dyrektywy `include` jest bardziej naturalne i
uniezależnia nas od tego, jakich metod dostarcza ów moduł;
po drugie zaś - w metodzie `included` można wykonać
pewien kod np. sprawdzający, czy w klasie do której
dołączany jest moduł, nie występują już metody o takich
samych nazwach jak metody modułu. Ma to szczególne znaczenie
w przypadku, gdy wykorzystywanych jest wiele pluginów i
istnieje niebezpieczeństwo zdublowania nazw. W tym wypadku
można po np. zgłosić błąd i przerwać wykonanie programu.

Przy okazji warto zwrócić uwagę, że istnieje wiele
podobnych metod - haków, np. **`inherited`** jest wywoływana
w chwili gdy jakaś klasa dziedziczy z danej klasy,
zaś **`method_defined`**, kiedy w danej klasie definiowana
jest nowa metody. Metody te mogę być również wykorzystywane
w zaawansowanych technikach metaprogramowania.

#### Metody instancyjne i klasowe

Wracając jednak do przedstawionego przykładu - w module
`ClassMethods` zdefiniowana jest tylko jedna metod `acts_as_timed`,
która służy właśnie do aktywowania tego rozszerzenia w wybranych
klasach. Jej wywołanie powoduje dołączenie (za pomocą dyrektyw
`include` oraz `extend`) odpowiednio metod instancyjnych i klasowych
do danej klasy. Ponadto definiowany jest atrybut klasowo-instancyjny
`old` a także metoda pozwalająca na jego odczytanie. Na jego podstawie
obiektom danej klasy będzie przypisywany odpowiedni status.

Definicje metod instancyjnych i klasowych nie są zbyt interesujące -
zawierają zwykły kod, który dokonuje porównania odpowiednich
wartości czy też przekazania wywołania do systemu mapowania
obiektowo-relacyjnego (metoda `find`). Atrybut `created_at`
zawiera datę utworzenia obiektu (jest ona utomatycznie
ustawiana przez framework), a porównanie jego wartości z aktualnym
czasem pozwala nam stwierdzić, czy dany obiekt jest nowy, czy stary.
Jest jednak jedna
subtelność, na którą należy zwrócić uwagę - w metodzie `new?`
pobierana jest wartość atrybutu klasowo-instancyjnego `old`
*klasy* danego obiektu. Ponieważ definiowane rozszerzenie
może być dołączane do różnych klas nie mamy innego sposobu
na dostanie się do tego atrybutu, niż przez jego klasę.
Wszystko działa świetnie pod warunkiem, że ograniczymy się
do obiektów tylko *tej* klasy. Jednakże jeśli będziemy tworzyć
obiekty klas z niej dziedziczących, to zdefiniowane metody
nie będą działać. Dlaczego?

Odpowiedź jest prosta, jeśli weźmiemy pod uwagę to gdzie przechowywana
jest wartość atrybutu `old` - w obiekcie *klasy*. Atrybut ten
nie jest jednak dostępny w klasach z niej dziedziczących - są
to po prostu inne instancje klasy `Class`! Jak zatem
rozwiązać ten problem? Otóż trzeba skorzystać z *haka*
`inherited` - kiedy nasza klasa jest rozszerzana, w nowotworzonej
klasie musimy ustawić odpowiednią wartość parametru `old`.
Co ciekawe - w frameworku Rails problem ten można łatwo rozwiązać
stosując makro `write_inheritable_attribute`.

Widzimy zatem, że ten z pozoru nieistotny szczegół, ma jednak dosyć
spore znaczenie. W istocie - metaprogramowanie wymaga nieraz wielkiej
subtelności i wyczulenia na szczegóły.

Poniżej przedstawiamy możliwość wykorzystania tak zdefiniowanego pluginu:

code(ruby).
class Newspaper &lt; ActiveRecord::Base
acts\_as\_timed :old =&gt; 1.month
end
class Car &lt; ActiveRecord::Base
acts\_as\_timed :old =&gt; 10.years
def to\_s
new? ? "Cudowny samochód" : "Wrak"
end
end
piatkowa\_wyborcza = Newspaper.new(:title =&gt; "Wyborcza")
wymarzony\_samochod = Car.new(:name =&gt; "Chrysler 300D", :price =&gt; 40\_000.euro)
piatkowa\_wyborcza.new?
\#=&gt; true
wymarzony\_samochod.new?
\#=&gt; true
\#po 40 dniach
piatkowa\_wyborcza.new?
\#=&gt; false
wymarzony\_samochod.new?
\#=&gt; true
\#po 10 latach
wymarzony\_samochod.new?
\#=&gt; false
wymarzony\_samochod.to\_s
\# "Wrak"

Na zakończenie warto wyjaśnić jeszcze jedną wątpliwość, która
mogła zrodzić się w kontekście przedstawionego przykładu - dlaczego
nie zostały w nim bezpośrednio wykorzystane techniki metaprogramowania
omówione wcześniej (w szczególności wywołanie `define_method`)?
Odpowiedzieć na to pytanie można na dwa sposoby: po pierwsze -
zostały wykorzystane *niektóre* z prezentowanych metod, np.
wykorzystanie klasy singletonowej do zdefiniowania dostępu do atrybutów danej
klasy. Po drugie zaś - wykorzystanie wszystkich technik nie było
konieczne. Nasz plugin dostarczał metod, których nazwy były z góry określone.
Dzięki temu można było je umieścić w osobnych modułach (`SingletonMethods`,
`InstanceMethods`) i dołączyć za pomocą wywołań `extend` oraz `include`.
Takie rozwiązanie na pewno jest czytelniejsze, co nie znaczy, że nie
mogliśmy skorzystać bezpośrednio z wywołania `define_method`.
Zawsze jednak powinno dążyć się do tego, żeby kod tworzony w ramach
metaprogramowania jak najbardziej przypominał zwykły kod - dzięki
temu zrozumienie tego co dzieje się "pod spodem" jest znacznie
łatwiejsze. W naszym mniemaniu dołączanie modułów zawierających
"zwykłe" definicje metod, jest czytelniejsze. Oczywiście
w pewnych przypadkach jest niewystarczające i wtedy nie można
uciec od stosowania metod `define_method`, czy `class_eval`.

Jeśli ktoś zaś zastanawia się gdzie powinien znaleźć się meta-kod,
to oczywiście najlepszym miejscem dla niego jest owa metoda klasowa,
która powoduje włącznie odpowiedniego rozszerzenia. Wszystko co
występuje poza nią powinno jak najbardziej przypominać definicje
zwykłych metod. Wtedy "magia" metaprogramowania jest skoncentrowana
w małym obszarze kodu, dzięki czemu programiści, którzy nie do
końca rozumieją tę technikę, mogą przynajmniej częściowo zrozumieć
to jak działa dostarczony plugin.

### Pluginy: Ruby/Rails a Java/Eclipse

W powyższym przykładzie staraliśmy się przedstawić możliwości jakie oferuje
język Ruby w zakresie tworzenia i wykorzystania pluginów. Widzimy, że
dynamiczne własności tego języka pozwalają w bardzo wygodny sposób
definiować a także wykorzystywać pluginy. Dzięki otwartości klas,
można modyfikować niemal dowolny fragment programu, zatem
pluginy mogą oferować niezwykle zróżnicowane funkcjonalności.
Co więcej - od twórcy platformy, na której będą działać
rozszerzenia, nie wymaga się, aby przewidział wszystkie sposoby
w jakie będą chcieli zmodyfikować ją jej użytkownicy.

#### Niebezpieczeństwa

Pytaniem pozostaje to, czy są jakieś ograniczenia dla wykorzystania
pluginów, jakie niebezpieczeństwa czyhają na ich użytkowników?

Pierwsze niebezpieczeństwo bierze się właśnie z \*nieograniczonych
możliwości modyfikacji\* - jeśli wykorzystamy dwa pluginy, które będą
modyfikowały ten sam fragment systemu, to może dojść do sytuacji,
gdy efekt ich działania stanie się zupełnie niezgodny z oczekiwaniami,
w najgorszym przypadku prowadząc do nieprzewidywalnych błędów,
które trudno się debuguje. Warto zwrócić uwagę, że meta-kod jest
trudniejszy do zrozumienia, zatem jego debugowanie jest tym trudniejsze.

Drugie niebezpieczeństwo bierze się z **niestabilności platformy**,
dla której tworzone są rozszerzenia. Jeśli nagle okaże się, że
jakieś istotne jej szczegóły uległy zmianie, część
działających rozszerzeń może okazać się zupełnie bezwartościowa.
Zatem pluginy jest sens tworzyć tylko wtedy, gdy wiemy, że podstawowy
projekt jest wystarczająco dojrzały i że czas poświęcony na ich
tworzenie faktycznie może się zwrócić.

#### Framework Eclipse

Jak te cechy języka Ruby wypadają na tle Javy i najbardziej popularnej
platformy wspierającej pluginy dla tego języka, czyli
frameworku Eclipse?

Aby odpowiedź na to pytanie nie była zbyt powierzchowna, powinniśmy
w wielkim skrócie przedstawić ów system pluginów.
Jest on zbudowany na bazie \*technologii [OSGi](http://www.osgi.org/*)
(która w Eclipse kryje się pod nazwą **Equinox**),
definiującej standardy dynamicznych modułów dla języka Java.
W wielkim skrócie można powiedzieć, że zawiera ona definicje mechanizmów
pozwalających na dynamiczne znajdowania, uruchamianie i zatrzymywanie,
a także określanie zależności pomiędzy
(najlepiej) reużtkowalnymi fragmentami kodu, zwanymi **modułami** (module),
**paczkami** (bundle), bądź **pluginami**.

Najważniejszym elementem definiowanym w ramach OSGi jest tzw. **manifest**,
czyli plik, w którym określane są komponentowe własności danego
"kawałka" kodu. Zawiera on m.in. listę importowanych i eksportowanych
pakietów, unikalny identyfikator komponentu, listę wymaganych komponentów, etc.
Wszystkie te informacje pozwalają w precyzyjny sposób określić
środowisko w jakim działa dany komponent. Jak można się domyślić, wszystkie
te własności mają szczególne znaczenie w rozwiązaniach klasy Enterprise,
gdzie często wymaga się, aby poszczególne fragmenty oprogramowania
można było traktować jako wymienne klocki, które funkcjonują
w ściśle określonym ekosystemie. Tym niemniej własności zdefiniowane
w manifeście niewiele mówią nam o tym, jakich funkcjonalności
może dostarczać określony plugin.

Znacznie ważniejszy, z naszego punktu wiedzenia, jest manifest **`plugin.xml`**,
który jest już specyficzny dla frameworku Eclipse. To co jest w nim
najważniejsze z naszego punktu widzenia, to tzw. **rozszerzenia**
(extensions) oraz **punkty rozszerzeń** (extension points).
Pierwsze z nich określają, że dany plugin dostarcza określonych
rozszerzeń dla platformy. Mogą to być elementy graficznego
interfejsu użytkownika (np. pozycje w menu głównym i kontekstowym,
widoki, edytory, itp.) a także inne elementy pozwalające rozszerzać
platformę Eclipse.

Rozszerzenia zawsze definiowane są w ramach punktów rozszerzeń - te drugie
określają jakie atrybuty powinno posiadać dane rozszerzenie, aby
mogło być wykorzystane w platformie. W przypadku pozycji w menu, będzie
to jej ścieżka, tytuł, a także kod (klasa), który zostanie wywołany w
momencie jej wybrania. Punkty rozszerzeń i rozszerzenia są komplementarne -
istnienie jednych nie ma sensu bez istnienia drugich. Punkt rozszerzeń jest
jakby miejscem, w którym możemy coś zmodyfikować. Rozszerzenie zaś jest
konkretną modyfikacją. Zazwyczaj stworzenie rozszerzenie wiąże się
z dodaniem pewnych elementów w GUI, które pozwalają na jego
wykorzystanie (okno dialogowe, wizard, pozycja w menu) oraz
zaimplementowanie pewnego interfejsu lub rozszerzenie klasy
w celu dostarczenia określonej funkcjonalności.

#### Porównanie

Już na pierwszy rzut oka widać, że rozwiązanie takie jest mało elastyczne.
Dostarczyciel pluginu może dostarczyć tylko takie rozszerzenie, jakie
zostało przewidziane przez twórcę systemu. Jeśli zaś modyfikacje
miałyby obejmować jakieś elementy, które zostały przeznaczone
do modyfikacji, jedyny sensowny sposób ich ulepszenia, polega na
napisaniu ich od nowa, co najwyżej z możliwością wykorzystania
mechanizmu dziedziczenia. Oczywiście w systemie, w którym zależności
pomiędzy poszczególnymi elementami są bardzo złożone (np. istnieje
łańcuch zależnych od siebie pluginów) próba modyfikacji
pierwszego pluginu w taki sposób, aby została ona rozpropagowana
do pluginów zależnych, może skończyć się fiaskiem, a w konsekwencji
uniemożliwić ponowne wykorzystanie kodu.

Z drugiej strony system tego rodzaju unika problemów które wskazaliśmy
w stosunku do frameworku Ruby on Rails - nie ma możliwości stworzenia rozszerzeń
pozostających w konflikcie (o ile tylko posiadają odmienne identyfikatory,
ale zapewnienie tego wymagania jest tak samo proste/trudne jak zapewnienie
globalnie unikalnej struktury pakietów, ponieważ do nazywania rozszerzeń
wykorzystuje się podobny mechanizm jak do nazywania pakietów).
Maleje również ryzyko sytuacji, w której twórca platformy dokonuje
zmian, które uniemożliwiają wykorzystanie już stworzonych pluginów.
Można się spodziewać, że skoro został zdefiniowany określony punkt
rozszerzeń, to ten fragment systemu pozostanie stabilny, przynajmniej
taka powinna być intencja jego twórcy.

Podsumowując te rozważania można skonstatować co następuje: język Ruby,
a także zbudowany na jego bazie framework Rails pozwala na bardzo
dużą elastyczność w ponownym wykorzystaniu kodu. Z drugiej
strony reużytkowalne elementy powinny być stosunkowo niewielkie, aby
ograniczyć ryzyko związane z ich dezaktualizacją w wyniku zmian
platformy, na której są wykorzystywane.

Z drugiej strony - Java i platforma Eclipse pozwalają tworzyć bardziej
stabilne i większe elementy, czego nieprzyjemną konsekwencją jest fakt,
że często będą one w całości nieprzydatne. Od twórców samej
platformy wymaga się zaś, aby bardzo starannie ją zaprojektowali, a
także przewidzieli wszystkie istotne kierunki, w których może być
ona rozszerzana. To zadanie jest jednak często bardzo trudne w
realizacji.

Ostatnia uwaga jaka mi się nasuwa dotyczy związku tych języków i technik
z dwoma przeciwstawnymi modelami tworzenia oprogramowania. Oczywiście
Ruby będzie po stronie technologii zwinnych, skoncentrowanych
na podążaniu z zmianami w wymaganiach. Java natomiast znacznie lepiej
sprawdza się w modelu klasycznym, gdzie etap implementacji poprzedzony
jest starannym projektowaniem aplikacji.

[Poprzedni rozdział](/dydaktyka/ruby/intro/zagadnienia-zaawansowane) |
[Następny rozdział](/dydaktyka/ruby/intro/co-dalej)
