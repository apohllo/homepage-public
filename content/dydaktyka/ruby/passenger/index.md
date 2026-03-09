---
title: Passenger
date: '2008-11-09T05:58:00Z'
lastmod: '2009-03-08T18:34:08Z'
draft: false
tags:
- ruby
- rails
- passenger
author: 193.138.140.10
---

Wstęp
-----

\*[Passenger](http://www.modrails.com/*) (znany również jako mod\_passenger, Phusion Passenger, mod\_rails)
jest modułem dla Apache, który znacząco upraszcza wdrażanie
Railsów na serwerach produkcyjnych.
Dzięki niemu można zupełnie zapomnieć o konfigurowaniu i zarządzaniu wieloma instancjami Mongrela,
przydzielaniu dla nich portów, etc.

Dzięki Passnegerowi odpalenie Railsów w środowisku produkcyjnym jest niemal tak samo proste jak
odpalenie aplikacji napisanej w PHP. Ma to szczególne znaczenie dla osób, które dopiero zaczynają
swoją przygodę z RoR (co staje się jeszcze prostsze dzięki domyślnemu wykorzystaniu Sqlite'a),
a także dla osób, które zarządzają serwerami, na których odpalanych jest
wiele aplikacji tego rodzaju.

Odpowiednio skonfigurowany Passenger sam zawiaduje tworzeniem i usuwaniem instancji Railsów,
w zależności od obciążenia serwera, posiada również wbudowany load-balancer.

Instalacja i konfiguracja modułu Passenger w Gentoo
---------------------------------------------------

Poniżej przedstawiona jest konfiguracja modułu Passenger w Gentoo. W innych dystrybucjach
można skorzystać ze [sposobu opisanego na stronie projektu](http://www.modrails.com/install.html)

W Gentoo wystarczy wpisać:

```
emerge -va passenger
```

Następnie musimy włączyć obsługę modułu w serwerze Apache. Konieczna jest
edycja pliku **/etc/conf.d/apache2**. Modyfikujemy zmienną **APACHE2\_OPTS**, tak by zawierała
opcję **PASSENGER**:

```
APACHE2\_OPTS="-D INFO ... -D PASSENGER"
```

Na koniec restartujemy serwer:

```
/etc/init.d/apache2 restart
```

Jeśli jakiś **DocumentRoot** w konfiguracji Apache wskazuje na katalog `public` railsowego
projektu, to wywołanie stowarzyszonego z nim adresu spowoduje jego uruchomienie.
Dzieje się tak, gdyż w domyślnej konfiguracji Passengera ustawiona jest opcja
automatycznego wykrywania aplikacji tego rodzaju. Jeśli chcemy ją zmodyfikować lub
dostroić inne opcje (np. maksymalną ilość instancji aplikacji, itp). edytujemy plik
**/etc/apache2/modules.d/30\_mod\_passenger.conf**.

Przykładowo, jeśli chcemy zwiększyć maksymalną liczbę instancji do 30 (domyślnie 20),
modyfikujemy parametr **PassengerMaxPoolSize**. Oczywiście zmiany tego rodzaju będą widoczne
po zrestartowaniu Apache.

Zarządzanie Passangerem
-----------------------

Passenger pozwala na łatwe zarządzanie projektami, które zostały uruchomione z jego
użyciem.
Aby zrestartować jakąś aplikację (np. w celu uwzględnienia zmian w kodzie źródłowym)
wystarczy stworzyć plik **restart.txt** w katalogu **tmp** aplikacji, która ma być zrestartowana.

Ponadto w systemie instalowanych jest kilka poleceń pozwalających na monitorowanie stanu
naszych aplikacji. **passenger-status** wyświetla informację o uruchominych aplikacjach
a także liczbie ich instancji; **passenger-memory-stats** wyświetla szczegółowe informacje
o pamięci zużywanej przez poszczególne aplikacje; **passenger-stress-test** pozwala zaś
obserwować jak nasza aplikacja zachowuje się przy większym obciążeniu.

Co więcej - jeśli Passenger wykryje jakieś błędy w konfiguracji (np. aplikacja napisana
została z użyciem Railsów w wersji 1.2.3, a nie są one zainstalowane na serwerze),
informacja o nich pojawia się przy próbie odwołania się do jej adresu. Co więcej -
pojawia się również informacja jak rozwiązać dany problem (we wspomnianym przypadku
była to prośba wykonanie polecenia `sudo gem install rails --version 1.2.3`).

Podsumowanie
------------

Użycie modułu Passanger znacznie upraszcza uruchamianie i zarządzanie wieloma aplikacjami
napisanymi w frameworku Ruby on Rails. Co więcej - wraz z Passengerem można zainstalować
tzw. **Ruby Enterprise Edition**, który pozwala znacząco zredukować ilość zajętej pamięci.

Na początku roku 2009 będę dysponował informacjami o tym, jak zachowuje się Passenger
w środowisku, w którym modułu ten zarządza kilkudziesięcioma niezależnymi aplikacjami.
Postaram się je opublikować, gdyż pozwolą odpowiedzieć na pytanie, czy jego wykorzystanie
nie prowadzi do problemów związanych z wydajnością i stabilnością systemu.
