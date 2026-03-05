---
title: Flex
date: '2008-05-07T14:35:00Z'
lastmod: '2008-05-07T17:27:40Z'
draft: false
tags:
- regex
- flex
author: 83.175.191.74
---

**Flex** to program służący do generowania skanerów, czyli programów dokonujących
leksykalnej analizy plików zawierających tekst napisane w językach
sztucznych, w szczególności językach programowani (C, Java, Python, Ruby, itp.)
oraz językach reprezentacji danych (XML, YAML, itp.).

Skanery zamieniają jednolity tekst pliku na ciąg **tokenów**, które następnie
mogą zostać przekazane do parsera odpowiedniego języka. Proces zamiany tekstu
na tokeny jest zazwyczaj znacznie prostszy niż jego parsowanie, gdyż struktura tokenów zazwyczaj może być opisana z wykorzystaniem gramatyk regularnych, których jedną z reprezentacji są wyrażenia regularne.

Flex na podstawie wyrażeń regularnych odpowiadających poszczególnym tokenom,
może wykonywać pewne akcje. Mogą one obejmować np. wypisanie tokenu na standardowe wyjście, bądź przekazanie go parserowi.

Pełniejszy opis fleksa znajduje się w jego [podręczniku systemowym](http://man.przez.net/flex.1.html)

Przykładowe zadania
-------------------

1.  Zdefiniować program, który zamienia wszelkie wystąpienia słowa "abc" na "abecadło"
2.  Zdefiniować program, który dokonuje analizy syntaktycznej wyrażeń matematycznych. Powinien on odróżniać:
    1.  liczby całkowite 124
    2.  liczby rzeczywiste 123.34
    3.  operatory arytmetyczne + -
    4.  nawiasy () {} \[\]
    5.  relacje &lt; &lt;= &gt;= = !=
    6.  zmienne a b abc123

3.  Zdefiniować program, który dokonuje podstawowej syntaktycznej wybranego, uproszczonego języka programowania
4.  Zdefiniować program, dokonujący analizy syntaktycznej plików XML

[Więcej informacji nt fleksa](http://home.agh.edu.pl/~mkuta/automaty_fizyka/automaty_fizyka.html)
