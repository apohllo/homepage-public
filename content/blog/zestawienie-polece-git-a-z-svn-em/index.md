---
title: ! 'Zestawienie poleceń: Git i SVN'
date: '2010-06-05T12:00:00Z'
lastmod: '2010-06-05T14:59:44Z'
draft: false
tags:
- svn
- git
author: 77.236.0.50
---

Yehuda Katz [opublikował](http://yehudakatz.com/2010/05/13/common-git-workflows/) artykuł, w którym pokazuje, jak
wygląd jego typowa sesja edycji kodu w kontekście Git-a. Cały artykuł warty jest przeczytania, natomiast
tabelka, która pojawia się na końcu zdecydowanie może służyć za ściągę z Gita, dla wcześniejszych
użytkowników SVN-a. Pozwalam ją sobie przerysować:

| Operacja                                       | git                                          | svn                                                                         |
|------------------------------------------------|----------------------------------------------|-----------------------------------------------------------------------------|
| Klonowanie repozytorium                        | `git clone git://github.com/rails/rails.git` | `svn checkout http://dev.rubyonrails.org/svn/rails/trunk`                   |
| Przygotowywanie zmian                          | `git add, git commit`                        | brak lub ręczne przygotowanie diff-a                                        |
| Ściąganie zmian z repozytorium                 | `git pull --rebase`                          | `svn up`                                                                    |
| Rozstrzyganie konfliktów                       | `git add, git rebase --continue`             | `svn resolve`                                                               |
| Rozstrzyganie konfliktów (bez --rebase)        | `git add, git commit`                        | brak                                                                        |
| Wycofywanie zmian (przygotowanych do wysłania) | `git reset --hard`                           | `svn up -rOLD` potem zaaplikowanie diff-a (jeśli pamiętałeś żeby go zrobić) |
| Publikowanie do repozytorium                   | `git push`                                   | `svn commit`                                                                |
