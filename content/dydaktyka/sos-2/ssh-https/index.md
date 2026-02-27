---
title: Bezpieczne logowanie
date: '2011-02-28T12:38:00Z'
lastmod: '2014-05-19T11:31:59Z'
draft: false
tags:
- rsa
- https
author: 94.254.198.104
---

Laboratorium dotyczy konfiguracji sposobów bezpiecznego komunikowania się z serwerem w ramach protokołu
SSH oraz HTTPS.

Prerekwizyty:

-   migawka z zainstalowanym serwerem WWW
-   zapoznanie z dokumentacją ssh:
    -   [plik konfiguracyjny demona SSH](http://www.openbsd.org/cgi-bin/man.cgi?query=sshd_config&sektion=5&arch=&apropos=0&manpath=OpenBSD+Current)
    -   [open-ssh w Ubuntu](https://help.ubuntu.com/community/SSH/OpenSSH/Configuring)
-   zapoznanie z dokumentacją Apache dotyczącą HTTPS
    -   [dyrektywa SSLCertificateFile](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html#sslcertificatefile)
    -   [dyrektywa SSLCertificateKeyFile](http://httpd.apache.org/docs/2.2/mod/mod_ssl.html#sslcertificatekeyfile)
    -   [mod\_ssl w Ubuntu](https://help.ubuntu.com/12.04/serverguide/httpd.html#https-configuration)
-   znajomość pojęć: szyfrowanie symetryczne i asymetryczne, funkcja skrótu, SSH, klucz prywatny i publiczny, HTTPS, certyfikat SSL, Certification
    Authorities, WEP, WPA

Zadania do wykonania:

#### Zabezpieczenie protokołu SSH

-   wygenerowanie na maszynie hosta **pary kluczy RSA, chronionych hasłem "rsarsa"** służących do bezpiecznego komunikowania się w protokole SSH
-   **Uwaga! W praktyce hasło powinno być znacznie dłuższe i trudne do odgadnięcia!**
-   zalogowanie się na maszynę wirtualną w oknie terminala maszyny fizycznej
-   instalacja **klucza publicznego** na maszynie **wirtualnej**
-   zablokowanie możliwości logowania na maszynę **wirtualną** w sposób inny niż z wykorzystaniem klucza publicznego
-   dodanie na maszynie wirtualnej użytkownika **user1** z hasłem **user1**

#### Zabezpieczenie połączenia HTTPS

-   zalogowanie się na maszynę wirtualną w oknie terminala maszyny fizycznej
-   wygenerowanie **klucza szyfrującego** dla serwera WWW (server.key) z hasłem **"rsarsa"**
-   wygenerowanie **żądania** do centrum certyfikującego o **podpisanie klucza** (server.csr)
-   własnoręczne **wystawienie certyfikatu autentyczności** dla wygenerowanego żądania (server.crt)
-   **zainstalowanie klucza i certyfikatu** w serwerze WWW

Warunki powodzenia:

-   możliwość zalogowania się na maszynę **wirtualną** z wykorzystaniem infrastruktury klucza asymetrycznego i niemożność zalogowania się w inny sposób (testowane na koncie **user1**)
-   możliwość otwarcia dowolnej strony na serwerze WWW z wykorzystaniem protokołu **HTTPS**
