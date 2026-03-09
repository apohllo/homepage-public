---
title: Użycie GCP do eksperymentów z GPU
date: '2024-11-18T13:16:00Z'
lastmod: '2024-12-10T10:58:34Z'
draft: false
author: 149.156.100.3
---

Konfiguracja instancji z GPU
----------------------------

Aby skorzystać z grantu Google dla edukacji w pierwszej kolejności musimy utworzyć nowy projekt i przypisać do niego otrzymany grant:

![](./gcp/gcp-1.png)

Po utworzeniu projektu powinniśmy zobaczyć następujące informacje na jego temat:

![](./gcp/gcp-2.png)

Konieczne jest wybranie tego projektu jako projektu, na którym aktualnie pracujemy (jest on dostępny w menu rozwijanym widocznym na obrazie).

Mając wybrany projekt, możemy przystąpić do tworzenia instancji. W menu głównym wybieramy "Compute Engine" oraz "VM instances" :

![](./gcp/gcp-3.png)

Konieczne jest aktywowanie usługi "Compute engine" przed przejściem do kolejnych kroków.

![](./gcp/gcp-4.png)

Po jej aktywowaniu, powinniśmy mieć możliwość tworzenia instancji (niebieski przycisk poniżej):

![](./gcp/gcp-5.png)

Zanim utworzymy instancję, wnioskujemy o zwiększenie limitu używania GPU, ponieważ domyślnie nie możemy
zaalokować żadnej instancji. Odpowiednie informacje znajdują się w sekcji IAM & Admin, zakładka "Quotas and system limits" :

![](./gcp/gcp-15.png)

W wyszukiwarce wpisujemy "gpus-all-regins-per-project" i wybieramy akcję "Edit quota" :

![](./gcp/gcp-20.png)

We wniosku krótko uzasadniamy dlaczego potrzebujemy dostępu do GPU:

![](./gcp/gcp-21.png)

**Proces zwiększania limitu zasobów może chwilę potrwać.**

Kiedy uzyskamy zwiększony limit możemy utworzyć instancję z GPU.

Wracamy do sekcji "Compute Engine API". Wybieramy instancję z GPU (np. N1) w wariancie `n1-standard-1`.

![](./gcp/gcp-6.png)

Dobrze jest zmienić dysk bootowalny, tak aby mieć podstawowe biblioteki już zainstalowane i skonfigurowane na maszynie:

![](./gcp/gcp-7.png)

Jeśli mamy problem z uzyskanie dostępu do GPU, możemy zmienić "Provisioning type" na **"Spot"**. Takie maszyny są znacznie
tańsze, ale niestety mają jedną zasadniczą wadę - mogą być w dowolnym momencie zatrzymane przez GCP.

![](./gcp/gcp-22.png)

Jeśli mamy te wszystkie informacje poprawnie skonfigurowane, możemy utworzyć instancję!

**Uwaga: Od momentu utworzenia instancji naliczane są opłaty, które pomniejszają nasz grant edukacyjny.**

Jeśli tworzenie instancji zakończy się sukcesem, w panelu powinniśmy zobaczyć jej zewnętrzny adres IP:

![](./gcp/gcp-8.png)

Niestety, może również pojawić się komunikat błędu, mówiący, że w danej lokalizacji nie ma dostępnych instancji z GPU. **Niestety jest to bardzo częsta sytuacja!**
Wtedy powinniśmy zmienić lokalizację, w której uruchamiamy naszą instancję.

Jeśli jednak proces zakończy się powodzeniem, musimy skonfigurować dostęp do instancji.

Trzeba odblokować port 8888. Wchodzimy do "VPS network" a następnie "Firewall".

![](./gcp/gcp-9.png)

I klikamy guzik [Create firewall rule]()

![](./gcp/gcp-10.png)

Następnie określamy parametry reguły - otwieramy port 8888. Ponieważ mamy tylko jedną instancję, możemy tę regułę aplikować do wszystkich instancji.
Możemy domyślnie dać dostęp z dowolnego miejsca (0.0.0.0/0), ale możemy też wskazać własny adres IP, co zwiększa bezpieczeństwo.

![](./gcp/gcp-11.png)

Następnie łączymy się z instancją. Możemy zrobić to wprost w przeglądarce klikając guzik "SSH" tutaj:

![](./gcp/gcp-8.png)

Po zalogowaniu na maszynę instalujemy niezbędne narzędzia, takie jak Jupyter notebook, `poetry`. Jest jednak prawdopodobne, że najpotrzebniejsze biblioteki będą już zainstalowane.

Uruchamiany jupyter lab i w logu odnajdujmy linijkę z informacją o tokenie:

![](./gcp/gcp-12.png)

Token ten wpisujemy przy logowaniu, które dostępne jest pod adresem publicznym naszej instancji:

![](./gcp/gcp-13.png)

**Na koniec pamiętamy, żeby zatrzymać uruchomioną instancję, klikając "stop"**:

![](./gcp/gcp-14.png)

Uwaga: wtedy przestają być naliczane opłaty za CPU/GPU, ale nadal naliczane są opłaty za zajętą przestrzeń dyskową. Optymalnie jest pobrać wytrenowany model na swój komputer,
żeby uniknąć tych opłat. Wtedy możemy kliknąć "delete" co powoduje również usunięcie dysku uruchomieniowego, na którym mieliśmy dane eksperymentalne.

Uruchomienie Jupyter Notebooka
------------------------------

Uruchomienie zadań z Podstaw Sztucznej Inteligencji wymaga pewnych dodatkowych działań w instancji.

W pierwszej kolejności pobieramy repozytorium z zadaniami:

```bash
$ git clone https://github.com/apohllo/sztuczna-inteligencja.git
```

Następnie zmieniamy wersję Pythona na 3.10 w pliku `pypoetry.toml` i wywołujemy komendy, instalacji pakietu Poetry, aktualizacji zależności i instalacji pakietów:

```bash
$ pip install poetry
$ poetry lock
$ poetry install --no-root
```

Teraz możemy uruchomić Jupyter Lab. Koniecznie musimy ustawić adres IP na 0.0.0.0, w przeciwnym razie nie będziemy mogli połączyć się z Jupiterem:

```bash
$ poetry run jupyter lab --ip 0.0.0.0
```
