---
title: Język C
date: '2010-10-27T12:44:00Z'
lastmod: '2011-11-02T05:02:05Z'
draft: false
tags:
- wdi
- c
author: 91.150.223.28
toc: true
---

Informacje wstępne
------------------

### Struktura programu

Program w języku C zazwyczaj składa się z deklaracji plików nagłówkowych,
definicji funkcji i procedur oraz wyróżnionej funkcji `main`, która jest
domyślnie wywoływana w momencie uruchomienia programu. Funkcja ta zwraca wartość typu `int`.

code©.
// deklaracje plików nagłówkowych
\#include <stdio.h>
// definicje funkcji i procedur
void procedure1(){
// ciało procedury
}
int function1(int arg){
// ciało funkcji
}
int main(){
// ciało głównej funkcji
}

Komentarze w kodzie mogą przyjmować postać dwóch *slashy* // i wtedy obowiązują do końca linijki.

### Kompilacja i uruchamianie programu

Aby wykonać program napisany w języku C, należy najpierw dokonać jego kompilacji, tzn. przetłumaczenia
jego kodu źródłowego na ciąg instrukcji niskiego poziomu, zrozumiałych przez procesor. W systemach
uniksopodobnych kompilacja odbywa się za pomocą polecenia `gcc`, które wymaga podania nazwy pliku do skompilowania, np.

code(bash).
$ gcc prog1.c

W wyniku wywołania tego polecenia, tworzony jest plik a.out, który może zostać bezpośrednio uruchomiony. Przy uruchamianiu
programu, jego Nazwa musi zostać poprzedzona kropką i *slashem*, np.

code(bash).
$ ./a.out

Aby określić nazwę generowanego pliku, możemy skorzystać z opcji -o, np.

code(bash).
$ gcc prog1.c -o prog1

Wtedy można wywołać program korzystając z tej nazwy:

code(bash).
$ ./prog1

### Podstawowe operacje wejścia/wyjścia

Aby móc komunikować się z użytkownikiem uruchamiającym program, konieczna jest
znajomość co najmniej dwóch wywołani ze standardowej biblioteki C - `printf` oraz
`fgets`. Oba wywołania są zdefiniowane w bibliotece `sdtio`.

#### `printf`

Wywołanie `printf` pozwala wypisać na ekran wartości różnych typów zmiennych.
Pierwszym argumentem tego wywołania jest format komunikatu, który może składać
się ze zwykłych znaków oraz wyrażeń, które są zastępowane wartościami
pozostałych argumentów tego wywołania.

Najprostsze wywołanie wygląda następująco:

code©.
printf("Hello world.\\n")

Jeśli natomiast chcemy aby w komunikacie pojawiła się wartość jakiejś zmiennej, to
musimy dobrać wyrażenie odpowiadające jej typowi. Składa się ono z znaku % oraz znak lub znaków
odpowiadających typowi, np.

-   s - łańcuch znaków
-   c - pojedynczy znak
-   d - liczba całkowita
-   ld - długa liczba całkowita
-   f - liczba zmiennopozycyjna

Przykładowo:
code©.
int i = 10;
float f = 20.0;
printf("Zmienna i: %d, zmienna f: %f",i,f);

#### `fgets`

Odczytanie komunikatu użytkownika jest nieco bardziej skomplikowane. Ze względów
bezpieczeństwa nie wykorzystuje się wywołania `gets`, które ma najprostszą postać.
Wywołanie `fgets` wymaga aż trzech argumentów: zmiennej, która reprezentuje tablicę,
w której ma być umieszczony wynik, maksymalnej liczby czytanych znaków oraz nazwy
strumienia, z którego odczytujemy znaki. W domyślnej postaci czyta znaki do końca
linii (o ile nie przekroczona byłaby maksymalna liczba znaków przekazana w wywołaniu).

code©.
char napis\[31\];
fgets(napis,31,stdin);

Przykładowy program wczytujący komunikat użytkownika i wypisujący go na ekran
wygląda następująco:

