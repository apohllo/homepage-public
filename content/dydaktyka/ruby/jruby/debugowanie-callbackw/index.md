---
title: Debugowanie callbacków
date: '2007-04-08T17:58:41Z'
lastmod: '2007-04-08T17:58:41Z'
draft: false
tags:
- java
- ruby
- jruby
description: ruby, jruby, java
author: 213.227.68.34
---

Inny problem jaki może się pojawić, gdy próbujemy zmusić do współpracy Javę i Rubiego przy
pomocy JRuby i BSF (Bean scripting framework), tym razem "po stronie" Rubiego, dotyczy
komunikatów diagnostycznych, które pojawiają się gdy coś pójdzie źle.

Wyobraźmy sobie następują scenariusz: w Javie wywołujemy kod Rubiego, który z kolei wywołuje
pewne metody Javy - klasyczny przypadek callbacków. Wydawać by się mogło, że jeśli nastąpi
jakiś błąd w javowym callbacku, to interpreter Rubiego zakomunikuje to w zrozumiały sposób.
Nic bardziej mylnego. W moim przypadku pojawił się komunikat:


    can't convert nil into String (TypeError)
    :127:in `process'
    <script>:127:in `process'
    ...
    </code>

Ponieważ metoda, która była wywoływana z poziomu Rubiego przyjmowała jako argument
Stringa, myślałem, że przekazywany parametr jest nil'em. Kiedy jednak przeanalizowałem
krótki kod Rubiego na wszystkie możliwe sposoby, doszedłem do wniosku, że błąd musi tkwić
gdzie indziej. Dopiero kiedy odpaliłem
debuggera Javy, okazało się, że błąd wcale nie występował po stronie Rubiego, tylko
właśnie po stronie Javy - sam callback miał zaledwie kilka linijek. Błąd tkwił w wyrażeniu
regularnym, co dodatkowo utrudniało jego wykrycie.

Zatem - jeśli wykorzystujecie podobny scenariusz do tego przedstawionego powyżej, otoczcie
metody callbackowe klauzulą <code>try{ ... }catch(Excpetion ex)</code>, gdyż Ruby może
zakomunikować wyjątek rzucony po stronie Javy w sposób bardzo mało zrozumiały.
