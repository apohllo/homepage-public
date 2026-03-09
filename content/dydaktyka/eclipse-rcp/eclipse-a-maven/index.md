---
title: Eclipse a Maven
date: '2008-05-16T03:37:00Z'
lastmod: '2008-08-12T05:37:47Z'
draft: false
tags:
- java
- eclipse
- maven
author: 83.230.47.20
---

Uwaga

Informacje na tej stronie mogą być nieco nieaktualne (w szczególności w kontekście
najnowszej wersji Eclipse 3.4 aka Ganymede).
Bardziej aktualne informacje znajdują się [w prezentacji przedstawionej na EclipseCon 2008](http://www.eclipsecon.org/2008/?page=sub/&id=72)

[Eclipse](http://www.eclipse.org) jako platforma tworzenia
oprogramowania w Javie (Eclipse RCP),
pozwala na tworzenie skomplikowanych i wydajnych aplikacji
integrujących się (dzięki wykorzystaniu biblioteki SWT)
z naturalnym interfejsem graficznym różnych systemów
operacyjnych, takich jak Mac OS, Linux czy Windows.

Bogactwo rozszerzeń (tzw. wtyczek) tworzonych dla Eclipsa, sprawia również,
że rozwiązanie nawet skomplikowanych problemów (np. tworzenie graficznego edytora),
może być znacząco uproszczone.

Z drugiej strony [Maven](http://maven.apache.org) uchodzi za standardowe
narzędzie służące do obsługi procesu wytwarzania oprogramowania w Javie.
Jego moc objawia się przede wszystkim w dużych projektach, składających
się z wielu modułów, które posiadają skomplikowane zależności. Pozwala
on znacząco uprościć takie zadania jak kompilowanie, testowanie czy
tworzenie raportów, nawet dla bardzo rozbudowanych projektów.

Zatem kiedy tworzymy duży projekt oparty o Eclipse RCP, naturalnym wydaje
się wykorzystanie Mavena do zarządzania jego produkcją. Tym niemniej,
pomimo istnienia kilku narzędzi pozwalających na integrację Eclipse-a z
Mavenem, doprowadzenie ich do harmonijnej współpracy nie jest proste.

W tym artykule postaramy się przedstawić te narzędzia oraz pokażemy
jak można je wykorzystać aby współpraca Mavena z Eclipsem zakończyła się
sukcesem.

maven-eclipse-plugin
--------------------

[maven-eclipse-plugin](http://maven.apache.org/plugins/maven-eclipse-plugin/)
to plugin dla Mavena, który ma na celu uproszczenie tworzenia projektów
w środowisku Eclipse.

Wśród najważniejszych zadań przezeń realizowanych można wymienić:

-   **`eclipse:eclipse`** - generowanie struktury projektu eclipsowego na podstawie pliku `pom.xml` (w szczególności: wygenerowanie plików .project oraz .classpath):
-   **`eclipse:m2eclipse`** - jw. z uwzględnieniem pluginu m2eclipse (patrz niżej)
-   **`eclipse:to-maven`** - przekształcenie środowiska pracy Eclipse (w szczególności zainstalowanych w nim pluginów) w repozytorium Mavena (powoduje wygenerowanie odpowiednich plików `pom.xml` i umieszczenie ich w lokalnym lub zdalnym repozytorium)

### eclipse:to-maven

Przeniesienie pluginów lokalnej instalacji do repozytorium Mavena jest
pierwszym krokiem na drodze do pełnej integracji Mavena z Eclipsem.

W zasadzie krok ten może być pominięty, ponieważ w centralnym repozotorium
Mavena znajdują się odpowiednie pakiety odpowiadające pakietom eclipsowym,
tym niemniej nie są one najbardziej aktualne. Co więcej - wykorzystanie
identycznych wersji pakietów jak w lokalnej instalacji Eclipse zabezpiecza
nad przed błędami, które mogły wystąpić w ich starszych wersjach znajdujących
się w centralnym repozytorium.

Zadanie to można wykonać wywołując poniższą komendę:

code.
mvn eclipse:to-maven -DeclipseDir=/opt/eclipse \\
-DdeployTo=repository\_id::default::scp://mydomain.com/path/to/maven/repository \\
-DstripQualifier=true

Wywołanie to posiada więcej opcji, ale najistotniejsze są trzy wymienione
powyżej:

-   **`eclipseDir`** - katalog, w którym znajduje się lokalna instalacja Eclipse-a
-   **`deployTo`** - deskryptor repozytorium, w którym mają pojawić się wygenerowane pliki. Składa się z trzech elementów oddzielonych podwójnymi dwukropkami:
    -   **identyfikator repozytorium** (repository\_id) - pozwala na wykorzystanie informacji dot. autentykacji, zawartej w pliku `settings.xml`
    -   **układ repozytorium** (default)
    -   **adres repozytorium** (scp://mydomain.com/...) - zawiera metodę dystrybuowania plików, nazwę domeny oraz pełną ścieżkę do repozytorium Mavena.
-   **`stripQualifier`** - ustawienie na `true` powoduje usunięcie z wersji pluginów dodatkowego identyfikatora. Ma to niezwykle istotne znaczenie, ponieważ **sposób numerowania wersji w Mavenie oraz Eclipse jest zasadniczo odmienny**.

Po wywołaniu polecenia może się pojawić błąd `java.util.NoSuchElementException`, który najwyraźniej występuje przy próbie przeniesienia komercyjnych plugiów.

Rozwiązaniem jest usunięcie tych pluginów (z katalogu `eclipse/plugins`) w czasie wykonywania powyższego zadania. Po jego zakończeniu można je przenieść z powrotem.

Nexus indexer
-------------

Repozytorium utworzone w poprzednim kroku, choć może być wykorzystywane
w zwykłych projektach opartych o Mavena, nie jest jeszcze dostępne
z poziomu Eclipse-a, gdyż plugin m2eclipse korzysta z indeksera repozytorium
o nazwie [Nexus](http://docs.codehaus.org/display/M2ECLIPSE/Nexus+Indexer)

Repozytorium musi być zatem wyposażone w indeks utworzony z wykorzystaniem
Nexusa. Jest on dystrybuowany w postaci jara dostępnego pod adresem
<http://nexus.sonatype.org/downloads/>
(plik zawierający w nazwie **cli(Command Line Interface)**).

Po ściągnięciu nexusa możemy utworzyć indeks wywołując następujące polecenie:

code.
java -jar nexus-indexer-1.0.0-beta-2-cli.jar -o -z -t full -i index -n my-repo -r /path/to/maven/repository

Znaczenie poszczególnych opcji jest następujące:

-   ~~o~~ powoduje nadpisanie aktualnego indeksu
-   ~~z~~ indeks zostanie spakowany jako archiwum zip
-   ~~t~~ typ indeksu (full, minimal)
-   ~~i~~ katalog w którym zostaną umieszczone tymczasowe pliki indeksu
-   ~~n~~ identyfikator repozytorium
-   ~~r~~ ścieżka do repozytorium

W wyniku wywołania tego polecenia, w katalogu lokalnym zostaną stworzone dwa pliki: `nexus-maven-repository-index.properties`, `nexus-maven-repository-index.zip`

Muszą one zostać przeniesione do katalogu `.index` utworzonego w korzeniu
repozytorium. Dzięki temu zawartość repozytorium będzie "widoczna" z
poziomu Eclipse-a.

pde-maven-plugin
----------------

[pde-maven-plugin](http://mojo.codehaus.org/pde-maven-plugin/) to plugin dla
Mavena, który pozwala budować eclipsowe pluginy, feature-y oraz produkty
z jego wykorzystaniem.

m2eclipse
---------

[m2eclipse](http://m2eclipse.codehaus.org/) to plugin dla Eclipse-a, który pozwala
z jego poziomu wywoływać zadania Mavena, dodawać do projektu zależności i wtyczki,
itp.
