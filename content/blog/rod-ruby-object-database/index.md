---
title: Rod - Ruby Object Database
date: '2011-06-09T06:15:00Z'
lastmod: '2011-06-09T06:21:02Z'
draft: false
tags:
- db
- ruby
- rod
author: 91.150.223.28
---

Rok temu na EuRuKo miałem superkrótką prezentacje na temat biblioteki [Rod](https://github.com/apohllo/rod) mojego autorstwa. Wtedy rozwinąłem ten skrót jako "Read-only database", co wywołało gromki śmiech, bo po co komu baza danych tylko do odczytu? Obecnie nazwę rozwijam (oczywiście jest w tym przesada) jako Ruby Object Database. W praktyce jej podstawowy charakter się nie zmienił, ale z pewnością nazwa jest bardziej chwytliwa :)

Ale do rzeczy - co to za biblioteka? Otóż została ona zaprojektowana jak baza do przechowywania danych, które
rzadko ulegają zmianie. Chodzi mi przede wszystkim o dane lingwistyczne, tzn. takie jakie spotykamy w
tradycyjnych słownika i książkach (korpusach tekstów). Język oczywiście jest tworem żywym, co odzwierciedlone
jest w ewoluującej zawartości słowników, ale zmiany te następują raczej w ciągu lat, czy dziesięcioleci, niż
dni czy godzin. Podobnie z zawartością korpusów tekstów - jeśli coś tam trafi, to już raczej nie podlega zmianie
(być może usunięciu, jeśli język zmienił się na tyle, że tekst staje się bardzo mało reprezentatywny).

Dla tego typu danych nie potrzeba baz, które kładą specjalny nacisk na wielodostęp, czy transakcje, bo w praktyce
modyfikację bazy lepiej wykonać poprzez jej ponowne wygenerowanie, ewentualnie poprzez dodanie nowych danych
i powiązań między danymi, do już istniejącej bazy. Z drugiej strony baza tego rodzaju nie musi być trzymana w
pamięci, ponieważ analizując tekst potrzebujemy zawsze jedynie fragmentu słownika. Natomiast w
przypadku korpusów tekstu trzymanie w pamięci nie wchodzi w rachubę, ze względu na rozmiar danych. Dlatego tak
popularne ostatnio bazy oparte o memcache'a i pokrewne nie są zbyt przydatne dla danych lingwistycznych.

Z kolei relacyjne bazy danych nie mogą być wykorzystane przy analizie tekstów, ponieważ zbiór relacji w jakie
wchodzą ze sobą poszczególne elementy czy to słownika, czy też korpusu, jest olbrzymi. Wymagane w tym
wypadku wielokrotne złączenia tabel wprowadziłyby nieakceptowalny czas przetwarzania.

Zatem Rod pomyślany jest jako baza danych, w której dane nie ulegają zmianie (choć nie wyklucza się ich dodania
i uzupełnienie ich związków), a ich rozmiar wyklucza trzymanie w pamięci operacyjnej. Dodatkowe oczekiwania
obejmują szybki czas dostępu dla zindeksowanych danych (np. kilku milionów form wyrazowych), który jednak
nie wprowadza narzutu przy uruchomieniu bazy danych (wczytanie pełnego indeksu kilku milionów form zajmuje
co najmniej kilka sekund). Co więcej - wczytanie pojedynczej informacji (która zwykle jest elementem
dużego grafu zależności) nie powinno z jednej strony powodować wczytania wszystkich elementów powiązanych
(szybko okazałoby się, że wczytujemy bardzo dużo niepotrzebnych danych), a z drugiej - dzięki słabemu
wiązaniu, umożliwiać GC łatwe usuwanie danych z pamięci, nawet jeśli są one osiągalne z aktualnie
dostępnych zmiennych. Ten drugi wymóg dotyczy sytuacji, w której wczytano pewne dane, dokonano analizy
i dodatkowe informacje nie są już potrzebne, ale dalej rezydują w pamięci. Luźne wiązanie pozwala łatwo się
ich pozbyć.

Biblioteka Rod implementuje większość z tych funkcjonalności (obecnie jedynie uzupełnianie związków między
danymi nie jest wspierane). W niedalekiej przyszłości zamierzam wydać słownik języka polskiego oraz
narzędzie do tworzenia korpusów, które będzie oparte o tę bibliotekę. Z ciekawych własności słownika:
powinien on umożliwiać poprawne generowanie opisów dla błędów w formularzach, np.
"W formularzu jest 1 bł\*ąd\*/2 bł\*ędy\* 5 bł\*ędów\*", "Nazwa nie może być pusta", "Adres nie może być pusty"
oraz np. właściwe generowanie opisów typu: "Ania skomentowa\*ła\* twój status", "Wojtek skomentowa\*ł\* twój status".

Oczywiście wszystko będzie dostępne jako biblioteka Rubiego.
