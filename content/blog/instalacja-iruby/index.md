---
title: Instalacja IRuby
date: '2015-10-23T12:27:00Z'
lastmod: '2017-07-26T20:43:24Z'
draft: false
author: 94.254.152.186
---

Aby zainstalować IRubiego oraz Ruby on Rails w najnowszych wersjach należy wykonać następujące polecenia (testowane na
Ubuntu w wersji serwerowej 16.10):

```bash
$ sudo apt-get install zlib1g-dev libssl-dev libxml2-dev libsqlite3-dev libev-dev
$ sudo apt-get install ruby curl git-core libyaml-dev libgcrypt11-dev libgmp-dev
$ sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev libreadline6-dev
$ sudo apt-get install python3-dev libzmq3-dev python-dev python-pip
$ sudo pip install 'ipython\[notebook\]' markupsafe zmq certifi jsonschema jupyter\_console
$ curl https://rvm.io/mpapis.asc | gpg -~~import~~
$ curl -L get.rvm.io | bash -s stable
$ source ~/.rvm/scripts/rvm
$ rvm install 2.4.1
$ rvm use 2.4.1 --default
$ gem install iruby rails
```

Weryfikacja poprawności instalacji może być przeprowadzona poprzez wywołanie polecenia:

```bash
$ iruby notebook
```

**Uwaga!**

Jeśli w trakcie instalacji IRubiego pojawi się komunikat:

```
autogen.sh: error: could not find libtool.
```

Należy wykonać następujące polecenie:

```bash
$ sudo ln -s /usr/bin/libtoolize /usr/bin/libtool
```

A następnie ponownie wywołać polecenie

```bash
$ gem install iruby rails
```