code©.
\#include <stdio.h>
int main(){
char napis\[31\];
fgets(napis,31,stdin);
printf("%s\\n",napis);
}

### Podstawowe operacje konwersji

Ponieważ język C nie pozwala na automatyczną konwersję pomiędzy typami danych,
aby móc operować na danych liczbowych dostarczanych przez użytkownika, konieczne
jest przeprowadzenie konwersji pomiędzy łańcuchem znaków, a odpowiednim type
liczbowym.

Metody konwersji definiowane są w bibliotece `stdlib`, dlatego wymagają załączenia
pliku nagłówkowego `<stdlib.h>`

#### atoi, atol

Metody `atoi` oraz `atol` pozwalają na konwersję łańcucha znaków na liczbę
całkowitą typu `int` oraz typu `long`. Jako swój argument przyjmują łańcuch
znaków w postaci tablicy i zwracają wartość całkowitą.

Przykładowo, jeśli chcemy obliczyć sumę wartości wprowadzonych przez użytkownika
możemy napisać następujący program:

code©.
\#include <stdio.h>
\#include <stdlib.h>
int main(){
int liczba1, liczba2;
char napis\[11\];
printf("Wprowadź pierwszą liczbę: ");
fgets(napis,11,stdin);
liczba1 = atoi(napis);
printf("Wprowadź drugą liczbę: ");
fgets(napis,11,stdin);
liczba2 = atoi(napis);
printf("Suma wprowadzonych liczb wynosi %d\\n",liczba1 + liczba2);
}

#### atof

Funkcja `atof` jest odpowiednikiem funkcji `atoi`, ale służy do konwersji liczb zmiennopozycyjnych.
Jako argument przyjmuje łańcuch znaków, natomiast zwracana wartość jest typu `double`.

Typy danych
-----------

### Podstawowe typy danych

Każda zmienna używana w języku C musi mieć określony typ,
który określa **zbiór wartości**, jakie może ona przyjmować oraz wyznacza
**operacje**, jakie mogą być wykonywane na wartościach przypisanych do zmiennej.

Przykładowo - typ **int** to typ reprezentujący liczby całkowite (właściwie - pewien
ich zakres). Operacje jakie można wykonać na tym typie, to:

-   dodawania <strong>+</strong>, odejmowanie <strong>-</strong>
-   mnożenie <strong>\* </strong>, dzielenie całkowice <strong>/</strong>
-   dzielenie modulo <strong>%</strong>

Do podstawowych typów danych w języku C należą:

-   **int** - typ reprezentujący liczby całkowite
-   **long** - jak **int** reprezentujacy wartosci całkowiet, ale o większym zakresie wartości
-   **float** - typ reprezentujący liczby rzeczywiste pojedynczej precyzji
-   **double** - typ reprezentujący liczby rzeczywiste podwójnej precyzji
-   **char** - typ reprezentujący znaki

Zmienne w programach napisanych w C deklarowane są za pomocą słowa kluczowego
reprezentującego typ zmiennej, po którym następuje list *nazwa\_zmiennych* zakończona
średnikami.

**Przykład**

code©.
int liczba\_calkowita;
float liczba\_rzeczywista;
char znak1,znak2;

W powyższym przykładzie definiowanych są 4 zmienne: **liczba\_calkowita**,
**liczba\_rzeczywista**, **znak1** oraz **znak2**.
Pierwsza zmienna jest typu **całkowitego**, druga **rzeczywistego**, a
trzecia i czwarta **znakowego**.

### Typ tablicowy

Typ tablicowy pozwala na definiowanie zmiennych, które składają się
z tablic elementów jednakowego typu. Elementy tablicy mogą być typu prostego
lub złożonego (np. tablicowego). Pozwala to na definiowanie np. tablic tablic
(którym w matematyce odpowiada pojęcie macierzy).

