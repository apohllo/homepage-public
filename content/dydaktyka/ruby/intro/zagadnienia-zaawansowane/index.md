---
title: Zagadnienia zaawansowane
date: '2008-01-15T05:09:00Z'
lastmod: '2008-02-20T11:43:01Z'
draft: false
tags:
- ruby
author: 83.175.191.74
toc: true
---

[Poprzedni rozdział](/dydaktyka/ruby/intro/klasy) |
[Następny rozdział](/dydaktyka/ruby/intro/metaprogramowanie)

W niniejszym rozdziale przedstawiamy zaawansowane techniki programowania w języku Ruby.
Należy podkreślić, że techniki te nie powinny być nadużywane - w szczególności jeśli
tylko możemy rozwiązać dany problem uciekając się do podstawowych metod wykorzystywanych
w językach obiektowych (np. dziedziczenia), to powinniśmy to zrobić właśnie w ten
sposób.

Opisane tutaj techniki są niezwykle potężne, ale używane nieroztropnie
mogą przyczynić się do tego, że kod programu będzie mniej zrozumiały (co nigdy nie
jest pożądane), a w najgorszych przypadkach doprowadzić do powstawania zupełnie
nieprzewidywalnych błędów (co może prowadzić do katastrofy). Dlatego jeszcze
raz zalecamy roztropne korzystanie z omówionych technik.

### Zamrażanie obiektów

Istnieje również mechanizm języka, który w pewnym stopniu pozwala ograniczyć negatywne
skutki niechcianych modyfikacji (zarówno klas i obiektów). Wywołanie na dowolnym
obiekcie metody **`freeze`** (zwane zamrożeniem) powoduje, że staje się on niemodyfikowalny. Wywołanie jakiejkolwiek metody powodującej zmianę stanu
zamrożonego obiektu, spowoduje wystąpienie wyjątku `TypeError`.
Dotyczy to również modyfikacji, które nie wyglądają jak wywołania metod (np. otwarcie
klasy i dodanie lub zmodyfikowanie metody). Istnieje również metoda **`frozen?`**, która
zwraca wartość `true`, jeśli dany obiekt jest zamrożony. Obiekt, który uległ zamrożeniu
nie może być przywrócony do zwykłego stanu w żaden sposób.

Negatywną konsekwencją stosowanie tego mechanizmu jest m.in. to, że nie można modyfikować
wartości zmiennych klasowych, jeśli dana klasa została zamrożona.

Introspekcja
------------

TODO

Dynamiczne wywoływanie metod
----------------------------

Jedną z własności języków skryptowych (nie tylko Ruby) jest możliwość wywoływania
metod, których **nazwa nie jest znana w trakcie pisania danego fragmentu kodu**.
W Ruby do tego celu służy właśnie metoda **`send`**, zdefiniowana w klasie `Object`.
Metoda ta jako pierwszy parametr przyjmuje nazwę metody do wywołania w postaci
łańcucha znaków lub symbolu. Pozostałe parametry przekazane zostaną do wywoływanej
metody:

code(ruby).
class Sesame
def open\_sesame!(password)
if password == "Abrakadabra"
"gold, silver and rock n' roll"
end
end
end
sesame = Sesame.new
sesame.send(:open\_sesame!, "Abrakadabra")
\#=&gt; "gold, silver and rock n' roll"

W powyższym przykładzie zilustrowane jest wykorzystanie metody `send`, do wywołania
metody `open_sesame!` z parametrem `password` równym "Abrakadabra". W tym wypadku nic
nie stało na przeszkodzie, aby na obiekcie `sesame` wywołać bezpośrednio metodę
`open_sesame!`.

Kiedy zatem uzasadnione jest stosowanie tej metody? Wyróżnić możemy kilka
rozsądnych przypadków:

-   kiedy **nazwa metody** jest konstruowana w trakcie wykonania programu
-   kiedy **metoda** jest konstruowana w trakcie wykonania programu

### Dynamiczne nazwy

Dobrą ilustracją pierwszego przypadku jest np. wykorzystanie informacji
pochodzących z introspekcja. Wyobraźmy sobie, że chcielibyśmy wywołać na danym
obiekcie wszystkie metody zaczynające się na wybraną literę, albo wszystkie
metody odczytu atrybutów, dla których zdefiniowane są również metody ich ustawienia.
Możemy wtedy wykorzystać następujący kod:

