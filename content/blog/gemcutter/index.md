---
title: gemcutter
date: '2009-10-06T11:06:00Z'
lastmod: '2009-12-10T12:06:16Z'
draft: false
tags:
- ruby
- gem
- colors
- gemcutter
author: 213.134.160.231
---

Kiedy opublikowałem ostatniego newsa i chciałem upewnić się, czy faktycznie cyc-console jest dostępne
jako gem, ku mojemu zdziwieniu okazało się, że nie - charakterystyczna rubinowa ikona w Github, nie była aktywna.
Zatem szybko przeszedłem do panelu konfiguracji projektu i już chciałem włączyć obsługę gemów (a w głowie dyndała mi
myśl - czy rzeczywiście nie zrobiłem tego wcześniej), moje zdziwienie było jeszcze większe - w opcjach
nie znalazłem możliwości budowania gemów!

Github hostował co najmniej kilka spośród gemów, które wyprodukowałem (są to zazwyczaj nieduże projekciki,
które wykorzystuję w projektach z dziedziny NLP), choć w gruncie rzeczy niedawno doszedłem do wniosku,
że schemat nazewnictwa, który wykorzystują (nazwa\_uzytkownika-nazwa\_gemu) jest dosyć niewygodny. W
szczególności, jeśli chcemy w trakcie testów instalować gem lokalnie, a później go upublicznić przez gituhub,
to oba gemy mają odmienną nazwę. Kiedy mamy jakieś zależności pomiędzy takimi gemami, to sprawa jeszcze
bardziej się komplikuje, bo przy testowaniu gemów zależnych, trzeba by albo zmieniać nazwę zależności
(aby wybierany był gem lokalny), albo wrzucać na github gem o nowym numerze, co jest tym bardziej niewygodne,
bo trwa długo, a co gorsza, jest niezgodne z praktyką inżynierii oprogramowania, gdyż nieprzetestowany moduł
nie powinien być publikowany.

Ostatnio rozważałem nawet przejście na rubyforge, tylko po to, by przechowywać tam gotowe gemy, ale widać,
że ten serwis jest dosyć kiepsko konserwowany, dlatego odszedłem od tego pomysłu.

Kiedy teraz okazało się, że github nie hostuje gemów (przynajmniej nowych gemów), to informację tę przyjąłem
z pewną ulgą. Szukając jednak przyczyny stanu rzeczy, natknąłem się na [post](http://support.github.com/discussions/gems/197-rubygem-tickbox-no-longer-there), w którym znalazło się zalecane rozwiązanie tej problematycznej
sytuacji. Otóż twórcy githuba polecają serwis [gemcutter](http://gemcutter.org/).

Wygląda na to, że serwisy tworzone do realizacji jednego, specyficznego zadania stają się coraz
bardziej popularne (niedawno np. github nie miał zakładki "issues", która pozwala śledzić problemy związane z
hostowanym projektem, zalecany był np. Lighthouseapp) - innymi słowy: idea SOA faktycznie
zaczyna być realizowana, nie tylko w świecie javowym. Ale to temat na inny post.

Postanowiłem więc przetestować gemcuttera. Pierwsza rzecz, który musimy zrobić, aby zacząć go używać, to
oczywiście [zarejestrować się](http://gemcutter.org/sign_up). I już na tym etapie byłem nieco zdziwiony,
bo formularz rejestracyjny jest OLBRZYMI, choć zawiera tylko trzy pola :)

Po rejestracji powinniśmy zainstalować gem gemcutter, na lokalnej maszynie. Trzeba jednak wpierw upewnić
się, czy mamy rubygems w wersji co najmniej 1.3.3:

```bash
$ gem -v
1.3.1 \# myślałem, że mam najnowsze rubygems...
$ gem update --system
Updating RubyGems
Updating rubygems-update
Successfully installed rubygems-update-1.3.5
...
$ gem -v
1.3.5 \# uff
$ gem install gemcutter
...
```

Razem z gemem dostajemy nowe polecenia dla rubygems:

-   gem tumble - ustawia Gemcutter jako podstawowe źródło dla gemów (zamiast RubyForge)
-   gem push - wysyła gem na serwer Gemcutter
-   gem migrate - migruje gem wysłany wcześniej na RubyForge na Gemcutter
-   gem owner - włącza/wyłącza możliwość publikowanie przez innych twoich gemów

Z [dyskusji](http://www.rubyinside.com/gemcutter-a-fast-and-easy-approach-to-ruby-gem-hosting-2281.html#comment-39353),
która pojawiła się na Rubyinside, wynika, że oficjalny hosting gemów może zostać przeniesiony z RubyForge
na Gemcutter.

Ja w każdym razie zamierzać przetestować Gemcuttera - dzięki temu zarządzanie zależnościami między
gemami będzie takie, jak być powinno :)

Na pierwszy ogień wziąłem mój gem [colors](http://github.com/apohllo/colors).

```bash
$ gem build colors.gemspec
WARNING: no rubyforge\_project specified
Successfully built RubyGem
Name: colors
Version: 0.0.4
File: colors-0.0.4.gem
$ gem push colors-0.0.4.gem
Enter your Gemcutter credentials. Don't have an account yet? Create one at http://gemcutter.org/sign\_up
Email: apohllo@o2.pl
Password:
Signed in. Your api key has been stored in ~/.gemrc
Pushing gem to Gemcutter...
Successfully registered gem: colors (0.0.4)
```

Mając w pamięci doświadczenia z githubem, gdzie po wrzuceniu gemu do repo, jego zbudowanie i pojawienie się
w repo trwało kilkanaście minut, a często wiązało się z modyfikacją manifestu (brakujące pliki, etc.)
**bardzo miło zaskoczył mnie fakt**, że w wynik wyszukiwania na stronie gemcutter
dla terminu "colors" od razu zwrócił mój gem!

Postanowiłem więc sprawdzić, czy faktycznie jest widoczny przez rubygems:

```bash
$ sudo gem install colors
ERROR: could not find gem colors locally or in a repository
$ sudo gem tumble
Thanks for using Gemcutter!
Your gem sources are now:
- http://gemcutter.org
- http://gems.rubyforge.org/
- http://gems.github.com
$ sudo gem install colors
Successfully installed colors-0.0.4
1 gem installed
Installing ri documentation for colors-0.0.4...
Installing RDoc documentation for colors-0.0.4...
$ irb
&gt;&gt; require 'colors'
=&gt; true
&gt;&gt; puts "abc".hl
**abc** \#wyboldowane :)
```

Zatem działa! Biorąc pod uwagę fakt, że wszystko (łącznie z tym postem), zajęło mi mniej niż
godzinę, zamierzam używać Gemcuttera!