Każda zmienna typu tablicowego musi określać swój rozmiar oraz typ elementów.
Typ elementów określany jest przez nazwę typu składowego występującą
przed nazwą zmiennej.
Rozmiar tablicy podawany jest jako liczba całkowita ujęta w nawiasy kwadratowe
po nazwie zmiennej. Elementy tablicy indeksowane są od 0.

**Przykład**

code©.
int wektor\[10\];
int macierz\[10\]\[10\];

W powyższym przykładzie definiowane są dwie zmienne, spośród których pierwsza
jest tablicą składającą się z 10 elementów typu całkowitego, druga zaś jest
tablicą 10 tablic składających się z 10 elementów typu całkowitego.

Dostęp do elementów tablicy odbywa się za pomocą **operatora indeksowania** \[\],
który pojawia się po nazwie zmiennej i zawiera indeks elementu. Za pomocą
tego operatora można zarówno odczytywać jak i przypisywać wartości
poszczególnym elementom tablicy. Indeks elementu, do którego następuje dostęp,
musi być większy lub równy 0 oraz mniejszy od rozmiaru tablicy.

**Przykład**

code©.
int main(){
int wektor1\[10\];
int pierwszy\_element;
//przypisanie wartości do pierwszego elementu tablicy wektor1
wektor1\[0\] = 1;
//odczyt wartości pierwszego elementu tablicy wektor1
pierwszy\_element = wektor1\[1\]
//poniższe przypisanie jest niepoprawne, gdyż wartość przypisywana dla indeksu spoza górnego limitu
wektor1\[20\] = 100;
//poniższe przypisanie nie spowoduje błędu, ponieważ znak niejawnie konwertowany jest
//na liczbę całkowitą, na podstawie swojego położenia w tablicy ASCII
wektor1\[0\] = 'a';
}

Jak to zostało wcześniej wskazane, elementy tablicy mogą być typu złożonego, w
szczególności typu tablicowego. Konstrukcje tego rodzaju pozwalają na definiowanie
np. tablic tablic, inaczej zwanych tablicami dwuwymiarowymi. Na tej samej zasadzie
można tworzyć tablice trój-, cztero- czy n-wymiarowe.

Aby odwołać się do podstawowego elementu takiej struktury,
należy określić dwa indeksy - tablicy pierwszego i drugiego rzędu.
Można to zrobić zestawiając ze sobą dwa operatory indeksowania.

W przypadku tablic dwuwymiarowych, pierwszy indeks zwany jest indeksem *wierszowym*,
natomiast drugi - *kolumnowym*.

**Przykład**

code©.
int main(){
int macierz1\[10\]\[3\];
// przypisanie wartości 1 elementowi stojącemu w pierwszym wierszu i pierwszej kolumnie zmiennej macierz1
macierz1\[0\]\[0\] = 1;
//przypisanie wartości 2 elementowi stojącemu w pierwszym wierszu i trzeciej kolumnie zmiennej macierz1
macierz1\[0\]\[2\] = 2;
//przypisanie wartości 3 elementowi stojącemu w trzecim wierszu i pierwszej kolumnie zmiennej macierz1
macierz1\[2\]\[0\] = 3;
//przypisanie poprawne
macierz1\[3\]\[0\] = 4;
//przypisanie niepoprawne - drugi indeks nie jest mniejszy niż rozmiar tablicy
macierz1\[0\]\[3\] = 5;
}

Instrukcje
----------

Instrukcje występujące w kodzie programu napisanego w języku C
odpowiadają blokom lub grupom bloków połączonych strzałkami, występującym
na schematach blokowych.

Wśród instrukcji występują:

-   instrukcja **pusta**
-   instrukcja **grupująca**
-   instrukcje **decyzyjne**
-   **pętle**

Instrukcja pusta składa się z jednego średnika ";" i jak wskazuje jej nazwa,
jest ignorowana. Pozostałe typy instrukcji omówione są poniżej.

### Instrukcja grupująca

