---
title: Pascal
date: '2007-10-17T18:21:00Z'
lastmod: '2009-11-04T08:47:58Z'
draft: false
tags:
- dydaktyka
- wdi
- pascal
- programowanie
author: 149.156.173.53
toc: true
---

Typy danych
-----------

### Podstawowe typy danych

Każda zmienna używana w języku programowania Pascal musi mieć określony typ,
który określa **zbiór wartości**, jakie może ona przyjmować oraz wyznacza
**operacje**, jakie mogą być wykonywane na wartościach przypisanych do zmiennej.

Przykładowo - typ **integer** to typ reprezentujący liczby całkowite (właściwie - pewien
ich zakres). Operacje jakie można wykonać na tym typie, to:

-   dodawania <strong>+</strong>, odejmowanie <strong>-</strong>
-   mnożenie <strong>\* </strong>, dzielenie <strong>/</strong>
-   dzielenie całkowite **div**, dzielenie modulo **mod**

Do podstawowych typów danych w języku Pascal należą:

-   **integer** - typ reprezentujący liczby całkowite
-   **real** - typ reprezentujący liczby rzeczywiste
-   **char** - typ reprezentujący znaki
-   **Boolean** - typ reprezentujący wartości logiczne

Zmienne w programach napisanych w Pascalu deklarowane są za pomocą słowa kluczowego
**var**, po którym następuje list par: *nazwa\_zmiennej* : *typ\_zmiennej*, zakończonych
średnikami.
Pierwszy człon pary może być również listą, której elementy oddzielone
są za pomocą przecinków - wtedy wszystkie zmienne występujące na tej liście
posiadają typ, który określony jest po prawej stronie dwukropka.

**Przykład**

code(pascal).
var
liczba\_calkowita : integer;
liczba\_rzeczywista : real;
wartosc\_logiczna : Boolean;
znak1,znak2 : char;

W powyższym przykładzie definiowanych jest 5 zmiennych: **liczba\_calkowita**,
**liczba\_rzeczywista**, **wartosc\_logiczna**, **znak1** oraz **znak2**.
Pierwsza zmienna jest typu **całkowitego**, druga **rzeczywistego**,
trzecia **logicznego**, a czwarta i piąta **znakowego**.

### Typ tablicowy

Typ tablicowy pozwala na definiowanie zmiennych, które składają się
z tablic elementów jednakowego typu. Elementy tablicy mogą być typu prostego
lub złożonego (np. tablicowego). Pozwala to na definiowanie np. tablic tablic
(którym w matematyce odpowiada pojęcie macierzy).

Każda zmienna typu tablicowego musi określać zakres indeksów oraz typ elementów.
Zakres indeksów podawany jest po słowie kluczowym **array**, jako para liczb
całkowitych oddzielona dwoma kropkami, ujęta w nawiasy kwadratowe. Pierwszy
element zakresu musi mieć wartość mniejszą lub równą drugiemu elementowi zakresu.

Typ elementów podawany jest po słowie kluczowym **of**.

**Przykład**

code(pascal).
var
wektor1 : array\[1..10\] of integer;
macierz1 : array\[1..10\] of array\[1..10\] of integer;

W powyższym przykładzie definiowane są dwie zmienne, spośród których pierwsza
jest tablicą składającą się z 10 elementów typu całkowitego, druga zaś jest
tablicą 10 tablic składających się z 10 elementów typu całkowitego.

Dostęp do elementów tablicy odbywa się za pomocą **operatora indeksowania** \[\],
który pojawia się po nazwie zmiennej i zawiera indeks elementu. Za pomocą
tego operatora można zarówno odczytywać jak i przypisywać wartości
poszczególnym elementom tablicy. Indeks elementu, do którego następuje dostęp,
musi należeć do zdefiniowanego zakresu tablicy (tzn. musi być większy lub
równy dolnemu zakresowi oraz mniejszy lub równy górnemu zakresowi).

**Przykład**