code(ruby).
class Dynamic
def for\_letter(letter, \*args)
self.class.methods.select{|m| m =~ /\\A\#{letter}/}.each{|m| send(m, \*args)}
end
def writeable\_attributes
self.class.methods.select{|m| m=~ /=\\Z/}.collect{|m| \[m,send(m.sub(/=\\Z/,""))\]}
end
end

W powyższym przykładzie w klasie `Dynamic` definiowane są dwie metody `for_letter` oraz
`writeable_attributes`. Pierwsza z nich pozwala wywołać wszystkie metody zaczynając
się na daną literę (lub ciąg liter) z argumentami przekazanymi do metody `for_letter`.
Zastosowanie takiej techniki byłoby trudne w zwykłych aplikacjach, ze względu na konieczność
dostosowania atrybutów do wszystkich potencjalnie wywoływanych metody.

Znacznie ciekawsza jest metoda `writeable_attributes`, która zwraca tablicę par: \[ \_nazwa
atrybutu, wartość\_ \] dla wszystkich atrybutów, dla których istnieją metody pozwalające
na ustawienie wartości atrybutu. Nie trudno wyobrazić sobie zastosowanie takiej
metody np. w aplikacji z graficznym interfejsem użytkownika, która pozwalałaby
modyfikować wartość dowolnego atrybutu, do którego dostęp zagwarantowany został w publicznym
interfejsie klasy danego obiektu. Przy drobnej modyfikacji obiekt ten nie musiałby
dziedziczyć z klasy `Dynamic` (wystarczyłoby, że wspomniana metoda przyjmowałaby go
jako swój argument). Widzimy zatem jak w bardzo prosty sposób można by w Ruby zaimplementować
niektóre z zaawansowanych mechanizmów zarządzania języka Java (JMX).

### Dynamiczne metody

Drugi przypadek dotyczy sytuacji, w której nie tylko nazwa metody
nie jest znana w trakcie tworzenia kodu, ale nawet sama metoda nie jest
zdefiniowana. Jak zostanie to przedstawione w następnym rozdziale,
metody w Ruby mogą być tworzone w trakcie wykonania programu
(Biorąc pod uwagę fakt, że podstawowa implementacja języka bazuje na interpreterze, nie
jest to nic zaskakującego. Z drugiej jednak strony powstaje coraz więcej
implementacji, w których kod Ruby jest kompilowany przed wykonaniem.),
zatem może zdarzyć się sytuacja, w której chcielibyśmy wywołać taką metodę.
W tym wypadku nie ma innej możliwości jak wywołanie jej poprzez nazwę.

Stosowny przykład realizujący ten schemat zostanie przedstawiony w rozdziale następnym.

Dynamiczne modyfikowanie klas
-----------------------------

W języku Ruby, w przeciwieństwie do takich języków jak C++ czy Java,
interfejs danej klasy nie musi być określony w jednym miejscu.
Pozwala to na określanie go w wielu niezależnych plikach.
Aby dodać nową metodę do wcześniej zdefiniowanej klasy wystarczy
*otworzyć* tę klasę i napisać definicję nowej metody. Mechanizm ten nie pozwala
na zmianę hierarchii dziedziczenia danej klasy, więc należy w definicji
wskazać właściwą klasę nadrzędną.

code(ruby).
class Base
end
class Inherited &lt; Base
def foo
"foo"
end
end
object = Inherited.new
object.foo
\# "foo"
object.bar
\# NoMethodError: undefined method \`bar' for...
class Inherited &lt; Base
def bar
"bar"
end
end
object.bar
\# "bar"

W powyższym przykładzie zdefiniowana jest klasa `Base` oraz klasa `Inherited`,
która dziedziczy z `Base`. Pierwotna definicja klasy `Inherited`
składa się tylko z jednej metody: `foo`. Wywołanie metody `bar`, która
nie została zdefiniowana za pierwszym razem, skutkuje wystąpieniem
wyjątku `NoMethodError`. Nic nie stoi jednak na przeszkodzie aby
rozszerzyć interfejs definiowany przez klasę `Inherited` i dodać
metodą `bar`. Wtedy wywołanie tej metody na obiektach tej
klasy nie spowoduje błędu. Być może zastanawiające jest to, że ta
nowa funkcjonalność będzie występować również w obiektach, które
zostały stworzone *przed* jej dodaniem. Jeśli jednak przypomnimy
sobie poprzedni rozdział, gdzie wyraźnie było napisane, że
obiekty posiadają stan, a metody związane są z klasami, to
zachowanie to nie powinno wymagać dalszego wyjaśnienia.

Na pierwszy rzut oka technika ta wydaje się przydatna jedynie wtedy, gdy definicja
naszej klasy rozrasta się nadmiernie i chcemy umieścić ją w kilku
plikach. Oczywiście nic nie stoi na przeszkodzie aby właśnie
wtedy ją stosować. Tym niemniej gdyby chodziło tylko o to zastosowanie,
nie opisywalibyśmy go w tym rozdziale.

Po pierwsze należy wskazać, że \*można ponownie definiować metody
już wcześniej zdefiniowane\*, a ponadto \*można redefiniować klasy
wbudowane!\*

Pierwsze właściwość sama w sobie wydaje się zbędna. Po co mielibyśmy
redefiniować metody, które sami zdefiniowaliśmy? Lepiej w tym wypadku
byłoby od razu poprawić pierwotną definicję, a nie tworzyć kod, który
staje się trudny w utrzymaniu. Ponadto zachowanie programu
zależy od tego, która z definicji zostanie zinterpretowana jako ostania,
gdyż to ona będzie wykorzystana w następnych wywołaniach,
zatem będzie ono zależało od kolejności wczytania plików.

Dopiero w połączeniu z drugą własnością, czyli możliwością redefiniowana
klas wbudowanych nabiera ona praktycznego znaczenia. Oczywiście
osoby, które pierwszy raz spotykają się z takimi olbrzymi możliwościami
modyfikacji *języka*, mogą obawiać się, że te własności są potencjalnie
bardzo destrukcyjne. Należy przyznać, że owszem - nierozsądne ich stosowanie
może prowadzić do bardzo dziwnych i nieprzewidywalnych błędów.
Jak jednak pisaliśmy na początku tego rozdziału, wszystkie opisane
tutaj techniki programistyczne powinny być stosowane wyłącznie w
dobrze uzasadnionych przypadkach i tylko przez doświadczonych programistów.
Co więcej - jeśli przyjmiemy zasadę, że nie modyfikujemy zachowania metod
w klasach wbudowanych, a jedynie rozszerzamy ich funkcjonalność, to
ryzyko wystąpienia dziwnych błędów znacznie się zmniejsza.

Przykładem takiego bezpiecznego rozszerzenia mogłoby być dodanie
do klasy String nowej metody `hl`, która dodawałaby do łańcucha
znaków sekwencje modyfikujące sposób wyświetlania łańcucha, czy
to w postaci tagów HTML czy też znaków sterujących w terminalach
uniksowych:

code(ruby).
class String
def hl(tag="em",hlstr=nil)
if hlstr
self.gsub(/\#{hlstr}/,"&lt;\#{tag}&gt;\#{hlstr}&lt;/\#{tag}&gt;")
else
"&lt;\#{tag}&gt;\#{self}&lt;/\#{tag}&gt;"
end
end
end
"Ala ma kota".hl("b","ma").hl("p")
\#=&gt; "

<p>
Ala <b>ma</b> kota

</p>
"

W powyższym przykładzie do klasy `String` dodawana jest metoda `hl`,
która pozwala w prosty sposób formatować łańcuchy znaków za pomocą
tagów HTML. W przypadku, gdy nie jest przekazany żaden argument do
tej metody, cały łańcuch formatowany jest za pomocą tagu `em`.
Jeśli podany jest pierwszy parametr, to jest on traktowany jako
nazwa znacznika, za pomocą którego formatowany jest łańcuch.
Drugi parametr wykorzystywany jest jako podłańcuch, do którego
ma być zawężone formatowanie.

Dlaczego funkcjonalność ta została dodana w klasie `String` a nie
jakiejś klasie, która by z niej dziedziczyła? Oczywiście w językach,
w których nie można modyfikować klas wbudowanych byłoby to jedyne
sensowne rozwiązanie. Tym niemniej w Ruby można w tym celu właśnie
rozszerzyć klasę `String` - widzimy, że wprowadzona modyfikacja skutkuje
tym, że wywołania `hl` mogą być łączone, bez potrzeby opakowywanie
ich wyniku w jakąś dodatkową klasę. Rozwiązanie takie jest przejrzyste,
a ponadto raczej nie powinno prowadzić do "dziwnych błędów", gdyż
wyłącznie rozszerzyliśmy, a nie zmodyfikowaliśmy interfejs oraz
zachowanie tej klasy.

W dalszej części rozdziały (przy okazji omówienia techniki *aliasowania*)
przedstawiony zostanie jeszcze bardziej zaawansowany przykład
modyfikowania klas wbudowanych, który jednak jest już dużo bardziej ryzykowny,
gdyż skutkuje zmianą ich zachowania. Nadal jednak technika ta może być
wykorzystywana w aplikacjach prototypowych, gdzie ilość kodu jest
niewielka, a pożytki przeważają nad zagrożeniami.

Brakujące metody i stałe
------------------------

Bardzo interesującą techniką zaawansowanego programowania jest redefiniowanie
metod **`method_missing`** oraz **`const_missing`**. Pierwsza z nich wywoływana
jest jeśli żadna z klas i modułów stowarzyszonych z danym obiektem
**nie implementuje metody o danej nazwie**. Metoda `const_missing`
wywoływana jest zaś wtedy, gdy w kodzie pojawia się odwołanie do \*stałej,
która nie została zdefiniowana\*.

### `method_missing`

Scenariusz wykorzystania metody `method_missing` jest dokładnie odwrotny
do wykorzystania metody `send` (co nie znaczy, że nie mogą być one
wykorzystywane razem). W przypadku tej pierwszej, w trakcie pisania
programu znana jest nazwa wywoływanej metody, ale metoda ta nie jest
w ogóle definiowana! Jak zatem można wykorzystać metodę, która nie posiada
definicji? Otóż metoda taka nie posiada definicji w zwykłym tego słowa
znaczeniu, tzn. składającej się ze słowa `def`, nazwy metody, jej listy
parametrów oraz ciała.
W metodzie `method_missing` (zazwyczaj) definiowane jest tylko ciało tej metody.

W sygnaturze metody `method_missing` pojawiają się dwa argumenty - pierwszy
to nazwa metody, której definicja nie została znaleziona, natomiast
drugi przechwytuje wszystkie parametry przekazane do nieistniejącej
metody. Na podstawie tych informacji możliwe jest zasymulowanie zachowania,
którego można by się spodziewać po brakującej metodzie.

W najprostszym przypadku można po prostu wypisać komunikat informujący, że
dana metoda nie istnieje (w domyślnej implementacji rzucany jest wyjątek
NameError):

code(ruby).
class Empty
def method\_missing(name, \*arg)
"Brak metody '\#{name}', do której przekazano argumenty \[\#{arg.join(", ")}\]"
end
end
ala = Empty.new
ala.ma\_kota?("Mamrota")
\#=&gt; "Brak metody 'ma\_kota?', do której przekazano argumenty \[Mamrota\]"

W powyższym przykładzie metoda `method_missing` powoduje zwrócenie komunikatu
mówiącego, że dana metoda nie istnieje.

Oczywiście takie zastosowanie, choć interesujące, jest jednak mało przydatne
(z jednym wyjątkiem - przyjaznych interaktywnych interpreterów, które zamiast generować wyjątki, informują użytkownika, że gdzieś popełnił błąd).

Znacznie ciekawsze zastosowanie tej techniki można znaleźć w różnych
bibliotekach, które pozwalają na bardziej obiektową interakcję z obiektami,
które z założenia nie są obiektowe (np. relacyjne bazy danych)
czy też posiadają rozbudowany interfejs, którego przepisywanie na
modłę obiektową byłoby czasochłonne (np. tagi języka HTML).

Oba przytoczone rozwiązania wykorzystywane są w praktyce. Pierwsze
stosowane jest w bibliotece ActiveRecord i pozwala np. definiować
kryteria wyszukiwania obiektów w bazie danych w "bardziej obiektowy"
sposób. Zamiast przekazywać je jako tablicę asocjacyjną postaci
*nazwa atrybutu* =&gt; *kryterium*, można wywołać metodę, w której
nazwie pojawią się nazwy atrybutów, a kryteria są przekazywane
jako jej parametry:

code(ruby).
\# zwykły kod
apples = Apple.find(:all, :conditions =&gt; {:color =&gt; "red"})
\# bardziej obiektowy kod
apples = Apple.find\_all\_by\_color("red")

Należy zwrócić uwagę, że metoda `find_all_by_color` nie jest zdefiniowana
w klasie `Apple`. Odpowiednie wywołanie do bazy danych realizowane
jest na podstawie *nazwy* metody - jest ona *de facto* przkształcana
w wywołanie zbliżone do pierwszego. Nie trzeba chyba nikogo przekonywać,
że drugi zapis jest znacznie czytelniejszy.

Drugie rozwiązanie stosowane jest natomiast w bibliotece szablonów
stron internetowych `.haml` Jedną z ciekawych jej własności jest to, że
klasa (HTML-owy atrybut `class`) danego elementu może pojawić się
po nazwie tagu:

code(ruby).
div.left.highlight
p.first
To jest pierwszy akapit
p.normal
To jest drugi akapit

W powyższym przykładzie definiowana jest sekcja (`div`), która
będzie posiadała atrybut `class` o wartościach `left` oraz `highlight`.
Wewnątrz tej sekcji pojawiają się zaś dwa paragrafy, spośród których pierwszy
posiada klasę `first`, zaś drugi `normal`. Zapis stosowane w .haml-u jest
bardzo czytelny, a implementacja tego mini-języka opiera się m.in.
właśnie o metodę `method_missing` zdefiniowaną dla znaczników HTML.

Na pierwszy rzut oka technika ta może wydawać się mało przydatna, ale
po bliższym jej poznaniu, a także po zapoznaniu się z niektórymi
bibliotekami napisanymi w Ruby, okazuje się, że pozwala ona niesamowicie
poprawić czytelność kodu. Jest to jeden z powodów, dla których Ruby
często wykorzystywany jest do tworzenia tzw. DSL (Domain Specific Language)-i,
czyli języków specyficznych dla danej dziedziny zastosowań.

### `const_missing`

Metoda **`const_missing`**, choć wykorzystywana znacznie rzadziej,
również może mieć ciekawe zastosowania. Jedno z najbardziej oczywistych
polega na redefinicji tej metody w klasie `Module` (gdzie jest ona
zdefiniowana pierwotnie) w celu ładowania plików zawierających definicje
klas, które nie zostały *explicite* załadowane. Jeśli tylko wiadomo jaka
jest ścieżka dostępu do tych plików oraz stosowana jest np. konwencja,
w myśl której klasa o nazwie `NazwaKlasy` zdefiniowana jest w pliku
`nazwa_klasy.rb`, to można bardzo łatwo zaimplementować mechanizm
auto-ładowania potrzebnych plików.

Aliasy metod
------------

Polecenie **`alias`** jest niewątpliwie znane wszystkim użytkownikom
systemów uniksopodobnych - pozwala ono na wprowadzanie innych
nazw dla już zdefiniowanych poleceń. Podobne jest działanie
słowa kluczowego `alias` w języku Ruby - dzięki niemu można nadać
nową nazwę metodzie, która została zdefiniowana wcześniej.

Aby utworzyć alias jakiejś metody, należy w definicji klasy
wprowadzić słowo kluczowe `alias`, po nim nazwę (w postaci symbolu)
tworzonego aliasu, dalej nazwę (również w postaci symbolu) już
zdefiniowanej metody, dla której tworzona jest nazwa alternatywna.

code(ruby).
class String
alias :dlugosc :length
end
"abc".dlugosc
\#=&gt; 3

W powyższym przykładzie w klasie `String` tworzony jest alias `dlugosc` dla
metody `length`. Wywołanie metody `dlugosc` na dowolnym obiekcie tej
klasy jest tożsame z wywołanie metody `length`.

Przedstawione zastosowanie mechanizmu aliasowania, polegające na
rozszerzeniu interfejsu klasy o metody, które dla niektórych
programistów będą bardziej oczywiste (np. `size` vs. `length`),
choć interesujące, nie jest aż tak przydatne, jak mogłoby to się wydawać
na pierwszy rzut oka. Przez niektórych programistów (np. zakorzenionych
w pythonowej filozofii, w myśl której "powinien istnieć tylko jeden
oczywisty sposób na zrobienie tego") ta właściwość języka Ruby może
wydawać się nawet zdecydowanie niepożądana, gdyż powoduje zaśmiecenie
interfejsu metodami, których działanie jest identyczne.

Po części zgadzamy się z tą krytyką, tym bardziej, że stworzenie aliasu
dla danej metody nie powoduje, że nazwy te są całkowicie utożsamione -
zdefiniowanie metody o nazwie takiej jak alias innej metody powoduje, że
powstają dwie zupełne odrębne metody:

code(ruby).
class String
alias :dlugosc :length
end
"abc".dlugosc
\#=&gt; 3
"abc".length
\#=&gt; 3
class String
def dlugosc
"długość jest nieznana"
end
end
"abc".dlugosc
\#=&gt; "długość jest nieznana"
"abc".length
\#=&gt; 3

W powyższym przykładzie widać dokładnie, że pomimo wcześniejszego zaliasowania
metody `length` za pomocą nazwy `dlugosc`, zdefiniowanie tej drugiej metody
powoduje, że każda z metod daj inny wynik.

Czy zatem istnieje racjonalne uzasadnienie dla istnienia techniki
aliasowania metod? Otóż tak! Aliasy przydają się jeśli modyfikujemy
działanie jakiejś metody, a jednocześnie chcielibyśmy móc odwołać się
do jej wcześniejszej implementacji. Programiści wychowani
w starej szkole dobrego OOP realizowaliby przedstawiony scenariusz
poprzez stworzenie klasy dziedziczącej z danej klasy, w której
pojawiłaby się nowa, rozszerzona implementacja starej metody, a
stara metoda byłaby wywołana z wykorzystaniem słowa kluczowego `super`.
Tym niemniej wszyscy Ci, którzy zetknęli się z programowaniem zorientowanym
*aspektowo*, wiedzą, że ten mechanizm nie zawsze się sprawdza. Jeśli np.
chcielibyśmy dziedziczyć z oryginalnej klasy, to oczywiści nie
mamy dostępu do modyfikacji, która pojawia się w nowej klasie:

code(ruby).
class Base
def foo
"foo"
end
end
class Inherited1 &lt; Base
def foo
"you said " + foo
end
end
class Inherited2 &lt; Base
end
in1 = Inherited1.new
in1.foo
\#=&gt; "you said foo"
in2 = Inherited2.new
in2.foo
\#=&gt; "foo"

W powyższym przykładzie zilustrowany jest problem, o którym mowa. Jeśli
chcemy nasze rozszerzenie wprowadzić w metodzie `foo`,
aby zostało ono wykorzystane, wszystkie klasy dziedziczące z `Base` musiałyby
teraz dziedziczyć z `Inherited1`. Nie zawsze jest to jednak możliwe.
M.in. stąd wziął się pomysł na programowanie aspektowe, dzięki któremu
można modyfikować zachowanie pewnych metod na dowolnym poziomie hierarchii
dziedziczenia, w taki sposób, aby zmiany te były propagowane
na wszystkie klasy poniżej tego poziomu.

Wykorzystując mechanizm aliasowania języka Ruby, przedstawiony problem
możemy rozwiązać w sposób następujący:

code(ruby).
class Base
def foo
"foo"
end
end
class Inherited &lt; Base
end
in = Inherited.new
in.foo
\#=&gt; "foo"
class Base
alias :old\_foo :foo
def foo
"you said " + old\_foo
end
end
in.foo
\#=&gt; "you said foo"

Oczywiście sceptycy mogą zapytać - dlaczego nie zmodyfikowano oryginalnej
metody `foo`? Najprostsza odpowiedź brzmi - ponieważ nie było takiej
możliwości. Kod klasy `Base` może pochodzić z zewnątrz i ulegać zmianie,
zatem modyfikacja tej metody mogłaby zostać usunięta przy aktualizacji
danej biblioteki (biblioteki napisane w czystym Ruby zawierają zawsze
jego kod źródłowy, zetem taka modyfikacja jest zazwyczaj możliwa,
lecz z oczywistych względów, niezalecana).

Niemożność modyfikacji oryginalnego kodu ma jeszcze większe znaczenie
w odniesieniu do klas wbudowanych języka. O ile moglibyśmy zmodyfikować ich
kod na własnej maszynie (co IMHO zakrawałoby na dziwactwo, żeby nie powiedzieć
szaleństwo),
o tyle nie mamy takiej możliwości, jeśli uruchamiamy
nasz kod na maszynie, nad którą nie mamy pełnej kontroli. Jednakże
dzięki mechanizmowi pozwalającemu na rozszerzanie klas wbudowanych,
możemy dokonywać modyfikacji tych klas w sposób bardziej cywilizowany.

Pozostaje pytanie - kiedy taka technika faktycznie powinna być stosowana.
Jak wspominaliśmy wielokrotnie w niniejszym rozdziale - wszystkich prezentowanych
tutaj metod programowania należy używać z rozwagą. Możemy jednak
wskazać dwa scenariusze, kiedy zastosowanie tej techniki wydaje się
dobrze uzasadnione:

-   **przypadki znane z AOP** - dodawanie logowania, transakcji, etc.
-   **prototypowanie** - badanie przypadków granicznych, stosowanie klas wbudowanych
    jako prototypów

### Zastosowanie: AOP

Pierwszy przypadek najlepiej zilustrować jako rozwinięcie ostatniego
przykładu. Załóżmy, że mamy klasę `Account`, która posiada metodę
`transfer(amount, to)`, pozwalającą na przekazanie pewnej kwoty
pieniędzy na inne konto. W trakcie rozwoju aplikacji okazało się,
że wszystkie wywołania tej metody muszą być logowane, na potrzeby audytu.
Niestety wspomniana klasa nie jest naszym własnym produktem i wiadomo,
że może ulec dalszym zmianom. Rozwiązaniem problemu jest stworzenie
rozszerzenia tej klasy:

code(ruby).
\# oryginalny kod, którego nie możemy zmodyfikować
class Account
attr\_accessor :balance
def transfer(amount, to)
Transaction.start do
self.balance -= amount
to.balance += amount
end
end
end
\# nasze rozszerzenie klasy Account
class Account
alias :old\_transfer :transfer
def transfer(amount, to)
`logger.log("From balance: #{self.balance}, to balance: #{to.balance}")
    old_transfer(amount, to)
    `logger.log("From balance: \#{self.balance}, to balance: \#{to.balance}")
end
end

W powyższym przykładzie dodanie logowania sprowadza się do
dodania aliasu dla metody `transfer` oraz otoczenia oryginalnego
wywołania odpowiednimi wywołaniami do loggera. Oczywiści przedstawiony
jest jedynie szkic rozwiązania (koniczne byłoby wcześniejsze ustawienie
wartości zmiennej instancyjnej `@logger`, etc.).

Widzimy zatem jak w łatwy sposób można dodać niektóre z mechanizmów
AOP do naszych programów napisanych w Ruby.

### Zastosowanie: prototypowanie

Drugi przypadek choć rzadziej stosowany, może być równie cenny, w
szczególności w początkowej fazie rozwoju nowego projektu.
Zwykle wtedy zależy nam bardziej na określeniu trudności implementacji
i wstępnej weryfikacji nowego pomysłu, aniżeli na stworzeniu
całkowicie stabilnego i wydajnego rozwiązania.
Możliwość zmodyfikowania wbudowanych klas jest wtedy nieoceniona - zamiast
tworzyć własne klasy, które swoją funkcjonalnością byłyby zbliżone
do klas wbudowanych, możemy po prostu nieco "przerobić" te klasy
na własne potrzeby.

Jednym z ciekawych sposobów wykorzystania tej techniki właśnie w fazie
prototypowania, miałem do czynienia w projekcie z zakresu NLP (Natural Language Processing).
Jak powszechnie wiadomo, przy przetwarzaniu języka naturalnego, takiego
jak język polski, bardzo istotne są operacje na łańcuchach znaków.
Z drugiej strony - ze względu na fleksję występującą w naszym języku,
zastosowanie surowej klasy `String` jest niemożliwe. W szczególności
dwa słowa mogą być identyczne, nawet jeśli ich formy w postaci łańcucha
znaków różnią się ("kot", "kota", "kotu", "koty"... to formy jednego leksemu).

Poprawne rozwiązanie tego problemu powinno oczywiście sprowadzać się
do napisania nowej klasy, np. `Lexeme`, która odpowiadałaby
temu uogólnionemu pojęciu napisu i zawierałaby informacje o jego odmianie.
Takie rozwiązanie właśnie zastosowałem. Jednak szybko okazało się,
że w bibliotece zawierającej odmienione formy słów, nie występują
wszystkie słowa pojawiające się w analizowanych tekstach.
Pierwsza myśl polegała na tym, aby dla tych słów również tworzyć
odpowiednie instancje klasy `Lexeme`. Niestety takie rozwiązanie
wymagałoby dużych modyfikacji tej klasy - w zasadzie każda metoda
powinna zostać przerobiona w taki sposób, aby uwzględniała sytuację,
w której dane słowo występuje lub nie występuje w wspomnianej bibliotece.
Co więcej - okazało się, że jedyna metoda, która będzie wykorzystywana
dla tych "fałszywych" leksemów to metoda porównująca `==(other)`.

Znacznie prostsze wydało się przerobienie oryginalnej metody porównującej
klasy `String`, tak by ona akceptowała również obiekty klasy `Lexeme`!
To rozwiązanie zastosowałem właśnie w swoim prototypowym projekcie:

code(ruby).
class Lexeme
\# metoda sprawdzająca czy leksem występuje w danej formie
def has\_form?(form)
\#implementacja
end
def (other)
    return self.lexeme\_id  other.lexeme\_id if other.is\_a?(Lexeme)
return self.has\_form?(other) if other.is\_a?(String)
false
end
end
\# modyfikacja klasy String, aby  było relacją symetryczną 
class String
  alias :old\_equals :
def (other)
    return other  self if other.is\_a?(Lexeme)
old\_equals(other)
end
end

Dzięki takiemu rozwiązaniu mogę np. przechowywać obiekty klas
`Lexeme` oraz `String` w jednej tablicy i porównywać je miedzy
sobą, nie przejmując się czy są to instancje należące do tych
samych czy też różnych klas. Nie muszę chyba podkreślać jak
bardzo ułatwia to tworzenie prototypu!

Klasy i metody typu `singleton`
-------------------------------

W poprzednim rozdziale przedstawione zostały podstawowe zagadnienia
związane z obiektowością: relacje pomiędzy klasami i obiektami,
dostępem do atrybutów, widocznością metod, etc. Chociaż nie wspomniano nic
o znanych z Javy *interfejsach* i *klasach abstrakcyjnych* (które
w Ruby nie występują), to przedstawiony obraz mógł wydawać się pełny.

Okazuje się jednak, że zagadnienie obiektowości w Ruby jest nieco
bardziej złożone. Co więcej - aby faktycznie zrozumieć jak działają
podstawowe składniki tego język, czyli klasy, nie sposób nie poruszyć
zagadnienia tzw. **klas i metod typu `singleton`**.

Ponieważ zagadnienie to jest dosyć złożone, a jego zrozumienie
jest kluczowe dla wykorzystania pełnego potencjału języka, poświęcimy
mu trochę więcej miejsca.

### Metody typu `singleton`

Zacznijmy od kwestii najprostszej - **metod singletownowych**.
Tym mianem określa się metody, które \*definiowane są dla pojedynczych
obiektów\*. Tak! Okazuje się, że w Ruby można dodać metodę do pojedynczego
obiektu. Można to zrobić na trzy sposoby:

code(ruby).
my\_string = "trzy"
class &lt;&lt; my\_string
def to\_i
3
end
end
my\_string.to\_i
\#=&gt; 3
"trzy".to\_i
\#=&gt; 0

Pierwszy sposób polega na wykorzystaniu słowa kluczowego `class`,
po którym pojawia się operator `<<`, a po nim zmienna, która
odnosi się do obiektu, do którego dodawana jest metoda typu `singleton`.

Drugi sposób polega na użyciu nazwy zmiennej przed nazwą dodawanej
metody:

code(ruby).
my\_string = "trzy"
def my\_string.to\_i
3
end
my\_string.to\_i
\#=&gt; 3

Trzeci sposób polega na wykorzystaniu metody `instance_eval`:

code(ruby).
my\_string = "trzy"
my\_string.instance\_eval do
def to\_i
3
end
end
my\_string.to\_i
\#=&gt; 3

Metoda `instance_eval` akceptuje zarówno blok kodu jak i łańcuch znaków.

Efekt działania powyższych konstrukcji jest taki sam - metoda (lub metody)
zdefiniowane jako metody typu singleton, dołączane są tylko do wybranego
obiektu. Nie wpływają one na żaden inny obiekt danej klasy. Dlatego też
w powyższych przykładach tylko łańcuch "trzy" ukrywający się pod zmienną
`my_string` przy zamianie na wartość całkowitą, dawał wartość 3. Pozostałe
łańcuchy, chociaż nawet wyglądały identycznie, przy wywołaniu tej metody
zachowywały się w sposób zdefiniowany w klasie `String`, tzn. jeśli nie
reprezentowały wartości całkowitej, przy wywołaniu metody `to_i` zwracały
wartość 0.

Mechanizm ten może rodzić wiele pytań. Oto niektóre z nich:

-   czy są jakieś ograniczenia jego stosowania?
-   do czego może się przydać?
-   jak jego działanie ma się do tezy, że obiekty posiadają tylko stan, a metody mogą być związane tylko z klasami?

### Ograniczenia

Pierwsze poważne ograniczenie jego stosowania \*dotyczy klas `Fixnum`
oraz `Symbol`\* - obiekty tych klasy nie mogą posiadać metod typu singleton.

Drugie ograniczenie dotyczy **serializowania** (za pomocą metody `to_yaml`) -
obiekt posiadający metody tego rodzaju po serializacji i deserializacji
zostanie ich pozbawiony.

### Zastosowania

Odpowiedź na drugie pytanie mogłaby być bardzo długa, dlatego przytaczamy
zaledwie kilka przykładów zastosowania tej techniki. W dalszej części
rozdziału postaramy się omówić niektóre z nich nieco szerzej.

-   **Tworzenie testów akceptacyjnych** w języku zbliżonym do języka naturalnego -
    dzięki możliwości dodawania metod do pojedynczych obiektów, mamy pełną swobodę
    w ich nazywaniu. Nie muszą być to nazwy, które mają sens w kontekście
    klasy, a jedynie wybranego obiektu. Możemy np. w naszym teście do obiektu
    `michał` dodać metodę `kup_pocztowki` i wywoływać ją wielokrotnie w
    różnych kontekstach. Znacząco poprawi to czytelność takiego testu.
-   **Zmiana zachowania pojedynczych obiektów** - najlepiej technika ta sprawdza
    się w sytuacji, w której mamy jeden specyficzny obiekt, który powinien być
    traktowany inaczej np. dla metody `to_yaml`. Aby zmodyfikować działanie
    tej metody dla tego obiektu, musielibyśmy stworzyć dla niego osobną klasę.
    W Ruby możemy skorzystać właśnie z metod typu singleton.
-   **Prototypowanie** - technika ta przydaje się również w tym przypadku i można
    podejrzewać, że jest nawet bezpieczniejsza, niż wspomniana wcześniej
    technika polegająca na modyfikacji klas wbudowanych. W odniesieniu
    do wcześniejszego przykładu z klasami `Lexeme` i `String`: zamiast modyfikować
    metodę `==` w całej klasie `String`, moglibyśmy ją zmodyfikować tylko
    dla tych obiektów, które trafiają do tablicy przechowującej leksemy
    i łańcuchy znaków.
-   Metody singleton mają też istotne znaczenie w kontekście **metaprogramowania**.

### Klasy typu `singleton`

Zanim jednak wyjaśnimy na czym polega rola metod singletonowych w metaprogramowaniu,
musimy odpowiedzieć na pytanie trzecie: jak można utrzymać tezę o
niezależności obiektów od metod, jeśli można związać metodę z
pojedynczym obiektem?

Odpowiedź jest w zasadzie oczywista - metody typu singleton nie są
związane z obiektami, a ze specjalnymi **klasami singletonowymi**.
Wspomnieliśmy już wielokrotnie, że tylko klasy mogą "posiadać"
metody, a zwykłe obiekty mogą mieć tylko stan przechowywany
w atrybutach. Zatem realizacja mechanizmu metod singletonowych
opiera się o to, że w momencie dodanie do obiektu takiej
metody *tworzona jest nowa klasa*, która związana jest tylko
z tym obiektem. Klasa ta pojawia się najniżej w hierarchii klas
tego obiektu - zatem wszystkie zdefiniowane w niej metody mają
pierwszeństwo wobec metod zdefiniowanych w pozostałych klasach
należących do hierarchii, w szczególności klasy, która jest "oficjalną"
klasą danego obiektu.

Klasy singletonowe nazywane są czasami **metaklasami** lub **klasami wirtualnymi**.
Obie nazwy nie oddają jednak za bardzo ich specyfiki. Przedrostek *meta*
jest zazwyczaj zarezerwowany dla pojęć, które służą do opisu innych
pojęć, w tym wypadku byłyby to klasy stosowane do opisu klas. Oczywiście
w Ruby istnieje taka klasa i nazywa się... `Class`.

Pojęcie *klasy wirtualne* kojarzy się natomiast z wywołaniami wirtualnymi,
a w Ruby wszystkie wywołania metod są wirtualne (w sensie terminologii
stosowanej w języku C++), zatem ten kwalifikator też nie wydaje się
najwłaściwszy.

Skoro uporaliśmy się z kwestiami terminologicznymi, możemy
przystąpić do odkrywania ostatnich tajemnic języka Ruby. Możemy
zadać pytanie: *czy klasy również posiadają swoje klasy singletonowe?*
Odpowiedź jest dosyć oczywista i brzmi: *tak*. Ponieważ klasy są obiektami,
to jako obiekty, również mogą posiadać metody typu singleton.

Zaraz, zaraz, skoro tak, to \*definicje metod klasowych są tożsame z
definicjami metod typu singleton!\* Dokładnie tak - można powiedzieć,
że definicje metod klasowych *są* definicjami metod singletonowych
dla obiektów poszczególnych klas. Powtórzmy to jeszcze raz: metody
klasowe typu `Figure.instances`, są zdefiniowane w \_klasie singletonowej
obiektu kryjącego się pod stałą `Figure`.\_ Żeby zobaczyć to naocznie
możemy przywołać definicję z poprzedniego rozdziału:

code(ruby).
class Figure
`@instances = 0
  def Figure.instances
    `@instances
end
end

Przy omówieniu metod klasowych wspomnieliśmy, że występują trzy ich
postaci, ale trzecia zostanie omówiona później. Teraz jest to już oczywiste:

code(ruby).
class Figure
`@instances
  class << self
    def instances
      `@instances
end
end
end

W powyższym kodzie metoda `instances` definiowana jest jako singletonowa
metoda obiektu, kryjącego się pod słowem kluczowym `self`, czyli obiektu
będącego klasą `Figure`.

Na pierwszy rzut oka całe to zamieszanie z klasami i metodami typu singleton
wydaje się tylko zbędną komplikacją, która obciąża umysł programisty.
W tym oglądzie jest trochę racji, dlatego też w poprzednim rozdziale
pominęliśmy te skomplikowane zagadnienia. Tym niemniej zobligowani jesteśmy
do wyjaśnienia, jaki zysk może być z takiej komplikacji? Otóż klasy
i metody typu singleton odgrywają zasadniczą rolę w metaprogramowaniu,
czyli programowaniu, którego przedmiotem są nie obiekty (czyli instancje
klas), ale same klasy (czyli instancje klasy `Class`). Zagadnienie
to omówione jest szerzej [w następnym rozdziale](/dydaktyka/ruby/intro/metaprogramowanie).

[Poprzedni rozdział](/dydaktyka/ruby/intro/klasy) |
[Następny rozdział](/dydaktyka/ruby/intro/metaprogramowanie)
