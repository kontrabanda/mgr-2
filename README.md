# mgr-2

## Opis ogólny
Na potrzeby projektu stworzone zostały skrypty bash'owe 
pozwalające na szybkie uruchomienie badania/przetwarzania danych w tle.
Czas trwania badania może być długi, dlatego też stworzone zostały dodatkowe skryptu umożliwiające,
przerwanie ostatnio uruchomionego procesu.
Na potrzeby sprawdzenia statusu aktualnego badania w dodatkowym folderze ../log tworzony jest plik tekstowy
z logami procesu.

## Wywołanie narzędzia do przeprowadzania badań

### Przykładowe wywołanie
+ ./main.sh test-1 bialystok_norm knn 6 2010
+ ./main.sh test-2 bournemouth_poi_dist svm 6 2016
+ ./main.sh test-3 bialystok_poi_dens svm 3 2010

### Parametry
1. nazwa badania
2. nazwa zbioru danych
3. nazwa metody
4. liczba miesięcy w przedziale cross-validacji
5. rok do którego dane traktujemy jako zbiorór testowy

### Logowanie
+ ../log 'nazwa-badania'_'nazwa-zbioru-danych'.txt

### Wywołanie skryptu zatrzymujące ostatnie badanie
+ ./stop-main.sh

## Wywołanie narzedzia do przetwarzania danych wejściowych

### Przykładowe wywołanie
+ ./tool.sh poiDist bournemouth
+ ./tool.sh boundries bialystok
+ ./tool.sh poiDens bialystok 100

### Parametry
1. nazwa narzędzia (poiDist, poiDens, boundries)
2. nazwa zbioru danych
3. długość promienia badania (wykorzystywane tylko w przetwarzaniu POI gęstościowego)

### Logowanie
+ ../log 'nazwa-narzędzia'_'nazwa-zbioru-danych'.txt

### Wywołanie skryptu zatrzymujące ostatnie badanie
+ ./stop-tool.sh

## Dane
Dane umieszczam w folderze ../data (relatywnie do miejsca umieszczenia skryptów głównych). Każdy zbiór danych powinien znajdować się w oddzielnym folderze z nazwą zbioru (można zmienić w const.R)