code(pascal).
var
wektor : array\[1..10\] of integer;
pierwszy\_element : integer;
begin
wektor1\[1\] := 1;
{przypisanie wartości do pierwszego elementu tablicy wektor1}
pierwszy\_element := wektor\[1\]
{odczyt wartości pierwszego elementu tablicy wektor1}
wektor1\[20\] := 100;
{powyższe przypisanie spowoduje błąd przekroczenia zakresu}
wektor1\[1\] := 'a';
{powyższe przypisanie spowoduje błąd niezgodności typów - tablica wektor może zawierać wyłącznie liczby całkowite}
end.

Jak to zostało wcześniej wskazane, elementy tablicy mogą być typu złożonego, w
szczególności typu tablicowego. Konstrukcje tego rodzaju pozwalają na definiowanie
np. tablic tablic, inaczej zwanych tablicami dwuwymiarowymi. Na tej samej zasadzie
można tworzyć tablice trój-, cztero- czy n-wymiarowe.

Aby odwołać się do podstawowego elementu takiej struktury,
należy określić dwa indeksy - tablicy pierwszego i drugiego rzędu.
Można to zrobić zestawiając ze sobą dwa operatory indeksowania lub w jednym
operatorze wpisać dwa indeksy oddzielone przecinkiem.

W przypadku tablic dwuwymiarowych, pierwszy indeks zwany jest indeksem *wierszowym*,
natomiast drugi - *kolumnowym*.

**Przykład**

code(pascal).
var
macierz1 : array\[1..10\] of array\[1..3\] of integer;
begin
macierz1\[1\]\[1\] := 1;
{przypisanie wartości 1 elementowi stojącemu w pierwszym wierszu i pierwszej kolumnie zmiennej macierz1}
macierz1\[1\]\[3\] := 2;
{przypisanie wartości 2 elementowi stojącemu w pierwszym wierszu i trzeciej kolumnie zmiennej macierz1}
macierz1\[3\]\[1\] := 3;
{przypisanie wartości 3 elementowi stojącemu w trzecim wierszu i pierwszej kolumnie zmiennej macierz1}
macierz1\[4\]\[1\] := 4;
{przypisanie poprawne}
macierz1\[1\]\[4\] := 5;
{przypisanie błędne - spowoduje błąd przekroczenia zakresu}
end.

Instrukcje
----------

Instrukcje występujące w kodzie programu napisanego w języku Pascal
odpowiadają blokom lub grupom bloków połączonych strzałkami, występujących
na schematach blokowych.

Wśród instrukcji występują:

-   instrukcja **pusta**
-   instrukcja **grupująca**
-   instrukcje **decyzyjne**
-   **pętle**

Instrukcja pusta składa się z jednego średnik - ; i jak wskazuje jej nazwa,
jest ignorowana. Pozostałe typy instrukcji omówione są poniżej.

### Instrukcja grupująca

Instrukcja ta pozwala na traktowanie sekwencji instrukcji jak pojedynczej
instrukcji. Instrukcja ta składa się ze słowa kluczowego **begin**, listy
instrukcji oddzielonych średnikami (najczęściej zapisywanych w kolejnych
wierszach programu), a kończy słowem kluczowym **end**.

Ogólna postać instrukcji grupującej przedstawiona jest poniżej:

code(pascal).
begin
{instrukcja\_1};
{instrukcja\_2};
{...}
end

**Przykład**

W poniższym przykładzie instrukcja grupująca obejmuje trzy operacje
przypisania wartości do zmiennych, odpowiednia a, b i c.

code(pascal).
var
a,b,c : integer;
begin
a := 5;
b := 2;
c := a \* b;
end.

Instrukcji grupująca nie posiada swojego bezpośredniego
odpowiednika w schematach blokowych. Każdy fragment schematu
blokowego, w którym wszystkie ścieżki wykonania zaczynają się
i kończą w tych samych punktach może być objęty instrukcją grupującą.

Powyższemu przykładowi odpowiada po prostu sekwencja bloków obliczeniowych:

![](/images/pas_group.png)

### Instrukcja warunkowa i instrukcja selekcji

W języku Pascal, podobnie jak w schematach blokowych, występują dwie
instrukcje decyzyjne (odpowiadają one blokowi warunkowemu oraz blokowi
selekcji): **warunkowa** i **selekcji**.

