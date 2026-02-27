---
title: RVM + Passenger
date: '2012-08-25T16:22:56Z'
lastmod: '2012-08-25T16:22:56Z'
draft: false
tags:
- ruby
- passenger
- rvm
author: 145.97.199.104
---

Kilka uwag przy korzystaniu z kombinacji RVM + Passenger:

1.  Sprawdź czy w pliku konfiguracyjnym passengera (np. /etc/apache2/mods-enabled/rails.load) używana jest
    ta sama wersja Rubiego co w konsoli. Jeśli Passenger informuje, że **brakuje jakiegoś gema**, a `bundle install`
    przebiegło bez problemu, to prawdopodobną przyczyną jest właśnie inna wersja Rubiego (i inny gemset) dla RVM oraz
    Passengera.
2.  Przy instalacji Passengera upewnij się, że `rvm use ruby... --default` było wywołane przez użytkownika
    uprzywilejowanego. Niestety użycie tego samego wywołania przez innego użytkownika spowoduje błędy.
3.  Więcej informacji na [ten temat](https://groups.google.com/forum/?fromgroups=#!topic/phusion-passenger/SKUX7bzl3GQ)
