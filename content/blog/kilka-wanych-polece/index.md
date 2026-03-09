---
title: Kilka ważnych poleceń
date: '2011-08-09T12:01:00Z'
lastmod: '2011-08-09T12:09:42Z'
draft: false
tags:
- linux
- debian
- ubuntu
author: 91.150.223.28
---

Jest kilka poleceń i ustawień w Linuksie, które wprowadzam raz na rzadki czas, a po tym czasie zapominam i szukam ich wciąż na nowo.

GPG error - Debian/Ubuntu
-------------------------

Pobranie klucza GPG z serwera i dodanie go do apt-get-a:

code(bash).
$ sudo gpg --keyserver subkeys.pgp.net --recv 7D2C7A23BF810CD5
$ sudo gpg --export -~~armor 7D2C7A23BF810CD5 | sudo apt-key add~~

PgUp/PgDown w historii poleceń
------------------------------

W Debianie/Ubuntu wystarczy w pliku `/etc/inputrc` odkomentować linijki (w Gentoo standardowo włączone):

code.
[\\e\[A]() history-search-backward
[\\e\[B]() history-search-forward

Kolory znak zachęty z gitem
---------------------------

Dzięki poniższym poleceniom, znak zachęty w Linuksie jest kolorowy oraz posiada dodatkowe informacje dla katalogów zawierających repozytorium Git.
Należy wrzucić do `~/.bash_profile`

code.
parse\_git\_branch ()
{
if git rev-parse --git-dir &gt;/dev/null 2&gt;&1
then
gitver="\[$(git branch 2&gt;/dev/null| sed -n '/^\\**/s/^\\** //p')\]"
else
return 0
fi
echo -e $gitver
}
branch\_color ()
{
if git rev-parse --git-dir &gt;/dev/null 2&gt;&1
then
color=""
if git diff --quiet 2&gt;/dev/null &gt;&2
then
color='\\033\[01;32m'
else
color='\\033\[01;31m'
fi
else
return 0
fi
echo -ne $color
}
PS1='\\\[\\033\[01;32m\\\]\\u@\\h\\\[\\033\[01;34m\\\] \\w\\\[$(branch\_color)\\\]$(parse\_git\_branch) \\\[\\033\[01;34m\\\]\\$\\\[\\033\[00m\\\] '
