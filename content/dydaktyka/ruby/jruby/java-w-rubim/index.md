---
title: Java w Rubim
date: '2008-04-07T11:14:00Z'
lastmod: '2008-04-08T03:24:30Z'
draft: false
tags:
- java
- ruby
- jruby
author: 83.175.191.74
---

Choć w internecie pojawia się wiele przykładów na to jak wykorzystać Javę w Rubim korzystając z JRubiego, nie omieszkam pokrótce omówić tego zagadnienia.

Najprościej można przetestować ten scenariusz uruchamiając konsolę JRubiego -
**`jirb`** i wydając polecenie **`require 'java'`**:

```
$ jirb
&gt;&gt; require 'java'
\#=&gt; true
```

Dzięki temu prostemu poleceniu mamy dostęp do wszystkich pakietów, które znajdują się w dystrybucji Javy zainstalowanej na naszym komputerze (dalej będę pomijał znak zachęty jirb oraz początkowe wywołanie `require`):

```ruby
s = java.lang.String.new("abc")
\#=&gt; \#<Java::JavaLang::String:0xadf5be @java_object=abc>
s.length
\#=&gt; 3
s.codePointAt(1)
\#=&gt; 98
```

Co więcej - aby zachować zgodność z konwencjami Rubiego, wszystkie metody
Javy zapisane w CamelCase są również dostępne w wersji z podkreśleniami.
Ponadto, ponieważ piszemy w Rubim, nawiasy są opcjonalne:

```ruby
s = java.lang.String.new("abc")
\#=&gt; \#<Java::JavaLang::String:0xadf5be @java_object=abc>
s.code\_point\_at 1
\#=&gt; 98
```

Jeśli chcemy korzystać z jakiejś klasy Javy bez podawania każdorazowo
jej pełnej nazwy, możemy zaimportować odpowiedni pakiet za pomocą
dyrektywy **`import`**:

```ruby
import java.util.Date
d = Date.new 1111111111111
\#=&gt; \#<Java::JavaUtil::Date:0x1873eb2 @java_object=Fri Mar 18 02:58:31 CET 2005>
d.year
\#=&gt; 105
d.month
\#=&gt; 2
d.day
\#=&gt; 5
```

Widzimy zatem, że korzystanie z Javy w Rubim, przy pomocy JRubiego jest bardzo
proste. Co jednak mamy zrobić, jeśli chcemy skorzystać z jakiejś zewnętrznej
biblioteki napisanej w Javie? Odpowiedź jest prosta - wystarczy, że ścieżka do
niej znajdzię się w zmiennej środowiskowej CLASSPATH:

```ruby
$ export CLASSPATH=xstream-1.3.jar
$ jirb
&gt;&gt; require 'java'
\#=&gt; true
&gt;&gt; import com.thoughtworks.xstream.XStream
\#=&gt; Java::ComThoughtworksXstream::XStream
&gt;&gt; XStream.new
\#=&gt; \#<Java::ComThoughtworksXstream::XStream:0x1a3e41f @java_object=com.thoughtworks.xstream.XStream@1d03a4e>
```

Czy można chcieć więcej?
