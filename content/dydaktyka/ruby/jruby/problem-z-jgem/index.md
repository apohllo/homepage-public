---
title: Problem z jgem
date: '2007-04-14T17:22:00Z'
lastmod: '2007-05-03T08:58:09Z'
draft: false
tags:
- java
- ruby
- jruby
- gem
- gentoo
description: ruby, jruby, java, gem, gentoo
author: 213.134.160.228
---

Kolejny problem, na jaki można natrafić rozpoczynając przygodę z JRuby, to
**brak wystarczających zasobów pamięciowych** przy próbie zainstalowania nowego gema, np.:

<code>CODEBLOCK\_PLACEHOLDER\_1</code>

Rozwiązanie polega na zwiększeniu maksymalnego dostępnego obszaru stosu. W Javie można
to zrobić poprzez opcję -Xmx. W Gentoo, które używam na co dzień, sprowadza się to
do edycji pliku <code>/usr/bin/jruby:

CODEBLOCK\_PLACEHOLDER\_2</code>

Dodanie opcji <code>-Xmx256m</code> na końcu listy argumentów Javy
(<code>gjl\_java\_args</code>) pozwoliło na bezproblemowe zainstalowanie wymaganego gema.