**Instrukcja warunkowa**

Instrukcja warunkowa pozwala na wykonanie alternatywnych ścieżek programu,
w zależności od spełnienia określonego warunku logicznego.
Instrukcja ta składa się ze słowa kluczowego **if**, po którym następuje
wyrażenie logiczne, po nim zaś następuje słowo kluczowe **then**. Instrukcja,
która umieszczona jest po nim, wykonywana jest, gdy warunek logiczny
jest prawdziwy. Po tej instrukcji może nastąpić słowo kluczowe **else**,
wraz z instrukcją, która jest wykonywana, jeśli warunek logiczny nie zachodzi.
W poprawnej instrukcji warunkowej nie musi jednak występować klauzula **else**.

Ogólny schemat instrukcji warunkowej przedstawiony jest poniżej.

code(pascal).
if wyr\_log then
{instrukcja\_1}
else
{instrukcja\_2};
{instrukcja\_3};

Kod który następuje po drugiej instrukcji (w przypadku wystąpienia klauzuli else)
lub pierwszej (w przypadku przeciwny) wykonywany jest niezależnie od tego, czy
wyrażenie logiczne jest prawdziwe, czy fałszywe. Powyższemu przykładowi
na schemacie blokowym odpowiadałaby następująca grupa bloków:

![](/images/pas_if.png)

Ponieważ w instrukcji warunkowej w poszczególnych alternatywnych ścieżkach
wykonania programu może wystąpić tylko jedna instrukcja, w celu wykonania
większej liczby instrukcji, konieczne jest wykorzystanie instrukcji
grupującej (patrz poniższy przykład).

Wyrażenia logiczne występujące w instrukcji warunkowej mogą
stanowić alternatywę lub koniunkcję wyrażeń logicznych. **Alternatywa**
logiczna zapisywana jest za pomocą słowa kluczowego **or**, natomiast
**koniunkcja** za pomocą słowa kluczowego **and**. Negacja zapisywana
jest za pomocą słowa kluczowego **not**.

**Przykład**

