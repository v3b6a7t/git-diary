# GitDiary (pamiętnik oparty na git)


**[PL]** GitDiary jest aplikacją umżliwiającą prowadzenie zapisków wykorzystując narzędzia `git` oraz skrypty `bash`. Jest on stworzony w celu ćwiczenia umiejętności zarządzaniem repozytoriami `git`. Filozofia działania aplikacji zawarta jest w pliku [diary/index.md](./diary/index.md).

**[EN]** GitDiary is an application that allows you to keep a diary using `git` tools and `bash` scripts. It was created to practice the ability to manage git repositories. The application's operating philosophy is contained in the [diary/index.md](./diary/index.md) file.




### Użycie

#### Konnfiguracja i instalacja

Konfiguracja:
```
./run config
```

Instalacja:
```
./run install
```

#### Wyświetlanie i tworzenie zatwierszeń 

Wyświetlenie zatwierdzeń `commits`:
```
./run show diary
./run show scripts
```

Stworzenie nowego zatwierdzenia:
```
./run save diary
./run save scripts
```

#### Konserwacja i oczyszczanie aplikacji

Usuwanie plików konfiguracyjnych:
```
./run clean
```

Usuwanie plików dziennika `diary`:
```
./run clean diary --force
```
