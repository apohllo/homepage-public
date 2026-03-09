---
title: Eksperymenty NLP w PLGrid
date: '2022-08-02T10:38:00Z'
lastmod: '2025-01-10T15:40:18Z'
draft: false
author: 185.172.85.145
---

Wstęp
-----

W ramach prac magisterskich, a także inżynierskich związanych z przetwarzaniem języka naturalnego (NLP), studenci często potrzebują dostępu do komputerów wyposażonych w kart GPU.
Jedną z możliwości jest uruchomienie tych eksperymentów w środowiskach chmurowych, np. Google Colab lub Amazon Sagemaker. Niemniej wykorzystanie tych narzędzi, w szczególności darmowej
wersji Colab-a, wiąże się z szeregiem ograniczeń.

Na AGH mamy jednak jednostkę, która posiada rosnącą liczbę superkomputerów, wyposażonych w karty GPU oraz bardzo dużą przestrzeń dyskową. W Cyfronecie zainstalowane są systemy:

-   Prometheus: 32 karty V100,
-   Ares: 72 karty V100,
-   Athena: 384 karty A100.
-   Helios: 440 karty GH200

PLGrid
------

### Rejestracja

Wykorzystanie tych komputerów wymaga jednak uzyskania dostępu oraz właściwej konfiguracji środowiska uruchomieniowego.
Proces rozpoczynamy od rejestracji swojego konta w [PLGrid](http://portal.plgrid.pl) .
W ramach procesu rejestracyjnego musimy wskazać swojego opiekuna naukowego, który umożliwi nam dostęp do infrastruktury PLGrid.
Po rejestracji oczekujemy na potwierdzenie, że opiekun zaakceptował nasze zgłoszenie.

### Dostęp do wybranego superkomputera

Następnym krokiem w procedurze jest uzyskanie dostęp do wybranego superkomputera. Krok ten wymaga, abyśmy mieli dostęp do grantu na obliczenia na tym superkomputerze.
Występowanie o grant zazwyczaj odbywa się za pośrednictwem opiekuna. Zwykle opiekunowie mają już granty, do których mogą dołączyć kolejne osoby.

O dostęp do wybranego superkomputera aplikujemy w zakładce [usługi]() szukamy w niej nazwy np. *Dostęp do klastra Ares w ośrodku Cyfronet*:

![](./images/services-pl-grid.png)

Dodanie dostępu nie odbywa się jednak w tym miejscu - konieczne jest kliknięcie zielonego guzika "Zarządzaj usługami". Jego kliknięcie powoduje przejście do innej aplikacji
powiązanej z systemem PLGrid.

**Uwaga**: w systemie zarządzania usługami występuje błąd, związany z niepoprawnym działaniem usługi OpenID. W przypadku jego występowania (komunikat "Błąd serwera") należy
skontaktować się ze wsparciem po stronie PLGrid (odnośnik *Helpdesk* w menu górnym na głównej stronie portalu).

Praca na serwerze
-----------------

### Maszyny dostępowe i obliczeniowe

Po uzyskaniu dostępu do wybranego serwera (Prometheus, Ares, Athena), można się na niego zalogować za pomocą SSH, np. do serwera Ares można się połączyć wpisując:

```bash
$ ssh &lt;mojlogin&gt;@ares.cyfronet.pl
```

Oczywiście `<mojlogin>` zamieniamy na nasz login w systemie PLGrid.

Po zalogowaniu się na serwer musimy uświadomić sobie, że jesteśmy zalogowanie na maszynie dostępowej. Będzie się to objawiało następującym komunikatem w linii poleceń

```bash
$ &lt;mojlogin&gt;@login01:~/
```

Czyli maszyna, na której się znajdujemy nazywa się np. `login01`.

**Uwaga**: na maszynach dostępowych nigdy nie uruchamiamy żadnych zadań, angażujących zasoby obliczeniowe!
Dotyczy to również zadań typu instalowanie bibliotek Pythona, czy kompilacja kodu. Tego rodzaju działania należy wykonywać wyłącznie na węzłach obliczeniowych.

### Zabezpieczenie sesji pracy

Czynności wykonywane na maszynie dostępowej oraz na węzłach obliczeniowych warto zabezpieczyć przed przypadkowym zerwaniem dostępu do internetu.
W tym celu można wykorzystać narzędzie [screen](https://linuxize.com/post/how-to-use-linux-screen/) lub [tmux](https://www.howtogeek.com/671422/how-to-use-tmux-on-linux-and-why-its-better-than-screen/)

Tutaj przedstawimy tylko najważniejsze polecenia tmux-a:

-   `tmux` - uruchomienie sesji tmux-a. Wylogowanie, bądź zerwanie połączenia internetowego nie przerywa sesji tmux-a,
-   `tmux a` - połączenie się do wcześniej utworzonej sesji tmux-a.

Polecenia, które wykonujemy w trakcie korzystania z tmux-a:

-   `ctrl+b d` - opuszczenie sesji tmux-a, bez jej kończenia (umożliwia rozłączenie się z serwerem),
-   `ctrl+b c` - utworzenie nowej zakładki/ekranu,
-   `ctrl+b n/p` - przełączenie się do następnej/poprzedniej zakładki.

Ten zbiór poleceń stanowi pewne minimum, które pozwala na efektywną pracę ze zdalną sesją obliczeniową. W internecie można znaleźć szereg dalszych informacji, które pozwalają na
wykonywanie bardziej zaawansowanych czynności (np. przeglądanie wyników wcześniej wykonanych poleceń).

### Uruchamianie zadań

Zadania na superkomputerze są uruchamiane z wykorzystaniem systemu kolejkowego. Najważniejsze polecenia to:

-   `srun` - praca na węźle w trybie interaktywnym
-   `sbatch` - praca na wężle w trybie batchowym

Zazwyczaj na etapie prototypowania lepiej pracować w trybie interaktywnym. Mamy wtedy możliwość pracy tak, jakbyśmy robili to na zwykłym komputerze wyposażonym w Linuksa,
z tą różnicą, że mamy dostęp do karty GPU i bardzo dużych zasobów dyskowych.

Jeśli jednak potrzebujemy uruchomić wiele eksperymentów, a wiemy już że nasze skrypty działają poprawie, możemy wykorzystać w tym celu drugie polecenie.

Przykładowe uruchomienie sesji wygląda następująco:

```bash
$ srun -A plgnlp-gpu -p plgrid-gpu-v100 --gres=gpu:1 -N 1 -n 1 --ntasks-per-node=1 --mem=32GB -t 24:00:00 --pty /bin/bash -l
```

Dla komputera Athena, polecenie jest następujące (dochodzi nazwa kolejki do nazwy grantu):

```bash
$ srun -A plgexaile2-gpu-a100 -p plgrid-gpu-a100 --gres=gpu:1 -N 1 -n 1 --ntasks-per-node=1 --mem=64GB -t 24:00:00 --pty /bin/bash -l
```

Dla komputera Helios, polecenie jest następujące:

```bash
$ srun -A plgexaile2-gpu-gh200 -p plgrid-gpu-gh200 --gres=gpu:1 -N 1 -n 1 --ntasks-per-node=1 --mem=64GB -t 24:00:00 --pty /bin/bash -l
```

gdzie:

-   `-A` - nazwa grantu, określana przez opiekuna,
-   `-p` - nazwa kolejki, dostęp do kart V100 na Aresie wymaga podania kolejki jw.,
-   `--gres=gpu:1` - zarezerwowanie dostępu do specjalnych zasobów, w tym wypadku jednej karty GPU,
-   `-N` - liczba węzłów, na których uruchamiane jest zadanie,
-   `-n` - liczba rdzeni (dla całego zadania), które zostaną udostępnione,
-   `--ntasks-per-node` - liczba rdzeni na pojedynczym węźle (w zasadzie może być pominięte),
-   `--mem` - ilość pamięci RAM dla każdego węzła obliczeniowego,
-   `-t` - maksymalny czas uruchomienia zadania (24h są maksymalną wartością dla tej kolejki),
-   `--pty` - powłoka, która zostanie uruchomiona po połączeniu się z węzłem.

Uruchomienie polecenia nie zawsze powoduje natychmiastowe uzyskanie dostępu do węzła. Jeśli czekamy długo, możemy spróbować zmniejszyć jeden lub wiele parametrów.
Zwykle uruchamianie na jednym węźle, z jedną kartą GPU jest jednak dość szybko realizowane. Jeśli jednak czekamy długo, możemy wpisać:

```bash
$ squeue
```

Spowoduje ono wyświetlenie wszystkich uruchomionych zadań w ramach grantów, do których mamy dostęp.

### Zasoby dyskowe

Superkomputery wyposażone są w klastry dyskowe o bardzo dużej pojemności (liczonej w petabajtach). Dlatego realizując eksperymenty nie musimy za bardzo przejmować się tą kwestią.
Trzeba jednak wiedzieć, że przetrzeń dyskowa w naszym katalogu domowym jest niewielka - np. 10GB.

Dane eksperymentalne muszą być przechowywane na SCRATCHu, czyli dysku wyposażonym w szybkie połączenia z węzłami. W ramach grantu obliczeniowego mamy na nim limit 1000GB.
W teorii SCRATCH jest czyszczony co 30 dni, ale realnie zdaża się to bardzo rzadko. Dlatego spokojnie możemy przechowywać na nim dane.

Katalog SCRATCH dostępny jest w zmiennej `$SCRATCH`, ale warto zrobić sobie dowiązanie symboliczne do tego katalogu, w swoim katalogu domowym. Istotnie upraszcza to pracę.
Kod źródłowy (jako najcennieszy zasób), warto jednak trzymać w katalogu domowym oraz w repozytorium, np. Gicie. Żeby ułatwić sobie dostęp do scratcha z poziomu katalogu z kodem,
możemy zrobić sobie również dowiązanie symboliczne z katalogu np. `output` do odpowiadającego mu katalogu na SCRATCHu.

### Uruchamianie modułów

Standardowo po uzyskaniu dostępu do węzła obliczeniowego mamy dostęp do niewielkiej liczby modułów softwareowych, takich jak kompilator czy interpreter języka.
Dlatego zazwyczaj, w celu uzyskania powtarzalności eksperymentów, ładujemy programistyczne "moduły", które dają nam dostęp do narzędzi w ściśle określonych wersjach.

Dla eksperymentów NLP na Aresie polecane jest załadowanie i instalację następujących modułów:

```bash
$ module load python/3.9.6-gcccore-11.2.0
$ module load cuda/11.6.0
$ module load cudnn/8.4.1.50-cuda-11.6.0
$ pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
```

Poza tym warto zrobić sobie środowisko virtualenv, aby móc instalować własne biblioteki pythonowe. Pamiętemy zatem żeby po każdym zalogowaniu na węzeł aktywować to środowisko, np.:

```bash
$ source ~/scratch/python-3.8.6/bin/activate
```

Po wprowadzeniu tych poleceń możemy już uruchamiać swoje programy napisane w Pythonie, z dokładnie określonym zestawem bibliotek.

Powodzenia!