code(pascal).
var
rok, liczba\_dni, dni\_w\_lutym : integer;
begin
write("Wprowadź rok: ");
readln(rok);
if (rok mod 4 = 0 and ((not(rok mod 100 = 0)) or (rok mod 400 = 0))
begin
liczba\_dni := 366;
dni\_w\_lutym := 29;
end
else
begin
liczba\_dni := 365;
dni\_w\_lutym := 28;
end;
write("W roku ");
write(rok);
write("jest ");
write(liczba\_dni);
writeln(" dni.");
write("Luty ma w tym roku");
write(dni\_w\_lutym);
writeln(" dni");
end.

Powyższy fragment kodu ustala wartość zmiennych *liczba\_dni* oraz *dni\_w\_lutym*
na podstawie wartości zmiennej rok. (Lata przestępne wypadają co cztery
lata, z wyjątkiem lat będących wielokrotnością 100 ale nie będących wielokrotnością
400). Zastosowano w nim wyrażenie logiczne składające się z alternatywy,
negacji oraz koniunkcji, a także przedstawiono zastosowanie instrukcji
grupującej w kontekście instrukcji warunkowej.

Ponadto w przykładzie tym wykorzystane są procedury biblioteczne *write*, *writeln*
oraz *readln* (o procedurach czytaj dalej).
Pierwsza procedura pozwala wyprowadzać komunikaty na zewnątrz
wykonywanego programu (zazwyczaj na ekran monitora). Druga działa tak samo,
ale dodatkowo powoduje przejście do nowej linii. Ostatnia procedura
pozwala wczytać wartość wprowadzoną z klawiatury do zmiennej.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_1

**Instrukcja selekcji**

Instrukcja selekcji służy do wyboru jednej spośród wielu możliwych
ścieżek realizacji algorytmu. Instrukcja ta składa się
ze słowa kluczowego **case**, po którym następuje nazwa zmiennej,
słowo kluczowe **of** oraz lista par *stała* : *instrukcja*.
W instrukcji selekcji wykonywana jest tylko instrukcja
stojąca na prawo od pierwszego wystąpienia stałej, której
wartość równa się wartości zmiennej.

W ogólnym przypadku, po lewej stronie może występować lista stałych.

Ogólna postać instrukcji selekcji przedstawiona jest poniżej:

code(pascal).
case zmienna of
stala1 : {instr\_1};
stala2 : {instr\_2};
stala3, stala4 : {instr\_3};
{...}
end;

Instrukcji selekcji na schematach blokowych odpowiada blok selekcji:

![](/images/pas_select.png)

**Przykład**

code(pascal).
var
znak : char;
begin
write("Wprowadź znak: ");
read(znak);
case znak of
'.', ',', '!' : write("znak przestankowy");
'0', '1', '2', '3', '4', '5', '6', '7', '8', '9' : write("cyfra");
' ' : write("spacja");
end
end.

W powyższym przykładzie instrukcja selekcji wykorzystywana jest
do opisywania niektórych typów znaków znajdujących się w zmiennej *znak*.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_2

### Pętle

Schematy blokowe nie dostarczają żadnych specjalnych mechanizmów do tworzenia
pętli (czyli fragmentów algorytmu, które wykonywana są wielokrotnie).
W większości języków programowania istnieją jednak instrukcje, które pozwalają
na łatwe definiowanie pętli, gdyż są one stosowane bardzo często.

W języku Pascal istnieją trzy instrukcje służące do tworzenia pętli:

-   **`while`**
-   **`repeat` ... `until`**
-   **`for`**

W zasadzie każda pętla może być skonstruowana przy użyciu dowolnej
z tych instrukcji. Tym niemniej, zazwyczaj użycie wybranej instrukcji
jest wygodniejsze w tych albo innych przypadkach.

**Pętla `while`**

Pętla tworzona z wykorzystaniem instrukcji **while** jest najprostszym typem pętli.
Pozwala ona na wykonywanie pewnej instrukcji tak długo, jak długo spełniony
jest określony warunek logiczny.

Pętla tego rodzaju składa się ze słowa kluczowego **while**, po którym występuje
warunek logiczny, za nim pojawia się słowo kluczowe **do** oraz instrukcja, która
ma być wykonywana.

Ogólna postać pętli `while` przedstawiona jest w poniższym przykładzie:

code(pascal).
while wyr\_log do
{instrukcja\_1};

Dosyć jasne jest, że jeśli początkowo warunek logiczny jest spełniony i
w instrukcji wykonywanej w ramach pętli nie dokonywane jest żadne obliczenie,
które może spowodować zmianę wartości warunku logicznego, to pętla ta będzie
wykonywała się w nieskończoność.

Pętli `while` odpowiada następujący schemat blokowy:

![](/images/pas_while.png)

**Przykład**

code(pascal).
var
znak : char;
begin
while not EOF do
begin
read(znak);
write(znak);
end;
end.

W powyższym przykładzie powtarzana jest procedura wczytywania pojedynczych znaków
z klawiatury (*read(znak)*) oraz wypisywania ich na ekran(*write(znak)*).
Procedura *EOF* zwraca wartość `fałsz`, tak długo, jak długo na wejściu dostępne
są dane, zatem pętla będzie powtarzała się tak długo, jak długo użytkownik
nie zakończy wprowadzania znaków (np. w systemach uniksowych wprowadzanie danych
można zakończyć wprowadzając sekwencję Ctrl+D).

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_3

**Pętla repeat ... until**

Pętla tworzona z wykorzystaniem instrukcji **repeat ... until** wykonywana jest
co najmniej raz i kończy się wykonywać, jeśli jest
spełniony występujący w niej warunek logiczny.

Pętla tego rodzaju składa się ze słowa kluczowego **repeat**, po którym występuje
sekwencja instrukcji zakończonych słowem kluczowym **until** i warunkiem logicznym.

Ogólna postać pętli `repeat` przedstawiona jest poniżej:

code(pascal).
repeat
{instrukcja\_1};
{instrukcja\_2};
{...}
until wyr\_log;

Należy zwrócić uwagę, że pętla `repeat ... until` różni się od pętli `while` pod
trzema względami:

-   pętla `repeat` wykonuje się co najmniej 1 raz, natomiast pętla `while` może się
    nie wykonać wcale
-   pętla `repeat` wykonywana jest tak długo, jak występujący w niej warunek
    logiczny jest **fałszywy**, natomiast pętla `while` wykonuje się tak długo,
    jak występujący w niej warunek jest **prawdziwy**
-   pętla `repeat` do wykonania wielu instrukcji **nie wymaga** stosowania instrukcji grupującej

Pętli `repeat ... until` odpowiada następujący schemat blokowy:

![](/images/pas_repeat.png)

**Przykład**

code(pascal).
var
znak: char;
begin
repeat
writeln("Wprowadź znak i naciśnij \[enter\]. Aby zakończyć wprowadź 'k'");
readln(znak);
write("Wprowadziłeś ");
writeln(znak);
until znak = 'k';
end.

W powyższym kodzie użytkownik proszony jest o wprowadzenie znaku.
Znak wprowadzony przez użytkownika jest ponownie wyprowadzany na ekran.
Procedura ta powtarza się do momentu, w którym użytkownik wprowadzi znak 'k'.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_4

**Pętla for**

Pętla realizowana przy użyciu słowa kluczowego **for** zwana jest pętlą numeryczną,
gdyż liczba jej wykonań określana jest *explicite* przez wartości numeryczne.
Pętla ta jest często stosowana do wykonywania określonych operacji
na tablicach, gdyż zawiera zmienną indeksującą, która w trakcie jej wykonywania
przyjmuje wartości z pewnego zakresu, który może odpowiadać zakresowi
tablicy.

Pętla ta definiowana jest za pomocą słowa kluczowego **for**, po którym następuje
nazwa zmiennej indeksującej, operator przypisania, pierwszy zakres indeksu,
słowo kluczowe **to** lub **downto**, drugi zakres indeksu, słowo kluczowe **do**
oraz instrukcja, która ma zostać wykonana.

Ogólna postać pętli `for` ze słowem kluczowym `to` przedstawiona jest poniżej.

code(pascal).
for indeks := war\_1 to war\_2 do
{instrukcja\_1};

Pętla `for`, w której występuje słowo kluczowe `to`, wykonywana jest w następujący
sposób: najpierw zmiennej indeksującej przypisywana jest wartość pierwszego
(w tym wypadku - dolnego) zakresu, następnie wartość zmiennej porównywana
jest z wartością drugiego (górnego) zakresu i jeśli jest ona mniejsza lub
równa, wykonywana jest instrukcja stojąca po słowie kluczowym `do`. Po
wykonaniu instrukcji, zmienna indeksująca zwiększana jest o 1 i ponownie
porównywana z górnym zakresem.

Pętli `for` ze słowem kluczowym `to` odpowiada następujący schemat blokowy:

![](/images/pas_for.png)

W przypadku wykorzystania słowa kluczowego `downto` odwracany jest kierunek
wykonania pętli - zmienna indeksująca musi być większa lub równa niż drugi
(w tym wypadku - dolny) zakres, a w każdym kroku jest ona zmniejszana o 1.

**Przykład**

code(pascal).
const
n = 5;
var
indeks, wartosc : integer;
liczby : array\[1..n\] of integer;
begin
for indeks := 1 to n do
begin
write("Wprowadź ");
write(indeks);
write(". liczbę całkowitą: ");
readln(wartosc);
liczby\[indeks\] := wartosc;
end
for indeks := n downto 1 do
writeln(wektor1\[indeks\]);
end.

W powyższym przykładzie użytkownik na początku
proszony jest o wprowadzenie 5 liczb całkowitych,
które są następnie wyświetlane w odwrotnej kolejności.

W przykładzie tym zastosowano, nieomawiane wcześniej słowo kluczowe **const**,
które pozwala na definiowanie stałych. W przykładzie definiowana jest
stała <emph>n</emph> o wartości 5.

Wykonanie programu mogłoby wyglądać następująco:
CODEBLOCK\_PLACEHOLDER\_5

Podprogramy
-----------

W trakcie tworzenia złożonych algorytmów niejednokrotnie zdarza się,
że pewne zadania przez nie realizowane powtarzają się w wielu miejscach.
Kiedy dotyczy to sekwencji prostych operacji, to można oczywiście
zastosować pętlę, w której algorytm zostanie wykonany wielokrotnie.

Taka sytuacja nie zawsze ma jednak miejsce - zazwyczaj powtarzający
się fragment kodu znajduje się w różnych miejscach algorytmu i zastosowanie
wcześniej opisanych konstrukcji nie pozwala rozwiązać tego problemu.

Dlatego jednym z podstawowych udogodnień dostarczanych przez języki programowani
są **podprogramy** czyli wydzielone algorytmy, które mogą być wielokrotnie
wywoływane. W rzeczywistości procedury opisane wcześniej takie
jak `write` czy `read` są właśnie podprogramami. Jednakże używanie tylko i
wyłącznie wbudowanych procedur nie pozwoliłoby rozwiązać omawianego tutaj
problemu, gdyż do efektywnego korzystania z podprogramów poza
mechanizmem ich **wywoływania** potrzebny jest również
mechanizm ich **definiowania**.

Podprogramy nie byłyby jednak tak użyteczne, gdyby nie to, że mogą
być wywoływane z różnymi **parametrami**, które modyfikują działanie
podprogramu. Na parametry podprogramu można również spojrzeć jak
na dane wejściowe, które mają ulec przetworzeniu.

W języku Pascal istnieją dwa typy podprogramów: **procedury** i **funkcje**.
Różnią się od siebie tym, że funkcje, w przeciwieństwie do
procedur, zwracają wartości (dane wyjściowe).
Ich działanie podobne jest zatem do funkcji matematycznych, które
dla określonych argumentów produkują pewien określony wynik.

Zazwyczaj funkcje wykorzystuje się do przetworzenia danych wejściowych
na dane wyjściowe, natomiast procedury nie produkują danych wyjściowych.
Nie znaczy to jednak, że za ich pomocą nie można modyfikować wartości
pewnych zmiennych. Jest tak dlatego, że argumenty do funkcji i procedur
mogą być przekazywane przez wartość i przez referencję. W pierwszym
przypadku przekazywana jest sama wartość zmiennej, która pojawiła się
w wywołaniu funkcji lub procedury. Natomiast w drugim przypadku przekazywana
jest zmienna, co pozwala na modyfikację jej wartości. Zagadnienie to jest
szczegółowo przedstawione dalej.

**Procedury**

**Definicja** procedury składa się z nagłówka, części deklaracyjnej
oraz ciała procedury. **Nagłówek** procedury składa się ze słowa
kluczowego `procedure`,
nazwy procedury, ujętej w nawiasy okrągłe list oddzielonych średnikami
argumentów postaci `nazwa_argumentu : typ`.

**Część deklaracyjna** procedury może się składać z tych samych deklaracji
co program, czyli: deklaracji stałych i zmiennych oraz definicji typów.

**Ciało procedury** składa się z ciągu instrukcji języka Pascal ujętych
w słowa kluczowe `begin` oraz `end`. Ogólna postać definicji
procedury przedstawiona jest poniżej:

code(pascal).
procedure nazwa\_procedury(argument\_1 : typ\_1; argument\_2 : typ\_2, ...);
type
{definicje typów}
const
{deklaracje stałych}
var
{deklaracje zmiennych}
begin
{ciało procedury}
end

W ciele procedury dostępne są wszystkie zmienne zadeklarowane w
części deklaracyjnej programu, w części deklaracyjnej tej procedury,
a także zmienne, które są parametrami procedury.
Te ostatnie zmienne przyjmują wartości takie jak wartości argumentów
przekazanych w wywołaniu procedury.

Nazwa procedury wraz z listą jej parametrów stanowi jej **sygnaturę**.

Jeśli chcemy **wywołać** wcześniej zdefiniowaną procedurę musimy
podać jej nazwę oraz ujęte w nawiasy okrągłe argumenty. Argumenty
mogą być stałymi lub zmiennymi, których ilość i typ odpowiada dokładnie
ilości i typowi argumentów pojawiających się w sygnaturze procedury.

Ogólna postać wywołania procedury jest następująca:

code(pascal).
nazwa\_procedury(argument\_1, argument\_2, ...);

Przykład wykorzystania procedury:

code(pascal).
program liczby;
procedure wypisz\_liczbe(liczba : integer);
begin
write("Liczba posiada wartość ");
writeln(liczba);
end;
begin
wypisz\_liczbe(5);
wypisz\_liczbe(10);
wypisz\_liczbe();
{wywołanie niepoprawne - brak argumentu}
wypisz\_liczbe('a');
{wywołanie niepoprawne - niewłaściwy typ argumentu}
end.

W powyższym programie definiujemy procedurę `wypisz_liczbe`, która
wypisuje komunikat "Liczba posiada wartość " oraz podaje
wartość liczby. Dwa wywołania występujące w programie są
niepoprawne. Pierwsze posiada inną liczbę argumentów niż sygnatura
procedury, w drugim - typ argumentu przekazanego w wywołaniu
nie pokrywa się z typem argumentu występującym w sygnaturze.

Po usunięciu błędnych wywołań, wykonanie programu wyglądałoby
następująco:
CODEBLOCK\_PLACEHOLDER\_6

**Przekazywanie przez referencję**... (w przygotowaniu)

**Funkcje**

Funkcje od procedur różnią się tym, że ich wykonanie kończy się zwróceniem
pewnej wartości, która może być wykorzystana w instrukcji przypisania.

Definicja funkcji nie różni się bardzo od definicji procedury. Jedyna różnica
polega na tym, że po liście argumentów funkcji pojawia się
dwukropek i typ argumentu, który jest zwracany przez funkcję.

Ogólna postać definicji funkcji jest następująca:

code(pascal).
function nazwa\_funkcji(argument\_1 : typ\_1; argument\_2 : typ\_2, ...) : typ\_wyniku;
{deklaracje}
begin
{ciało funkcji}
end

W ciele funkcji dostępne są wszystkie zmienne, które wymienione były
w opisie procedur oraz zmienna, której nazwa jest taka sama jak
nazwa funkcji. Wartość zwracana przez funkcję to ostatnia wartość
przypisana do tej zmiennej. Należy pamiętać aby każda ścieżka
wykonania algorytmu zapewniała przypisanie pewnej wartości do tej
zmiennej. Najlepiej zatem w pierwszej instrukcji przypisać pewną
domyślną wartość tej zmiennej.

Wywołanie funkcji musi spełniać te same założenia co wywołanie procedury.
Jeśli chcemy wykorzystać wartość zwracaną przez funkcję, musimy przypisać
ją do zmiennej, której typ jest taki sam, jak tym wartości
zwracanej przez funkcję. Dla ogólnej funkcji zdefiniowanej powyżej
moglibyśmy użyć następującego wywołania:

code(pascal).
var
zmienna : typ\_wyniku;
{deklaracja funkcji - j.w.}
begin
zmienna = nazwa\_funkcji(argument\_1, argument\_2, ...);
end.

Przykład wykorzystania funkcji:

code(pascal).
program potega;
var
wartosc : integer;
function potega(podstawa : integer; wykladnik : integer);
var
indeks : integer;
begin
potega := 1;
for indeks := 1 to wykladnik do
potega := potega \* podstawa;
end
begin
wartosc := potega(2,3);
write("Trzecią potęgą liczby 2 jest : ");
writeln(wartosc);
wartosc := potega(3,4);
write("Czwartą potęgą liczby 3 jest : ");
writeln(wartosc);
end.

Wykonanie powyższego programu wygląda następująco:
CODEBLOCK\_PLACEHOLDER\_7

Struktura programu
------------------

code(pascal).
program pierwszy\_program;
{nazwa programu}
const
{deklaracje stałych}
PI := 3.141;
type
{deklaracje typów}
wektor = array\[1..10\] of integer;
var
{deklaracje zmiennych}
indeks : integer;
wektor1 : wektor;
begin
{początek programu}
{...}
end.
{koniec programu}
