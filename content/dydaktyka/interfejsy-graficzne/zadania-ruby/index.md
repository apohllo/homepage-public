---
title: Ruby - Zadania
date: '2008-11-27T07:32:00Z'
lastmod: '2009-11-16T09:35:12Z'
draft: false
tags:
- ruby
author: 149.156.96.15
toc: true
---

Przykładowe zadania na kolokwium
================================

### Typy danych i struktury języka

1.  Posortowanie tablicy w porządku malejącym
2.  Znajdowanie [mediany](http://pl.wikipedia.org/wiki/Mediana) liczb w nieposortowanej tablicy
3.  Znajdowanie [dominanty](http://pl.wikipedia.org/wiki/Dominanta_(statystyka&#41); liczb w tablicy
4.  Obliczenie statystyki wystąpień słów w pliku (odmienne formy tego samego słowa traktować jako odmienne słowa)
5.  Zamiana łańcucha znaków, na przyjazny adres URL (zawierający małe litery, cyfry i znak - ), w którym wszystkie znaki nie-alfanumeryczne są usuwane i zastępowane pojedynczym znakiem - . Na początku i końcu napisu nie mogą występować znaki - . Polskie znaki traktować jak znaki niealfanumeryczne. (np. dla "Zazieleniło się 21. listopada!" efekt: "zazieleni-o-si-21-listopada").
6.  Linię tekstu rozbić na poszczególne słowa i przekształcić w tablicę posortowaną w kolejności rosnących długości napisów (np. "Ala ma kotka" -&gt; \["kotka", "Ala", "ma"\])
7.  Wypisanie indeksów wszystkich elementów w tablicy, których wartość jest powyżej/poniżej pewnej wartości.
8.  Wczytywanie liczb wprowadzanych przez użytkownika do tablicy ('k' kończy wprowadzanie). Wypisanie w odwrotnej kolejności.
9.  Jw. ale wypisywać tylko n najmniejszych liczb (bez powtórzeń).
10. Określanie typu napisu, tzn. jeśli zawiera (Podpowiedź - wykorzystanie instrukcji `case`):
    -   same znaki alfabetu, na wyjściu powinien pojawiać napis 'znaki alfabetu'
    -   same cyfry -&gt; 'cyfry'
    -   znaki alfanumeryczne -&gt; 'znaki alfanumeryczne'
    -   w pozostałych przypadkach -&gt; 'groch z kapustą'

11. Wczytać z wejścia plik, na wyjściu powinien pojawić się ten sam plik z numerami poszczególnych linii i usuniętymi pustymi liniami (pominięte linie nie mają być uwzględnione w numeracji)
12. Wczytać z wejścia plik i wyszukać wszystkie linie zawierające ciąg znaków zawarty w pierwszej linii pliku. Dopasowany fragment powinien być wyróżniony.
13. Sprawdzanie poprawności [numeru PESEL](http://pl.wikipedia.org/wiki/Pesel)

### Programowanie obiektowe

1. Napisać klasę Weight, która w konstruktorze przyjmuje jako parametr masę wyrażoną w kilogramach oraz pozwala na jej odczyt w kilogramach i gramach:

code(ruby).
w = Weight.new(1)
w.in\_kilos \#=&gt; 1
w.in\_grams \#=&gt; 1000

2. Napisać klasę Temerature, która w konstruktorze przyjmuje dwa parametry - temperaturę oraz
symbol oznaczający system pomiaru (:c - stopnie [Celsjusza](http://en.wikipedia.org/wiki/Celsius), :f - stopnie Fahrenheita, :k - Kelviny). Klasa powinna definiować metody, które pozwalają na odczyt temperatury w dowolnym z systemów:

code(ruby).
t = Temperature.new(100, :c)
t.in\_celsius \#=&gt; 100
t.in\_kelvins \#=&gt; 373.15
t.in\_fahrenheits \#=&gt; 212

code(ruby).
t = Temperature.new(100, :k)
t.in\_celsius \#=&gt; -173.15
t.in\_kelvins \#=&gt; 100
t.in\_fahrenheits \#=&gt; -279.67

3. Dla klasy Temperature z poprzedniego punktu dodać metody pozwalające na ustawianie
wartości w dowolnym systemie. Zmienić konstruktor tak, aby domyślnie tworzył temperaturę
0 Kelwinów:

code(ruby).
t = Temerature.new()
t.in\_kelvins \#=&gt; 0
t.in\_celsius = 100
t.in\_kelvins \#=&gt; 373.15

4. Zdefiniować klasy CD i Book, tak aby w konstruktorze jako parametr przyjmowały cenę i tytuł,
które mogą być odczytane poprzez metody `price` i `title`. Cena wraz z jednostką
monetarną powinna być wyświetlana w metodzie `diplay_price`, natomiast metoda `to_s`
powinna zwracać informację o typie produktu, tytule i jego cenie:

code(ruby).
cd = CD.new(60,"Hot '80 summer hits")
cd.price \#=&gt; 60
cd.display\_price \#=&gt; "60 PLN"
cd.title \#=&gt; "Hot '80 summer hits"
cd.to\_s \#=&gt; "CD: Hot '80 summer hits, 60 PLN"
book = Book.new(30, "Imię róży")
book.price \#=&gt; 30
book.display\_price \#=&gt; "30 PLN"
book.title \#=&gt; "Imię róży"
book.to\_s \#=&gt; "Książka: Imię róży, 30 PLN"

5. Zdefiniować klasę Product, z której dziedziczyłyby klasy CD i Book z poprzedniego
punktu tak, aby usunąć duplikację kodu w tych klasach (wskazówka: zastosować dziedziczenie).

6. Zmodyfikować klasy Book i CD w taki sposób, aby klasa Book przyjmowała
jako parametr konstruktora liczbę stron, natomiast CD liczbę utworów.
Informacje te powinny być wyświetlane w metodzie `to_s` oraz powinny istnieć akcesory
dla tych atrybutów (ograniczyć do minimum powtarzający się kod):

code(ruby).
cd = CD.new(60, "Hot '80 summer hits", 10)
cd.to\_s \#=&gt; "CD: Hot '80 summer hits, 60 PLN, 10 utworów"
cd.tracks \#=&gt; 10
book = Book.new(30, "Imię róży",411)
book.to\_s \#=&gt; "Książka: Imię róży, 30 PLN, 411 stron"
book.pages \#=&gt; 411

Rozwiązania
-----------

### Typy danych i struktury języka

1. Sortowanie tablicy

code(ruby).
a = \[1,3,7,2,5\].sort.reverse

2. Mediana

code(ruby).
a = \[1,3,2,4\].sort
if a.size % 2 == 0
(a\[a.size/2-1\] + a\[a.size/2\]) / 2.0
else
a\[a.size/2\]
end

3. Dominanta

code(ruby).
a = \[1,2,1,3,2,4,2,5\]
histogram = Hash.new(0)
a.each{|e| histogram\[e\] += 1}
histogram.index(histogram.values.sort\[-1\])

4. Statystyka słów

code(ruby).
stat = Hash.new(0)
while line = gets
line.chop.gsub(/\[^a-zA-Z\]/," ").split(/\\s+/).each{|word| stat\[word\] += 1}
end
puts stat.inspect

5. Przyjazny URL

code(ruby).
"Zazieleniło się 21. listopada!".gsub(/\[^a-zAZ0-9\]/," ").squeeze(" ").strip.gsub(" ","-").downcase

6. Sortowanie słów w linii

code(ruby).
"Ala ma kota".split(/\\s+/).sort{|a,b| b.size &lt;=&gt; a.size}

7. Filtr górnoprzepustowy

code(ruby).
min\_value = 10
puts \[5,11,10,3,123\].select{|e| e &gt;= min\_value}

8. Wczytywanie liczb

code(ruby).
a = \[\]
while line = gets.chop
break if line == "k"
a &lt;&lt; line.to\_i
end
puts a.reverse

9. Wczytywanie liczb, wypisywanie najmniejszych

code(ruby).
a = \[\]
n = 3
while line = gets.chop
break if line == "k"
a &lt;&lt; line.to\_i
end
puts a.sort\[0...n\]

10. Typ napisu

code(ruby).
napis = gets.chop
puts case napis
when /^$/
"napis pusty"
when /^\[a-zA-Z\]\*$/
"znaki alfabetu"
when /^\[0-9\]\*$/
"cyfry"
when /^\\s\*$/
"białe spacje"
when /^\\w\*$/
"znaki alfanumeryczne"
else
"groch z kapustą"
end

11. Dekorowanie pliku

code(ruby).
line\_number = 1
while line = gets
next if line =~ /^\\s\*$/
puts "\#{line\_number}: \#{line}"
line\_number += 1
end

12. Prymitywny grep

code(ruby).
query = gets.chop
while line = gets
puts line.sub(/\#{query}/,"&lt;\#{query}&gt;") if line =~ /\#{query}/
end

13. Pesel

a. Wersja rozwlekła

code(ruby).
factors = \[1, 3, 7, 9, 1, 3, 7, 9, 1, 3, 1\]
pesel = \[8, 5, 0, 4, 2, 2, 4, 5, 6, 7, 3\]
sum = 0
index = 0
for digit in pesel
sum += digit \* factors\[index\]
index += 1
end
puts (sum % 10 == 0 ? "Pesel poprawny" : "Pesel niepoprawny")

b. Wersja zwięźlejsza

code(ruby).
factors = "13791379131".split("")
sum = 0
"85042245673".split("").each\_with\_index do |digit, index|
sum += digit.to\_i \* factors\[index\].to\_i
end
puts (sum % 10 == 0 ? "Pesel poprawny" : "Pesel niepoprawny")

c. Wersja najkrótsza

code(ruby).
factors = "13791379131".split("")
valid = "85042245673".split("").inject(0){|sum,e| sum + e.to\_i \* factors.shift.to\_i} % 10 == 0
puts (valid ? "Pesel poprawny" : "Pesel niepoprawny")

### Programowanie obiektowe

1. Waga

code(ruby).
class Weight
def initialize(value)
`value = value
  end
  def in_kilos
    `value
end
def in\_grams
@value \* 1000
end
end

2. Temperatura (1)

code(ruby).
class Temperature
ABSOLUTE\_ZERO = - 273.15
CELSIUS\_TO\_FAHRENHEIT\_FACTOR = 9.0/5
CELSIUS\_TO\_FAHRENHEIT\_OFFSET = 32
def initialize(value, system)
\# store the value always in Kelvins
case system
when :c
`value = celsius_to_kelvin(value)
    when :f
      `value = celsius\_to\_kelvin(fahrenheit\_to\_celsius(value))
else
`value = value
    end
  end
  def in_kelvins
    `value
end
def in\_celsius
kelvin\_to\_celsius(`value)
  end
  def in_fahrenheits
    celsius_to_fahrenheit(kelvin_to_celsius(`value))
end
protected
def celsius\_to\_kelvin(value)
value - ABSOLUTE\_ZERO
end
def kelvin\_to\_celsius(value)
value + ABSOLUTE\_ZERO
end
def celsius\_to\_fahrenheit(value)
value \* CELSIUS\_TO\_FAHRENHEIT\_FACTOR +
CELSIUS\_TO\_FAHRENHEIT\_OFFSET
end
def fahrenheit\_to\_celsius(value)
(value - CELSIUS\_TO\_FAHRENHEIT\_OFFSET) \*
CELSIUS\_TO\_FAHRENHEIT\_FACTOR
end
end

3. Temperatura (2)

Klasę Temperature z poprzedniego punktu rozszerzamy o następujące kod:

code(ruby).
class Temperature
def initialize(value=0, system=:k)
\# store the value always in Kelvins
case system
when :c
`value = celsius_to_kelvin(value)
    when :f
      `value = celsius\_to\_kelvin(fahrenheit\_to\_celsius(value))
else
`value = value
    end
  end
  def in_kelvins=(value)
    `value = value
end
def in\_celsius=(value)
`value = celsius_to_kelvin(value)
  end
  def in_fahrenheits=(value)
    `value = celsius\_to\_kelvin(fahrenheit\_to\_celsius(value))
end
end

4. Produkty (1)

code(ruby).
class CD
attr\_accessor :price, :title
def initialize(price, title)
`price = price
    `title = title
end
def display\_price
"\#{price} PLN"
end
def to\_s
"CD: \#{title}, \#{display\_price}"
end
end

code(ruby).
class Book
attr\_accessor :price, :title
def initialize(price, title)
`price = price
    `title = title
end
def display\_price
"\#{price} PLN"
end
def to\_s
"Książka: \#{title}, \#{display\_price}"
end
end

5. Produkty (2)

code(ruby).
class Product
attr\_accessor :price, :title
NAME = "Produkt"
def initialize(price, title)
`price = price
    `title = title
end
def display\_price
"\#{price} PLN"
end
def product\_name
self.class::NAME
end
def to\_s
"\#{product\_name}: \#{title}, \#{display\_price}"
end
end
class CD &lt; Product
NAME = "CD"
end
class Book &lt; Product
NAME = "Książka"
end

6. Produkty (3)

Klasy CD oraz Book z poprzedniego punktu rozszerzamy o następujący kod:

code(ruby).
class CD &lt; Product
attr\_accessor :tracks
def initialize(price, title, tracks)
super(price, title)
`tracks = tracks
  end
  def to_s
    super + ", #{self.tracks} utworów"
  end
end
class Book < Product
  attr_accessor :pages
  def initialize(price, title, pages)
    super(price, title)
    `pages = pages
end
def to\_s
super + ", \#{self.pages} stron"
end
end
