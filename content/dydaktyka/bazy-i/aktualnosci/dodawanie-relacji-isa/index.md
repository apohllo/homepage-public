---
title: Dodawanie relacji isa
date: '2009-03-29T04:56:00Z'
lastmod: '2009-03-29T08:43:17Z'
draft: false
tags:
- dydaktyka
- db
- erd
- dia
- isa
description: db, erd, dia, isa, dydaktyka
author: 193.138.140.10
---

Aby dodać relację *isa* do programu **Dia** należy wykonać następujące kroki:

1.  Pobrać [plik](/images/erd/isa.shape) zawierający symbol relacji isa i zachować na dysku w łatwo dostępnym miejscu.
2.  W programie Dia w boczny panelu wybrać z menu pozycję **Plik -&gt; Arkusze i obiekty...**.
3.  W pojawiającym się oknie dialogowym po lewej stronie odnaleźć zestaw symboli **ER**
    (po jego wybraniu w panelu poniżej pola wyboru powinny pojawić się symbol zbioru encji,
    atrybutu, związku, etc.).
4.  Kliknąć przyciska **Nowy** znajdujący się w lewym dolnym rogu okienka dialogowego.
5.  W nowootwartym oknie dialogowym zaznaczyć opcję **Kształt SVG** (jest ona domyślnie wybrana)
    i po kliknięci przycisku **Przeglądaj**, odnaleźć zapisany na dysku **plik**, zawierający
    symbol relacji isa.
6.  Kliknąć przycisk **OK**, co powinno spowodować zamknięcie okienka dialogowego **Dodaj**.
7.  W okienku dialogowym **Arkusze i obiekty** kliknąć przycisk **Zastosuj** a potem **Zamknij**.

W wyniku tych operacji w zbiorze symboli ER powinien pojawić się nowy symbol reprezentowany
za pomocą niebieskiej litery C, na tle czerwonego trójkąta (jest to skrót od Custom -
symbol użytkownika).

Jeśli w trakcie wykonywania powyższych operacji pojawią się jakieś problemy,
należy je zignorować. Jeśli natomiast powyższa operacja spowoduje zamknięcie aplikacji,
można spróbować powtórzyć procedurę :) Jeśli i to się nie powiedzie, można jako symbolu
relacji *isa* użyć zwykłego trójkąta, stworzonego za pomocą standardowego narzędzia **Wielokąt**.
