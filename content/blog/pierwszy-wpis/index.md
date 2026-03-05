---
title: (Prawie) Pierwszy wpis
date: '2009-07-14T18:39:00Z'
lastmod: '2013-12-19T14:32:38Z'
draft: false
tags:
- ruby
- colors
author: 149.156.173.34
---

Coś małego na początek - [colors](http://github.com/apohllo/colors/tree/master) - rozszerzenie klasy String
o możliwość kolorowania. Działa oczywiście wyłącznie na terminalach zgodnych z ANSI, na pozostałych dostaniemy
tekst wejściowy z dodatkiem "krzaków".

Instalacja z wykorzystaniem rubygems jest banalna (pod warunkiem, że mamy wersję co najmniej 1.2.0 i github dodany do źródeł)

~~$ sudo gem install apohllo-colors~~

code(bash).
$ sudo gem install gemcutter
$ sudo gem tumble
$ sudo gem install colors

([Więcej o powodach przejścia na gemcutter](/blog/gemcutter).
Upewnij się również, że masz Rubygems w wersji co najmniej 1.3.3)

Potem odpalamy konsolę `irb` i sprawdzamy czy wszystko działa jak trzeba:

code(ruby).
require 'rubygems'
require 'colors'
"abc".hl \#=&gt; abc (wyboldowane, uwierzcie mi na słowo)
"abc".hl(:red) \#=&gt; abc (czerwone, j.w. :)
"ala ma kota ale nie ma psa".hl(:blue, "ma")
\#=&gt; ala **ma** kota ale nie **ma** pas (wyróżnione słowa na niebiesko)

Sam w sobie projekt ten z pewnością nie robi dużego wrażenia, ale wykorzystuję go nagminnie.
Każdy kto zetknął się z kolorowaną konsolą, wie jaka jest różnica pomiędzy jednolitym, czarnym, białym czy zielonym
tekstem, a np. wyróżnionym znakiem zachęty.

Zapraszam do testowania.
