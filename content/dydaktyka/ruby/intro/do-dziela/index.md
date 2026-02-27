---
title: Do dzieła!
date: '2007-08-28T10:53:00Z'
lastmod: '2008-02-14T22:07:51Z'
draft: false
tags:
- ruby
author: 83.175.191.74
---

Instalacja
----------

Instalacja Ruby zależy oczywiście od platformy, której używasz na co dzień. Jeżeli:

-   cieszysz się jakąś odmianą **Linuksa** - uruchom narzędzie do pobierania pakietów, a na pewno znajdziesz
    Ruby w repozytorium (użytkownicy mojego ulubionego Gentoo piszą oczywiście `emerge ruby`, nie muszą
    nawet klikać :)
-   posiadasz nowego **Maca z MacOS-em**? - Ruby jest już na pokładzie! Podobno najlepiej pisze się w Ruby w TextMate.
-   posiadasz **Windows**? - współczuję, bowiem w tym wypadku musisz samodzielnie ściągnąć
    [instalator](http://rubyinstaller.rubyforge.org/wiki/wiki.pl) i pewnie kliknąć kilka razy
    "Yes", w odpowiedzi na pytanie: Czy chcesz zainstalować najlepszy język programowania na swoim komputerze?
    Na osłodę dostaniesz kilka gadżetów, takich jak edytor z kolorowaniem składni (oczywiście
    użytkownicy Linuksa, niezależnie od tego czy korzystają z Emacsa czy Vima gardzą takimi gadżetami).

Konsola
-------

Kiedy będziesz już szczęśliwym posiadaczem tego zacnego języka (a właściwie jego interpretera), możesz
od razu zacząć cieszyć się jego obecnością, nie otwierając nawet edytora!
Jak każdy porządny język skryptowy, wyposażony jest on w konsolę, w której można
wprowadzać polecenia w sposób interaktywny. Wywoływana jest ona za pomocą
polecenia: <br/>
`irb`

Dzięki temu napisanie najprostszego programu, czyli *Hello world* sprowadza się do
wpisania w konsoli:<br/>

code.
&gt; puts "Hello world"
\#=&gt; Hello world

<span class="red">Uwaga</span>. <br/>
W powyższym zapisie przyjąłem następującą konwencję, która będzie używana dalej -
pojedynczy znak "&gt;" to znak zachęty konsoli Ruby. To co po nim następuje, musi
zostać wprowadzone przez Ciebie. Natomiast komentarz, po którym następuje strzałka
"\#=&gt;" oznacza to, co powinno pojawić się na ekranie w wyniku wykonania kodu.
W dalszych przykładach pomijany jest znak zachęty konsoli.

W zasadzie
większość fragmentów kodu można skopiować do konsoli i wszystko
powinno działać bez zarzutu. Jedynie w [ostatnim rozdziale](../metaprogramowanie)
poświęconym metaprogramowaniu pojawiają się przykłady, które nie będą działać
(o ile nie będzie zainstalowana platforma Ruby on Rails i
nie zostaną załadowane odpowiednie biblioteki).
Rozdział ten ma jednak charakter bardziej poglądowy, więc nie powinno to
stanowić większego problemu.

Tyle powinno wystarczy na początek. A jeśli twój apetyt na Ruby
właśnie się zaostrzył, zapraszam do omówienia [podstawowych typów danych](/dydaktyka/ruby/intro/typy-danych).

[Poprzedni rozdział](/dydaktyka/ruby/intro/wstep) |
[Następny rozdział](/dydaktyka/ruby/intro/typy-danych)
