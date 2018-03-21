# mgr-2

## Opis ogólny
Na potrzeby projektu stworzone zostały skrypty bash'owe 
pozwalające na szybkie uruchomienie badania/przetwarzania danych w tle.
Czas trwania badania może być długi, dlatego też stworzone zostały dodatkowe skryptu umożliwiające,
przerwanie ostatnio uruchomionego procesu.
Na potrzeby sprawdzenia statusu aktualnego badania w dodatkowym folderze ../log tworzony jest plik tekstowy
z logami procesu.

Dodane zostały również wersje skryptów odpalające się na konsoli (nie w tle).
Dzięki temu można szybko podejrzeć bieżące operację (i ewentualne błędy),  jak również szybko zatrzymać proces. Skrypty te mają sufix _cons.

## Wywołanie narzędzia do przeprowadzania badań

### Przykładowe wywołanie
+ ./main.sh test-1 ./params/bialystokParams.R
+ ./main_cons.sh test-1 ./params/bialystokParams.R

### Parametry
1. nazwa badania
2. ścieżka do skryptu z konfiguracjami

### Logowanie
+ ../log 'nazwa-badania'_'nazwa-zbioru-danych'.txt

### Wywołanie skryptu zatrzymujące ostatnie badanie
+ ./stop-main.sh

## Wywołanie narzędzia do sekwencyjnego uruchomienia wszystkich metod dla danego zbioru danych

### Przykładowe wywołanie
+ ./mainAll.sh test-1 ./params/bialystokParams.R
+ ./mainAll_cons.sh test-1 ./params/bialystokParams.R

### Parametry
1. nazwa badania
2. ścieżka do skryptu z konfiguracjami

### Skrypt z konfiguracjami
Jest to skrypt w którym tworzony jest obiekt inputParams <- InputParams(). Obiekt ten zawiera pola z danymi konfiguracyjnymi dla narzędzia.

### Logowanie
+ ../log 'nazwa-badania'_'nazwa-zbioru-danych'.txt
+ występuje dodatkowe logowanie błędów w poszczególnych metodach (jeżeli jedna się nie powiedzie skrypt przejdzie do kolejnej i zaloguje błąd w ../log/errors.out)
+ występuje również dodatkowe logowanie postępu (czyszczone przy każdym uruchomieniu) w pliku ../log/progress.out

### Wywołanie skryptu zatrzymujące ostatnie badanie
+ ./stop-main.sh

## Wywołanie narzedzia do przetwarzania danych wejściowych

### Przykładowe wywołanie
+ ./tool.sh poiDist bournemouth
+ ./tool.sh boundries bialystok
+ ./tool.sh poiDens bialystok 100
+ ./tool.sh auc norm-3

### Parametry
1. nazwa narzędzia (poiDist, poiDens, boundries)
2. nazwa zbioru danych/lub nazwa eksperymentu dla auc
3. długość promienia badania (wykorzystywane tylko w przetwarzaniu POI gęstościowego)

### Logowanie
+ ../log 'nazwa-narzędzia'_'nazwa-zbioru-danych'.txt

### Wywołanie skryptu zatrzymujące ostatnie badanie
+ ./stop-tool.sh

## Dane
Dane umieszczam w folderze ../data (relatywnie do miejsca umieszczenia skryptów głównych). Każdy zbiór danych powinien znajdować się w oddzielnym folderze z nazwą zbioru (można zmienić w const.R)
