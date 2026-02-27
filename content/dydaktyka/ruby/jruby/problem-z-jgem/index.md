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

<code>

    # jgem install ActiveRecord-JDBC
    Bulk updating Gem source index for: http://gems.rubyforge.org
    Exception in thread "main" java.lang.OutOfMemoryError: Java heap space

</code>

Rozwiązanie polega na zwiększeniu maksymalnego dostępnego obszaru stosu. W Javie można
to zrobić poprzez opcję -Xmx. W Gentoo, które używam na co dzień, sprowadza się to
do edycji pliku <code>/usr/bin/jruby:

    #!/bin/bash
    gjl_package=jruby
    gjl_main="org.jruby.Main"
    gjl_java_args="-Djruby.base=/usr/share/jruby -Djruby.home=/usr/share/jruby -Djru
    by.lib=/usr/share/jruby/lib -Djruby.script=jruby -Djruby.shell=/bin/sh -Xmx256m"
    source /usr/share/java-config-2/launcher/launcher.bash

</code>

Dodanie opcji <code>-Xmx256m</code> na końcu listy argumentów Javy
(<code>gjl\_java\_args</code>) pozwoliło na bezproblemowe zainstalowanie wymaganego gema.
