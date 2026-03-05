---
title: Instalacja Rubiego 1.9.3 w Ubuntu
date: '2011-08-09T07:51:00Z'
lastmod: '2015-04-16T16:39:30Z'
draft: false
tags:
- ruby
- ubuntu
- rvm
author: 149.156.173.53
---

Prosta instrukcja, jak zainstalować najnowszą wersję Rubiego (1.9.3-p0) w systemie Ubuntu (testowane z 11.04).

1. Najpierw instalujemy niezbędne pakiety za pomocą apt-get-a (m.in. Ruby w wersji 1.8):

code(bash).
$ sudo apt-get install zlib1g-dev libssl-dev libreadline-dev libxml2-dev libsqlite3-dev
$ sudo apt-get install ruby curl git-core libyaml-dev

2. Następnie ściągamy i instalujemy [Ruby Version Manager](https://rvm.beginrescueend.com/) (w skrócie RVM):

code(bash).
$ curl -L get.rvm.io | bash -s stable

3. Wczytujemy nową konfigurację shella

code(bash).
$ source /home/user/.profile

4. Testujemy działanie RVM:

code(bash).
$ rvm help

    [![Build Status](https://secure.travis-ci.org/mpapis/rvm.png)](http://travis-ci.org/mpapis/rvm)
    = rvm
    * http://github.com/wayneeseguin/rvm
    == DESCRIPTION:
    ...

Jeśli nie widzimy powyższych komunikatów, znaczy to, że instalacja się nie powiodła! Należy przeczytać uważnie komunikat i sprawdzić co jest nie tak.

6. Instalujemy najnowszą stabilną wersję Rubiego:

code(bash).
$ rvm install 1.9.3
Installing Ruby from source...

Instalacja trwa kilka minut, ponieważ w jej trakcie kompilowany jest Ruby.

7. Na koniec ustawiamy Rubiego 1.9.3 jako domyślny interpreter używany w systemie:

code(bash).
$ rvm use 1.9.3 --default
Using /home/user/.rvm/gems/ruby-1.9.3-p0

8. Weryfikujemy powyższe wydając polecenie:

code(bash).
$ ruby -v
ruby 1.9.3p0 (2011-10-30 revision 33570) \[i686-linux\]

9. Teraz możemy otworzyć konsolę `irb` i ostatecznie potwierdzić, że mamy najnowszą wersję Rubiego:

code(bash).
$ irb
ruby-1.9.3-p0 :001 &gt; "abc".encoding
=&gt; \#&lt;Encoding:UTF-8&gt;
