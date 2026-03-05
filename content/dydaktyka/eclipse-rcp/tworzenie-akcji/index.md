---
title: Tworzenie akcji
date: '2007-03-27T12:32:00Z'
lastmod: '2008-03-26T05:48:31Z'
draft: false
tags:
- eclipse
- rcp
- gui
description: rcp, eclipse, gui
author: 83.175.191.74
---

Jednym z podstawowych elementów każdej aplikacji, wykorzystującej
graficzny interfejs użytkownika, są różnego rodzaju akcje, wywoływane przez
użytkownika, na skutek kliknięcia pozycji w menu lub ikony na pasku narzędziowym.

W RCP występuje kilka rodzajów akcji:

-   **zwykłe** - występują w menu głównym i na pasku narzędziowym (**actionSets**)
-   **kontekstowe** - związane są z widokami (**viewerContribution**) oraz
    obiektami (**objectContribution**)
-   **a. widoków** - występują w menu i/lub na pasku widoku (**viewActionDelegate**)
-   **a. edytorów** - występują na pasku narzędziowym, gdy aktywny jest pewien typ edytora
    (**editorActionDelegate**)

Tworzenie ścieżek w menu i pasku narzędzi
=========================================

Aby tworzone akcje pojawiły w odpowiednim menu lub pasku narzędziowym,
trzeba określić ich położenie. Położenie akcji określa
się za pomocą **ścieżki dostępu**, która zazwyczaj składa się z dwóch elementów:

-   **menu**
-   **markera grupy**

Większość punktów rozszerzeń związanych z akcjami, oprócz tworzenia akcji, umożliwia
tworzenie ścieżek dostępu do akcji.
Jeśli tworzymy np. ścieżkę dla zbioru akcji (*actionSet*) musimy:

1.  W pliku **plugin.xml**, w zakładce **extensions**,
    w menu kontekstowym *rozszerzenia* (w tym wypadku *org.eclipse.ui.actionSet*) wybrać **new -&gt; menu**.
2.  Określić parametry menu, w szczególności jego **identyfikator** oraz **etykietę**.
    Jeśli parametr ścieżka (**path**) pozostanie pusty,
    to nowe menu pojawi się bezpośrednio w menu głównym.
3.  Kliknąć na *nowo dodanym menu* prawym klawiszem i wybrać z menu kontekstowego
    **new -&gt; groupMarker**.
4.  Określić **nazwę** nowo stworzonego *markera grupy*.

Jeśli będziemy chcieli dodać akcję do stworzonego menu, to jako jej ścieżkę
podajemy **identyfikatorMenu/nazwaGrupy**. Np. jeśli stworzyliśmy menu o identyfikatorze
**file**, a w nim grupę **save**, to ścieżka dostępu do tej grupy to **file/save**.

Akcje zwykłe (actionSet)
========================

Akcje zwykłe można dodawać do menu głównego lub paska narzędziowego.
Akcje tego rodzaju mogą być aktywowane domyślnie lub na życzenie użytkownika (poprzez
menu **Window -&gt; Customize perspective**) niezależnie od aktualnie wybranego widoku
lub edytora. W najczęstszych przypadkach, są to akcje w sposób ogólny związane z tworzonym pluginem, a nie z jakąś jego konkretną częścią.

Akcje tego rodzaju grupowane są w zbiory
(*actionSet*), które dostarczają pewien zbiór powiązanych ze sobą funkcjonalności.
Użytkownik może aktywować lub deaktywować tylko zbiory akcji, co pozwala na prostszą
kontrolę nad tym jakie akcje są dostępne dla użytkownika.

Aby stworzyć zbiór zwykłych akcji należy:

1.  W pliku **plugin.xml** w zakładce **extensions** dodać *punkt rozszerzeń* **org.eclipse.ui.actionSets**.
2.  Kliknąć na dodanym *punkcie rozszerzeń* prawym klawiszem i z menu kontekstowego
    wybrać **new -&gt; actionSet**.
3.  W dodanym *rozszerzeniu* określić jego identyfikator (**id**) oraz jego etykietę (**label**),
    która pojawi się w menu pozwalającym na aktywowanie/deaktywowanie danego zbioru akcji.
4.  Kliknąć na dodanym *rozszerzeniu* prawym klawiszem i w menu kontekstowym wybrać
    **new -&gt; action**.
