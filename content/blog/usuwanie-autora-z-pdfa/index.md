---
title: Usuwanie autora z PDFa
date: '2017-08-01T11:25:50Z'
lastmod: '2017-08-01T11:25:50Z'
draft: false
author: 149.156.100.33
---

Na podstawie:

https://askubuntu.com/questions/27381/how-to-edit-pdf-metadata-from-command-line

1. Instalujemy exiftools:

code(shell).
$ sudo apt-get install exiftool

2. Wywołujemy komendę:

code(shell).
$ exiftool -Author="" plik.pdf

Szczególnie przydatne dla wszystkich osób, które prowadzą proces redakcyjny, z założeniem, że dane autora nie powinny przedostać się do recenzentów (blind review).