Instrukcja ta pozwala na traktowanie sekwencji instrukcji jak pojedynczej
instrukcji. Instrukcja ta składa się z otwierającego nawiasu klamrowego "{", listy
instrukcji oddzielonych średnikami (najczęściej zapisywanych w kolejnych
wierszach programu), a kończy nawiasem klamrowym zamykającym "}".

Ogólna postać instrukcji grupującej przedstawiona jest poniżej:

code©.
{
//instrukcja\_1;
//instrukcja\_2;
//...
}

**Przykład**

W poniższym przykładzie instrukcja grupująca obejmuje trzy operacje
przypisania wartości do zmiennych, odpowiednia a, b i c.

code©.
int main(){
int a,b,c;
{
a = 5;
b = 2;
c = a \* b;
}
}

Instrukcji grupująca nie posiada swojego bezpośredniego
odpowiednika w schematach blokowych. Każdy fragment schematu
blokowego, w którym wszystkie ścieżki wykonania zaczynają się
i kończą w tych samych punktach może być objęty instrukcją grupującą.

Powyższemu przykładowi odpowiada po prostu sekwencja bloków obliczeniowych:

![](/images/c_group.png)

### Instrukcja warunkowa i instrukcja selekcji

W języku C, podobnie jak w schematach blokowych, występują dwie
instrukcje decyzyjne (odpowiadają one blokowi warunkowemu oraz blokowi
selekcji): **warunkowa** i **selekcji**.

**Instrukcja warunkowa**

Instrukcja warunkowa pozwala na wykonanie alternatywnych ścieżek programu,
w zależności od spełnienia określonego warunku logicznego.
Instrukcja ta składa się ze słowa kluczowego **if**, po którym następuje ujęte w nawiasy okrągłe
wyrażenie logiczne, po nim zaś następuje instrukcja,
która wykonywana jest, gdy warunek logiczny
jest prawdziwy. Po tej instrukcji może nastąpić słowo kluczowe **else**,
wraz z instrukcją, która jest wykonywana, jeśli warunek logiczny nie zachodzi.
W poprawnej instrukcji warunkowej nie musi jednak występować klauzula **else**.

Ogólny schemat instrukcji warunkowej przedstawiony jest poniżej.

code©.
if(wyr\_log)
//instrukcja\_1;
else
//instrukcja\_2;
//instrukcja\_3;

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
logiczna zapisywana jest za pomocą operatora **||**, natomiast
**koniunkcja** za pomocą operatora **&&**. **Negacja** zapisywana
jest za pomocą operatora <strong>!</strong>.

**Przykład**

