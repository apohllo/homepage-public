---
title: Skrypt dla Jupytera na Prometeuszu
date: '2019-09-30T09:56:42Z'
lastmod: '2019-09-30T09:56:42Z'
draft: false
author: 149.156.100.1
---

Ten wpis dotyczy konfiguracji Jupytera tak, żeby działał na Prometeuszu. Przy okazji środowisko jest tak skonfigurowane, że można używać GPU.

Jako alternatywę polecam użycie biblioteki [idact](https://pypi.org/project/idact/)

Ważne jest aby przed instalacją virutalneva załadować odpowiedni moduł Python, np.

```bash
unset PYTHONPATH
module load plgrid/tools/python/3.6.5
```

Następnie instalujemy [virtualenva](https://virtualenv.pypa.io/en/latest/) na Prometeuszu.
Najprościej zrobić to zgodnie z [instrukcją z dokumentacji Virtualnevna](https://virtualenv.pypa.io/en/latest/installation/)

Zakładamy, że virtualenv jest w katalogu `~/python3_6`. Aktywujemy go wywołaniem:

```bash
source ~/python3\_6/bin/activate
```

Instalujemy wszystkie potrzebne nam biblioteki, w szczególności Jupytera:

```bash
pip install jupyter-notebook
```

Generujemy również klucz, który pozwoli nam na logowanie się na Prometeusza z Prometeusza, bez podawania hasła.

Następnie tworzymy plik o nazwie `jupyter.sh` o następującej treści

```bash
unset PYTHONPATH
module load plgrid/apps/cuda/9.0
module load plgrid/libs/lapack/3.8.0
module load plgrid/libs/hdf5/1.10.1
module load plgrid/libs/openblas/0.2.19
module load plgrid/libs/atlas/3.10.3
module load plgrid/tools/gcc/8.1.0
module load plgrid/tools/python/3.6.5
module load plgrid/tools/java8/1.8.0\_60
export XDG\_RUNTIME\_DIR=~/xdg
export PORT=${1:-9000}
echo $PORT
source ~/python3\_6/bin/activate
~/python3\_6/bin/jupyter-notebook --no-browser --port=${PORT} notebooks &
sleep 10
ssh -N -R ${PORT}:localhost:${PORT} login01
```

Po uzyskaniu dostępu do węzła obliczeniowego plik ten pozwoli nam na pracę na Jupyterze na komputerze lokalnym, pod warunkiem, że zalogujemy się przekierowując port `9000`

```bash
ssh pro -L 9000:localhost:9000
```
