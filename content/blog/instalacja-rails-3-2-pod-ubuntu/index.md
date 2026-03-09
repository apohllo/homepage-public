---
title: Instalacja Rails 3.2 pod Ubuntu
date: '2012-02-05T13:55:00Z'
lastmod: '2012-02-08T17:17:21Z'
draft: false
tags:
- ruby
- rails
- ubuntu
author: 149.156.173.53
---

Instrukcja instalacji Ruby on Rails w wersji 3.2.2 pod Ubuntu (testowane w wersji 11.04)

1. Instalacja Rubiego w wersji 1.9.3

Postępujemy zgodnie z [instrukcją instalacji Rubiego](/blog/instalacja-rubiego-1-9-3-w-ubuntu)

2. Instalacja Railsów w wersji 3.2.2

W konsoli wpisujemy poleceni instalacji Railsów `gem install rails`:

```bash
$ gem install rails
Fetching: i18n-0.6.0.gem (100%)
Fetching: multi\_json-1.0.4.gem (100%)
Fetching: activesupport-3.2.1.gem (100%)
Fetching: builder-3.0.0.gem (100%)
Fetching: activemodel-3.2.1.gem (100%)
Fetching: rack-1.4.1.gem (100%)
Fetching: rack-cache-1.1.gem (100%)
Fetching: rack-test-0.6.1.gem (100%)
Fetching: journey-1.0.1.gem (100%)
Fetching: hike-1.2.1.gem (100%)
Fetching: tilt-1.3.3.gem (100%)
...
```

Na początku wydaje się, że polecenie zamarło, ale trzeba trochę odczekać.
Jeśli wynik jest inny niż powyższy, należy dokładnie przeczytać komunikat błędu.

3. Instalacja biblioteki TheRubyRacer

Wbrew pozorom pomimo instalacji wielu zależności, konfiguracja Railsów nie jest jeszcze skończona.
Ze względu na dodanie w wersji 3.1 [asset pipline](http://guides.rubyonrails.org/asset_pipeline.html) konieczne jest jeszcze doinstalowanie
biblioteki pozwalającej na uruchamianie Javascriptu po stronie serwera. Istnieje kilka opcji,
ale instalacja gemu `therubyracer` powinna przebiegać bez problemów:

```bash
$ gem install therubyracer
```

4. Wygenerowanie przykładowej aplikacji

Po instalacji gemu therubyracer możemy wygenerować nową aplikację:

```bash
$ rails new library
create
create README.rdoc
create Rakefile
create config.ru
create .gitignore
create Gemfile
create app
create app/assets/images/rails.png
create app/assets/javascripts/application.js
create app/assets/stylesheets/application.css
create app/controllers/application\_controller.rb
create app/helpers/application\_helper.rb
create app/mailers
create app/models
...
```

5. Konfiguracja aplikacji

Pomimo tego, że aplikacja została wygenerowana pomyślnie konieczne jest jeszcze wskazanie biblioteki
używanej do obsługi Javascriptu. W tym celu w pliku **Gemfile** w katalogu głównym aplikacji musimy dodać następującą linijkę

```ruby
gem "therubyracer"
```

Następnie wywołujemy komendę **bundle** w katalogu aplikacji:

```bash
$ cd library
$ bundle
Using rake (0.9.2.2)
Using i18n (0.6.0)
Using multi\_json (1.0.4)
Using activesupport (3.2.1)
Using builder (3.0.0)
Using activemodel (3.2.1)
Using erubis (2.7.0)
Using journey (1.0.1)
Using rack (1.4.1)
...
```

5. Dodanie przykładowej funkcjonalności

Na koniec możemy wygenerować przykładowy scaffold, żeby czy wszystko działa jak należy:

```bash
$ rails g scaffold author name:string surname:string
invoke active\_record
create db/migrate/20120205195252\_create\_authors.rb
create app/models/author.rb
invoke test\_unit
create test/unit/author\_test.rb
create test/fixtures/authors.yml
route resources :authors
...
$ rake db:migrate
  CreateAuthors: migrating 
-- create\_table(:authors)
-&gt; 0.0011s
  CreateAuthors: migrated (0.0012s) ===
$ rails s
=&gt; Booting WEBrick
=&gt; Rails 3.2.1 application starting in development on http://0.0.0.0:3000
=&gt; Call with -d to detach
=&gt; Ctrl-C to shutdown server
\[2012-02-05 20:54:10\] INFO WEBrick 1.3.1
\[2012-02-05 20:54:10\] INFO ruby 1.9.3 (2011-10-30) \[i686-linux\]
\[2012-02-05 20:54:10\] INFO WEBrick::HTTPServer\#start: pid=21730 port=3000
```

Jeśli w przeglądarce wejdziemy po adres `http://localhost:3000/authors` powinniśmy zobaczyć następującą treść:

![widok scaffoldu authors](/images/authors.png "widok scaffoldu authors")
