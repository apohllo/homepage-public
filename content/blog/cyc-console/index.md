---
title: Cyc-console
date: '2009-10-06T05:42:00Z'
lastmod: '2009-10-08T12:44:39Z'
draft: false
tags:
- ruby
- cyc
author: 213.134.160.231
---

Ten post z pewnością powinien mieć dłuższy wstęp, który, mam nadzieję uda mi
się napisać niebawem.
Otóż z pewnością powinienem napisać więcej o ontologii
[Cyc](http://www.opencyc.org), bo bez tego
narzędzie, które tutaj promuję nie wydaje się zanadto przydatne.

Gdyby jednak znalazł się ktoś, kto zna tę ontologię i co więcej - korzystał z
wbudowanej weń konsoli,
z pewnością uzna, że jest ona rodem z epoki przedpotopowej. Nie wspiera ona
wielu zasadniczych koncepcji
znanych choćby z konsoli Linuksa, a nawet najprostszych klawiszy specjalnych,
takich jak &lt;Home&gt; i &lt;End&gt;.

Pracując nieustannie z Rubim i jego świetną konsolą `irb` z dodatkiem [Wirble](http://www.rubyinside.com/wirble-tab-completion-and-syntax-coloring-for-irb-336.html), stwierdziłem, że
można by spróbować zrobić
podobną konsolę dla Cyc-a. Zasadniczo powinna ona posiadać następujące
własności:

-   sensownie reagować na &lt;Home&gt;, &lt;End&gt;, strzałki itp.
-   mieć wbudowaną historię poleceń
-   wspierać kolorowane terminale
-   sprawdzać ilość nawiasów, przed wysłaniem zapytania na serwer
-   wspierać autouzupełnianie poleceń i symboli Cyc.

Jakiś czas temu zabrałem się za jej tworzenie i okazało się, że stworzenie takiej konsoli na bazie
`irb` nie jest specjalnie trudne. Oczywiście, to co powstało jest w fazie alfa - w obecnej chwili
nie ma np. autouzupełniania, ale jest już historia poleceń (zapamiętywana pomiędzy uruchomieniami),
no i wykorzystanie biblioteki readline pozwala używać klawisze specjalne w normalny sposób.

Dla wszystkich zainteresowanych - kod może być pobrany z [github.com/apohllo/cyc-console](http://github.com/apohllo/cyc-console) lub z wykorzystaniem Rubygems:

code(bash).
$ sudo gem install apohllo-cyc-console

(Od [wersji 0.0.5](/blog/cyc-console-0-0-5) wystarczy wpisać `sudo gem install cyc-console`).

W obu wypadkach wymagany jest gem `apohllo-colors`, o którym pisałem w [poprzednim poście](/blog/pierwszy-wpis).