5.  Określić własności akcji, w szczególności jej identyfikator (**id**), etykietę (**lable**)
    oraz klasę (**class**) implementującą interfejs **IWorkbenchWindowActionDelegate**
    lub **IWorkbenchWindowPulldownDelegate** (jeśli akcja ma pojawić się w pasku narzędziowym,
    jako element menu rozwijanego), która zawiera implementację akcji
    oraz ścieżki w menu głównym i pasku narzędzi, które określają położenie akcji.
    (Jeśli ścieżki takie jeszcze nie istnieją, należy je stworzyć.
    Patrz punkt: **Tworzenie ścieżek w menu i pasku narzędzi**.)
6.  Dwie ostatnie czynności należy powtórzyć dla wszystkich akcji, które mają znaleźć
    się w definiowanym zbiorze akcji.

![Przykładowe zwykłe akcje w pasku narzędziowym](/images/action_set.png "Przykładowe zwykłe akcje w pasku narzędziowym")

Akcje widoków (viewActions)
===========================

Akcje widoków są to akcje, które aktywują się w pasku narzędziowym lub menu danego
widoku (nie mylić z głównym menu aplikacji i głównym paskiem narzędziowym).
Mają one łatwy dostęp do tego widoku, dzięki czemu najlepiej nadają się
do implementowania pewnych funkcjonalności
związanych ze zmianą sposobu prezentacji danych
(np. filtrowanie wyświetlanych elementów).

Aby stworzyć akcje tego rodzaju należy:

1.  W pliku **plugin.xml** w zakładce **extensions** dodać *punkt rozszerzeń*
    **org.eclipse.ui.viewActions**.
2.  Kliknąć na dodanym *punkcie rozszerzeń* prawym klawiszem i z menu kontekstowego
    wybrać **new -&gt; view contribution**.
3.  W dodanym *rozszerzeniu* określić jego identyfikator (**id**) oraz identyfikator
    widoku, do którego mają zostać dodane tworzone akcje (**targetID**).
4.  Kliknąć na dodanym *rozszerzeniu* prawym klawiszem i w menu kontekstowym
    wybrać **new -&gt; action**.
5.  Określić własności akcji, w szczególności klasę (**class**) implementującą interfejs
    **IViewActionDelegate**, która będzie zawierała implementację akcji
    oraz ścieżki w menu i pasku narzędziowym tego widoku, które określają położenie akcji.
    (Jeśli ścieżki takie jeszcze nie istnieją, należy je stworzyć.
    Patrz punkt: **Tworzenie ścieżek w menu i pasku narzędzi**.
    Należy zwrócić uwagę, że tworzone ścieżki dotyczą tylko tego widoku, a nie
    głównego menu i głównego paska narzędzi.)
6.  Stworzyć **klasę**, o której mowa w poprzednim punkcie.

!/images/view\_actions.png(Przykładowe akcje w pasku widoku Schemat (Outline))!

Akcje edytorów (editorActions)
==============================

Akcje edytorów są to akcje, które aktywują się w pasku narzędziowym lub menu,
gdy aktywny jest pewien typ edytora. Mają one łatwy dostęp do aktualnie wybranego
edytora, dzięki czemu najlepiej nadają się do implementowania pewnych funkcjonalności
związanych z edycją (np. dodanie nowego elementu w edytowanym dokumencie).

Aby stworzyć akcje tego rodzaju należy:

1.  W pliku **plugin.xml** w zakładce **extensions** dodać *punkt rozszerzeń*
    **org.eclipse.ui.editorActions**.
2.  Kliknąć na dodanym *punkcie rozszerzeń* prawym klawiszem i z menu kontekstowego
    wybrać **new -&gt; editor contribution**.
3.  W dodanym *rozszerzeniu* określić jego identyfikator (**id**) oraz identyfikator
    edytora, do którego mają zostać dodane tworzone akcje (**targetID**).
4.  Kliknąć na dodanym *rozszerzeniu* prawym klawiszem i w menu kontekstowym
    wybrać **new -&gt; action**.
5.  Określić własności akcji, w szczególności klasę (**class**) implementującą interfejs
    **IEditorActionDelegate**, która będzie zawierała implementację akcji
    oraz ścieżki w menu głównym i pasku narzędzi, które określają położenie akcji.
    (Jeśli ścieżki takie jeszcze nie istnieją, należy je stworzyć.
    Patrz punkt: **Tworzenie ścieżek w menu i pasku narzędzi**.)
6.  Stworzyć **klasę**, o której mowa w poprzednim punkcie.

![Przykładowe akcje edytora plików źródłowych](/images/editor_actions.png "Przykładowe akcje edytora plików źródłowych")
