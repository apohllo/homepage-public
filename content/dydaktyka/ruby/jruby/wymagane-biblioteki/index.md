---
title: Wymagane biblioteki
date: '2007-04-08T18:00:00Z'
lastmod: '2007-05-03T08:56:52Z'
draft: false
tags:
- java
- jruby
- bsf
description: jruby, bsf, java
author: 213.134.160.228
---

W internecie można spotkać wiele przykładów na wykorzystanie Javy w Rubim, z wykorzystaniem
[JRubiego](http://jruby.codehaus.org/). Znacznie trudniej jest jednak natknąć się
na jakiś fragment kodu, w którym byłoby zaprezentowane wykorzystanie rubiego z
poziomu Java.

W Javie 5.0 można to zrobić za pomocą [BSF (Beans Scripting Framework)](http://jakarta.apache.org/bsf/). W portalu [javaworld](http://www.javaworld.com/)
udało mi się znaleźć [przykład](http://www.javaworld.com/javaworld/jw-07-2006/jw-0717-ruby.html),
ilustrujący użycie rubiego w javie. Niestety, autorzy przykładu nie wspomnieli, że
oprócz bibliotek *jruby.jar* oraz *bsf.jar* do jego uruchomienia potrzebna jest biblioteka
[**asm.jar**](http://asm.objectweb.org).

Wydawać się może - rzecz oczywista, jeśli przyjrzymy się stacktracowi.
Tak jest w istocie. Ktoś może jednak, tak jak ja, spróbować użyć jrubiego w
metodzie *main* i zadeklarować, że rzuca ona wyjątek BSFException, a wtedy nie
zobaczy żadnej informacji o niespełnionych zależnościach (vide: asm.jar), a
jedynie niewiele mówiący komunikat:

<code>
Exception in thread "main" org.apache.bsf.BSFException: unable to load language: ruby
</code>
