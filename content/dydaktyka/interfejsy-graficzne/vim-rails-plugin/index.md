---
title: Vim Rails plugin
date: '2010-10-13T03:50:00Z'
lastmod: '2011-12-19T11:56:19Z'
draft: false
tags:
- rails
- vim
author: 149.156.173.53
---

Dobrym dodatkiem do Vima jest zestaw pluginów, które ułatwiają pracę z Railsami.

code.
cp -r /home/pracow/pohl/vim ~/.vim
cp /home/pracow/pohl/vim\_rc ~/.vimrc

Po instalacji dostępnych będzie kilka przydatnych komend:

-   :NERDTree (po otwarciu vim-a) - powoduje wyświetlenie drzewa katalogów i plików (przykład poniżej)
-   gf (np. w kontrolerze na akcji, w widoku na "partialu", itp.) - przejście do stowarzyszonego pliku (widoku dla akcji, partialu, itp.)
-   :R&lt;enter&gt; - przejście do stowarzyszonego pliku (np. dla widoku jest to kontroler)
-   :A&lt;enter&gt; - przejście do alternatywnego pliku (np. dla widoku jest to helper)
-   &lt;ctrl&gt;+f - szybkie wyszukiwanie pliku
-   % - przeskakuje pomiędzy nawiasami, elementami HTML-a, if - end, itp.
-   &lt;shift&gt;+v - zaznaczanie linii
-   = - wyrównywanie kodu
-   y - kopiowanie zaznaczenia
-   p - wstawianie zaznaczenia

W powyższych komendach + oznacza, że klawisze wciskamy jednocześnie. Brak plusa oznacza, że klawisze wciskamy po kolei.

![](/images/vim_tree.jpg)