code©.
\#include <stdio.h>
\#include <stdlib.h>
int main(){
int rok, liczba\_dni, dni\_w\_lutym;
char napis\[31\];
printf("Wprowadź rok: ");
fgets(napis,31,stdin);
rok = atoi(napis);
if ((rok % 4  0 && ((rok % 100 != 0) || (rok % 400  0))){
liczba\_dni = 366;
dni\_w\_lutym = 29;
} else {
liczba\_dni = 365;
dni\_w\_lutym = 28;
}
printf("W roku %d jest %d dni.\\n",rok,liczba\_dni);
printf("Luty ma w tym roku %d dni.\\n",dni\_w\_lutym);
}

Powyższy fragment kodu ustala wartość zmiennych *liczba\_dni* oraz *dni\_w\_lutym*
na podstawie wartości zmiennej rok. (Lata przestępne wypadają co cztery
lata, z wyjątkiem lat będących wielokrotnością 100 ale nie będących wielokrotnością
400). Zastosowano w nim wyrażenie logiczne składające się z alternatywy,
negacji oraz koniunkcji, a także przedstawiono zastosowanie instrukcji
grupującej w kontekście instrukcji warunkowej.

Ponadto w przykładzie tym wykorzystane są funkcje i procedury biblioteczne *printf*, *fgets*
oraz *atoi* (o funkcjach i procedurach czytaj dalej).
Pierwsza procedura pozwala wyprowadzać komunikaty na zewnątrz
wykonywanego programu (zazwyczaj na ekran monitora). Druga procedura
pozwala wczytać wartość wprowadzoną z klawiatury do zmiennej.
Natomiast funkcja *atoi* pozwala na konwersję napisu do wartości liczbowej.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_1

**Instrukcja selekcji**

Instrukcja selekcji służy do wyboru jednej spośród wielu możliwych
ścieżek realizacji algorytmu. Instrukcja ta składa się
ze słowa kluczowego **switch**, po którym następuje nazwa zmiennej ujęta
w nawiasy okrągłe oraz otwierający nawias klamrowy.
Każda alternatywna ścieżka realizacji algorytmu zaczyna się
od słowa kluczowego **case**, po którym występuje stała oraz
dwukropek oznaczający początek listy instrukcji, które mają
zostać zrealizowane dla tej opcji. List instrukcji kończy się
słowem kluczowym **break**.

W ogólnym przypadku można łączyć kilka opcji w jedną (jeśli
wprowadzi się kolejną instrukcję `case` bez słowa kluczowego `break`
lub jeśli poda się zakres stałych w postaci dolnego i górnego ograniczenia
i trzykropka występującego pomiędzy nimi).

Ogólna postać instrukcji selekcji przedstawiona jest poniżej:

code©.
switch(zmienna){
case stala1 :
//instr\_1;
break;
case stala2 :
//instr\_2;
break;
case stala3 :
case stala4 :
//instr\_3;
break;
}

Instrukcji selekcji na schematach blokowych odpowiada blok selekcji:

![](/images/pas_select.png)

**Przykład**

code©.
\#include <stdio.h>
int main(){
char napis\[2\];
printf("Wprowadź znak: ");
fgets(napis,2,stdin);
switch(napis\[0\]){
case '.' :
case ',' :
case '!' :
printf("znak przestankowy\\n");
break;
case '0' ... '9' :
printf("cyfra\\n");
break;
case 'a' ... 'z' :
case 'A' ... 'Z' :
printf("litera\\n");
break;
case ' ' :
printf("spacja\\n");
break;
}
}

W powyższym przykładzie instrukcja selekcji wykorzystywana jest
do opisywania niektórych typów znaków występujących jako pierwszy znak
zmiennej *napis*.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

Wprowadź znak: .

znak przestankowy

### Pętle

Schematy blokowe nie dostarczają żadnych specjalnych mechanizmów do tworzenia
pętli (czyli fragmentów algorytmu, które wykonywana są wielokrotnie).
W większości języków programowania istnieją jednak instrukcje, które pozwalają
na łatwe definiowanie pętli, gdyż są one stosowane bardzo często.

W języku C istnieją trzy instrukcje służące do tworzenia pętli:

-   **`while`**
-   **`do` ... `while`**
-   **`for`**

W zasadzie każda pętla może być skonstruowana przy użyciu dowolnej
z tych instrukcji. Tym niemniej, zazwyczaj użycie wybranej instrukcji
jest wygodniejsze w tych albo innych przypadkach.

**Pętla `while`**

Pętla tworzona z wykorzystaniem instrukcji **while** jest najprostszym typem pętli.
Pozwala ona na wykonywanie pewnej instrukcji tak długo, jak długo spełniony
jest określony warunek logiczny.

Pętla tego rodzaju składa się ze słowa kluczowego **while**, po którym występuje
warunek logiczny, a po nim instrukcja, która ma być wykonywana.

Ogólna postać pętli `while` przedstawiona jest w poniższym przykładzie:

code©.
while(wyr\_log)
//instrukcja\_1;

Dosyć jasne jest, że jeśli początkowo warunek logiczny jest spełniony i
w instrukcji wykonywanej w ramach pętli nie dokonywane jest żadne obliczenie,
które może spowodować zmianę wartości warunku logicznego, to pętla ta będzie
wykonywała się w nieskończoność.

Pętli `while` odpowiada następujący schemat blokowy:

![](/images/pas_while.png)

**Przykład**

code©.
\#include <stdio.h>
int main(){
char znak;
while(!feof(stdin)){
znak = getchar();
printf("%c\\n",znak);
}
}

W powyższym przykładzie powtarzana jest procedura wczytywania pojedynczych znaków
z klawiatury (`znak = getchar()`) oraz wypisywania ich na ekran (`printf("%c\n",znak)`).
Funkcja *feof* zwraca wartość `fałsz`, tak długo, jak długo na wejściu dostępne
są dane, zatem pętla będzie powtarzała się tak długo, jak długo użytkownik
nie zakończy wprowadzania znaków (np. w systemach uniksowych wprowadzanie danych
można zakończyć wprowadzając sekwencję Ctrl+D). Powtórne wystąpienie funkcji `getchar`
związane jest z faktem, że po wprowadzeniu znaku konieczne jest naciśnięcie klawisza
<enter>. Dzięki temu znak ten jest konsumowany i można wprowadzić kolejny znak.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_2

**Pętla do ... while**

Pętla tworzona z wykorzystaniem instrukcji **do ... while** wykonywana jest
co najmniej raz i kończy się wykonywać, jeśli nie jest
spełniony występujący w niej warunek logiczny.

Pętla tego rodzaju składa się ze słowa kluczowego **do**, po którym występuje
instrukcja przeznaczona do wykonania, a kończy się kluczowym **while** i warunkiem
logicznym ujętym w nawiasy okrągłe.

Ogólna postać pętli `do ... while` przedstawiona jest poniżej:

code©.
do
//instrukcja\_1;
while(wyr\_log);

Należy zwrócić uwagę, że pętla `do ... while` różni się od pętli `while` pod
tym względem, że pętla `do ... while` wykonuje się co najmniej 1 raz, natomiast pętla `while` może się
nie wykonać wcale.

Pętli `do ... while` odpowiada następujący schemat blokowy:

![](/images/c_repeat.png)

**Przykład**

code©.
\#include <stdio.h>
int main(){
char znak;
do {
printf("Wprowadź znak i naciśnij \[enter\]. Aby zakończyć wprowadź 'k'\\n");
znak = getchar();
printf("Wprowadziłeś %c\\n",znak);
getchar();
} while(znak != 'k');
}

W powyższym kodzie użytkownik proszony jest o wprowadzenie znaku.
Znak wprowadzony przez użytkownika jest ponownie wyprowadzany na ekran.
Procedura ta powtarza się do momentu, w którym użytkownik wprowadzi znak 'k'.

Przykładowe wykonanie programu mogłoby wyglądać następująco:

CODEBLOCK\_PLACEHOLDER\_3

**Pętla for**

Pętla realizowana przy użyciu słowa kluczowego **for** zwana jest pętlą numeryczną,
gdyż liczba jej wykonań zazwyczaj określana jest przez wartości numeryczne.
Pętla ta jest często stosowana do wykonywania określonych operacji
na tablicach, gdyż w typowej postaci zawiera zmienną indeksującą, która w trakcie jej wykonywania
przyjmuje wartości z pewnego zakresu, który może odpowiadać zakresowi
tablicy.

Pętla ta definiowana jest za pomocą słowa kluczowego **for**, po którym następuje
wyrażenie inicjujące, warunek kontynuacji pętli oraz krok pętli.
W jej ciele występuje instrukcja, która ma zostać wykonana.

Ogólna, typowa postać pętli `for` przedstawiona jest poniżej.

code©.
for(indeks = war\_1; indeks &lt; war\_2; indeks++)
//instrukcja\_1;

Typowa pętla `for`, wykonywana jest w następujący
sposób: najpierw zmiennej indeksującej przypisywana jest wartość pierwszego
(w tym wypadku - dolnego) zakresu, następnie wartość zmiennej porównywana
jest z wartością drugiego (górnego) zakresu i jeśli jest ona mniejsza,
wykonywana jest instrukcja będąca jej ciałem. Po
wykonaniu tej instrukcji, zmienna indeksująca zwiększana jest o 1 i ponownie
porównywana z górnym zakresem.

W ogólności - na samym początku raz wykonywane jest wyrażenie inicjujące,
potem sprawdzany jest warunek kontynuacji pętli, następnie wykonywane jest
ciało pętli, a po nim ewaluowane jest wyrażenie stanowiące krok pętli.
Jeśli warunek kontynuacji pętli jest dalej spełniony, ponownie wykonuje
się ciało pętli i krok, itd.

Typowej pętli `for` odpowiada następujący schemat blokowy:

![](/images/c_for.png)

Aby odwrócić kierunek wykonywania pętli, w kroku pętli, zamiast
inkrementować (**) indeks, można go dekrementować (--). Konieczne
jest wtedy zmienienie warunku kontynuacji pętli.

**Przykład**

code©.
\#include <stdio.h>
int main(){
const n = 5;
int indeks;
int liczby\[n\];
char napis\[11\];
for(indeks = 0; indeks &lt; n; indeks++){
printf("Wprowadź %d. liczbę całkowitą: ",indeks+1);
fgets(napis,11,stdin);
liczby\[indeks\] = atoi(napis);
}
for(indeks = n-1; indeks &gt;= 0; indeks--){
printf("%d\\n",liczby\[indeks\]);
}
}

W powyższym przykładzie użytkownik na początku
proszony jest o wprowadzenie 5 liczb całkowitych,
które są następnie wyświetlane w odwrotnej kolejności.

W przykładzie tym zastosowano, nieomawiane wcześniej słowo kluczowe **const**,
które pozwala na definiowanie stałych. W przykładzie definiowana jest
stała <emph>n</emph> o wartości 5.

Wykonanie programu mogłoby wyglądać następująco:
CODEBLOCK\_PLACEHOLDER\_4

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
jak `printf` czy `fgets` są właśnie podprogramami. Jednakże używanie tylko i
wyłącznie wbudowanych procedur nie pozwoliłoby rozwiązać omawianego tutaj
problemu, gdyż do efektywnego korzystania z podprogramów poza
mechanizmem ich **wywoływania** potrzebny jest również
mechanizm ich **definiowania**.

Podprogramy nie byłyby również zbyt użyteczne, gdyby nie to, że mogą
być wywoływane z różnymi **parametrami**, które modyfikują działanie
podprogramu. Na parametry podprogramu można również spojrzeć jak
na dane wejściowe, które mają ulec przetworzeniu.

W języku C można wyróżnić dwa warianty podprogramów: **procedury** i **funkcje**.
Różnią się od siebie tym, że funkcje, w przeciwieństwie do
procedur, zwracają wartość (produkują dane wyjściowe).
Ich działanie podobne jest zatem do funkcji matematycznych, które
dla określonych argumentów produkują pewien określony wynik.

**Funkcje**

**Definicja** funkcji składa się z nagłówka oraz ciała procedury.
**Nagłówek** funkcji składa się z typu wartości zwracanej przez funkcję,
jej nazwy oraz ujętej w nawiasy okrągłe list oddzielonych przecinkami
argumentów postaci `typ nazwa_argumentu`.

**Ciało funkcji** składa się z ciągu instrukcji języka C ujętych
w nawiasy klamrowe. Ogólna postać definicji
funkcji przedstawiona jest poniżej:

code©.
typ\_rezultatu nazwa\_funkcji(typ\_1 argument\_1, typ\_2 argument\_2){
//ciało funkcji
}

W ciele funkcji dostępne są wszystkie zmienne globalne programu,
a także zmienne, które są jej parametrami.
Te ostatnie zmienne przyjmują wartości takie jak wartości argumentów
przekazanych w wywołaniu funkcji.

Nazwa funkcji wraz z listą jej parametrów stanowi jej **sygnaturę**.

Jeśli chcemy **wywołać** wcześniej zdefiniowaną funkcję musimy
podać jej nazwę oraz ujęte w nawiasy okrągłe argumenty. Argumenty
mogą być stałymi lub zmiennymi, których ilość i typ odpowiada dokładnie
ilości i typowi argumentów pojawiających się w sygnaturze funkcji.

Aby określić wartość zwracaną przez funkcję należy skorzystać ze słowa kluczowego `return`.
Warunkiem poprawności funkcji jest to, aby dla każdej możliwej ścieżki wykonania
funkcji została zwrócona wartość.

Ogólna, typowa postać wywołania funkcji jest następująca:

code©.
zmienn = nazwa\_funkcji(argument\_1, argument\_2, ...);

Konieczne jest, aby typ zmiennej, do której przypisujemy wartość wywołania funkcji
odpowiadał typowi zwracanemu przez tę funkcję. Jeśli typy te będą niezgodne, program
nie zostanie skompilowany.

Przykład wykorzystania funkcji:

code©.
\#include <stdio.h>
int potega(int podstawa, int wykladnik){
int indeks, rezultat;
rezultat = 1;
for(indeks = 0; indeks &lt; wykladnik; index++){
rezultat = rezultat \* podstawa;
}
return rezultat;
}
int main(){
int wartosc;
wartosc = potega(2,3);
printf("Trzecią potęgą liczby 2 jest : %d\\n",wartosc);
wartosc = potega(3,4);
printf("Czwartą potęgą liczby 3 jest : %d\\n",wartosc);
}

Wykonanie powyższego programu wygląda następująco:
CODEBLOCK\_PLACEHOLDER\_5

Warto zwrócić uwagę, że sam program definiowany jest jako funkcja, która również zwraca pewną
wartość. W przeciwieństwie do typowej funkcji, nie musi on jednak zwracać żadnej wartości.
Wartość zwracana przez program dostępna jest na zewnątrz i jeśli jest ona różna od zera,
oznacza to, że wykonanie programu zakończyło się błędem. Zwrócona wartość stanowi kod błędu
wykonania.

**Procedury**

Definicja procedury nie różni się bardzo od definicji funkcji. Jedyna różnica
polega na tym, że zamiast określonego typu zwracanej wartości, pojawia się słowo kluczowe `viod`
oraz, że procedura nie zwraca wartości, zatem nie zawiera klauzuli `return`.

Ogólna postać definicji procedury jest następująca:

code©.
void nazwa\_procedury(typ\_1 argument\_1, typ\_2 argument\_2){
//ciało procedury
}

W ciele procedury dostępne są wszystkie zmienne, które wymienione były
w opisie funkcji.

Wywołanie procedury musi spełniać te same założenia co wywołanie funkcji.
Należy jednak pamiętać, że skoro procedura nie zwraca wartości, nie może
pojawić się po prawej stronie instrukcji przypisania.

Przykład wykorzystania procedury:

code©.
void wypisz\_liczbe(int liczba){
printf("Liczba posiada wartość %d\\n",liczba);
}
int main(){
wypisz\_liczbe(5);
wypisz\_liczbe(10);
//wywołanie niepoprawne - brak argumentu
wypisz\_liczbe();
//wywołanie niepoprawne - niewłaściwy typ argumentu
wypisz\_liczbe("aa");
}

W powyższym programie definiujemy procedurę `wypisz_liczbe`, która
wypisuje komunikat "Liczba posiada wartość " oraz podaje
wartość liczby. Dwa wywołania występujące w programie są
niepoprawne. Pierwsze posiada inną liczbę argumentów niż sygnatura
procedury, w drugim - typ argumentu przekazanego w wywołaniu
nie pokrywa się z typem argumentu występującym w sygnaturze.

Po usunięciu błędnych wywołań, wykonanie programu wyglądałoby
następująco:
CODEBLOCK\_PLACEHOLDER\_6
