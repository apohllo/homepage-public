---
title: Schemat opisu eksperymentów ML
date: '2021-11-10T16:53:00Z'
lastmod: '2023-08-09T14:27:53Z'
draft: false
author: 149.156.100.12
---

Prowadząc badania naukowe w dziedzinie NLP, czy ML, pojawia się problem, polegający na tym, że po jakimś czasie nie do końca wiemy, jak dokładnie przeprowadziliśmy dany eksperyment.
Karol Lasocki, który obecnie pracuje dla Amazonu, wspomniał o fiszce, wykorzystywanej do dokumentowania eksperymentów. Ten pomysł bardzo mi się spodobał.
Poniżej prezentuję schemat fiszki, który wypracowałem w ramach eksperymentów prowadzonych między innymi w konkursie \[PolEval\](http://poleval.pl/).

### Kod eksperymentu

Np. **qa-1** - kod eksperymentu to również nazwa katalogu z danymi eksperymentu. Dzięki temu można bardzo łatwo zidentyfikować, gdzie znajdują się wyniki eksperymentu, jego dane oraz użyty model.

Ten kod powinien być unikalny, żeby później można było łatwo odnaleźć dokładnie ten eksperyment, wśród wielu podobnych eksperymentów. Nie do końca dobrym pomysłem jest
używanie ponownie kodu eksperymentu, który zakończył się niepowodzeniam. W szczególności jest to zły pomysł, jeśli używamy jakiegoś narzędzia to monitorowania
przebiegu eksperymentów, np. [Neptune.AI](https://app.neptune.ai/), które automatycznie nadaje numery eksperymentom. Lepiej jest usunąć po prostu taki eksperyment z
dashboardu, niż wykonywać dodatkową pracę, związaną z przepisywaniem numeru eksperymentu.

Pewnym problemem może być wymuszenie zasady, że identyfikator eksperymentu ma być taki sam jak nazwa katalogu z wynikami eksperymentu. Jeśli nie korzystamy z narzędzia
do monitorowania eksperymentu (choć zdecydowanie warto to zrobić), to po prostu identyfikator eksperymentu jest taki sam, jak argument `output_dir`.
Jeśli wykorzystujemy narzędzie do monitorowania, to najlepiej odczytać nazwę katalogu z sesji eksperymentu.

Korzystając z Huggingface Transofmers oraz Neptune.AI można to zrobić następująco:

```
import neptune
from transformers.integrations import NeptuneCallback
run = neptune.init\_run()
print(f"Neptune RUN ID: {run.\_id}")
neptune\_callback = NeptuneCallback(run=run)
training\_args.report\_to = \[\]
training\_args.output\_dir += f"/{run.\_id}"
trainer = Trainer(...,callbacks=\[neptune\_callback\])
```

### Cel eksperymentu

Po co przeprowadzamy ten eksperyment. Najlepiej, żeby eksperyment dotyczył jednej hipotezy, którą chcemy zweryfikować.

Jeśli nie zapiszemy sobie informacji, co chcieliśmy sprawdzić w ramach danego eksperymentu, to po jakimś czasie może nam
być bardzo trudno to stwierdzić. Oczywiście możemy automatycznie porównywać eksperymenty na różne sposoby i w ten sposób wybrać ten, który dał najlepsze rezultaty.
Ale te rezultaty nie zależą wyłącznie od hiperparametrów treningu - bardzo ważnym aspektem są przecież **dane**. Jeśli zatem nie zapiszemy sobie, że np. wprowadziliśmy
jakąś zmianę w danych (oczywiście powinno to skutkować również dodaniem odpowiedniego numeru wersji do datasetu, ale nie zawsze o tym pamiętamy), to po 1 czy 2 miesiącach
będzie bardzo trudno odzyskać tego typu wiedzę.

W moim przekonaniu, obok identyfikatora eksperymentu jest to **najważniejszy element opisu eksperymentu**. Możemy pominąć wszystkie pozostałe informacje, ale jeśli
pominiemy tę, to eksperyment będzie miał bardzo małą wartość.

### Wnioski z eksperymentu

Krótkie (2-3 zdania) podsumowanie eksperymentu. Powinno odpowiadać, na pytanie postawione w hipotezie eksperymentu.

Można tutaj również spisać inne wnioski, które pojawiły się "przy okazji" eksperymentu. Np. rozwiązania problemów związanych z kodem, itp.
Ważne aby wnioski były bardzo krótkie - jeśli będziesz później analizował np. 20 eksperymentów, to przydałoby się przeczytać same wnioski, żeby wyciągnąć jakieś
ogólne konkluzje dotyczące tej grupy eksperymentów. Jeśli natomiast będzie to akapit tekstu, to przejrzenie tych wniosków zajmie sporo czasu, dlatego warto zadbać o ich zwięzłość.

Jeśli przerywasz eksperyment, ponieważ widzisz, że nie ma szans powodzenia, to również warto dodać taką adnotację we wnioskach.

### Wyniki eksperymentu

Szczegółowa tabelka z wynikami eksperymentu, dla poszczególnych checkpointów. Najlepiej raportować tutaj wyniki ze zbioru ewaluacyjnego oraz ewentualnie ze zbioru testowego.

Można również ograniczyć się do najlepszych wyników dla wybranych metryk. W każdym razie sekcja ta nie powinna być pusta, nawet pomimo tego, że narzędzia
do śledzenia eksperymentów automatycznie rejestrują te informacje (do tego przecież służą). Fakt umieszczenia choćby krótkiej informacji o wynikach
pozwala wyciągnąć szersze wnioski, bez konieczności przełączania się pomiędzy opisem eksperymentu, a wynikami w narzędziach do monitorowania eksperymentów,
co znacząco przyspiesza końcową analizę wyników.

### Skrypt treningu

Jest to jedna z najważniejszych pozycji w schemacie. Zamieszczenie dokładnego wywołania skryptu trenującego umożliwia łatwe powtórzenie eksperymentu.
Ma to szczególne znaczenie w przypadku skryptów, które posiadają szereg parametrów.
Pomaga też ustalić np. że zbiór danych treningowych, który był wykorzystywany w danym eksperymencie, jest identyczny jak zbiór danych w innym eksperymencie.

### Skrypt predykcji

Skrypt wykorzystany do wykonania predykcji na danych testowych. Analogicznie jak skrypt powyżej, pozwala ustalić wszystkie istotne parametry wykorzystane do predykcji.

### Napotkane problemy

Jakie problemy pojawiły się przy treningu modelu. Jak je rozwiązano.

Jeśli w trakcie przygotowywania eksperymentu, pojawiły się jakieś problemy, np. biblioteka rzuciła błąd, to warto odnotować ten fakt oraz zanotować jak rozwiązano dany błąd.
Czy zmieniono wersję biblioteki? Czy poprawiono coś w danych źródłowych? Czy wprowadzono jakieś modyfikacje w kodzie?
Jeśli są to oczywiste poprawki, typu przekroczenie zakresu, to nie ma sensu tego notować. Ale jeśli jest to jakiś głębszy problem, np. model uczy się dużo gorzej,
to warto odnotować taki problem. A jeśli udało się go rozwiązać, to tym bardziej warto odnotować to rozwiązanie. Może się ono bardzo przydać za jakiś czas.

\*\*Poniższe metadane są opcjonalne. Wykorzystanie narzędzi do śledzenia eksperymentów pozwala na automatyczne archiwizowanie tych informacji. Można jednak
dodać odpowiednie tagi do eksperymentu, które pozwalają na szybkie filtrowanie wyników względem tych parametrów.****

### Użyty model

Jaka była architektura sieci neuronowej. Jeśli używamy modeli pretrenowanych, to jaki dokładnie był to model - optymalnie, żeby był to identyfikator z repozytorium Huggingface Models.

To pole nie jest wymagane, jeśli używamy narzędzia do śledzenia eksperymentów. Można jednak dodać tag dla tego eksperymentu, który wskazuje na użyty model. Pozwala to później
szybko porównywać wyniki eksperymentów przeprowadzonych z tym samym modelem.

### Użyte dane wejściowe

Jakie dane wejściowe zostały wykorzystane do treningu, a jakie do testowania. Jeśli są to dane ogólnie dostępne, to oczywiście identyfikator z HF. Jeśli są to dane autorskie, to
dobrze, żeby było odniesienie do ich lokalizacji lub jednoznaczny identyfikator.

Analogicznie jak w przypadku modelu - użycie narzędzia do śledzenia eksperymentów pozwala uniknąć każdorazowego notowania użytego dataset. Warto jednak dodać tag do eksperymentu,
który wskazuje na użyty zbiór danych.

### Użyte parametry

W dobrych skryptach MLowych parametry wypisywane są na początku eksperymentu. Warto wykorzystać te dane i je tutaj zamieścić.

Tak jak w przypadku dwóch wcześniejszych parametrów - użycie narzędzia do śledzenia zwalnia nas z tego zadania. Obecnie metadane związane z parametrami treningu
są automatycznie rejestrowane przez narzędzia typu Neptune.AI.

### Kod źródłowy

Wskazanie repozytorium, z którego korzystamy w eksperymencie.
Opcjonalne może to być link do konkretnego commita.

Tutaj też nastąpił postęp od czasu, kiedy przygotowana była pierwsza wersja tego posta. Narzędzia do śledzenia eksperymentów automatycznie rejestrują
informacje dotyczące repozytorium. Co więcej, rejestrują one również informacje o niezakomitowanych zmianach. Dzięki temu znacznie łatwiej jest odtworzyć
eksperyment po jakimś czasie.

### Model wynikowy

Lokalizacja modelu wynikowego, jeśli miałby się znajdować gdzieś indziej, niż w katalogu dedykowanym dla eksperymentu.

Najlepiej jednak w tym zakresie stosować schemat: identyfikator eksperymentu == lokalizacja modelu. Wtedy nie ma problemu ze zidentyfikowaniem modelu lub grupy modeli,
które powstały w ramach danego eksperymentu
