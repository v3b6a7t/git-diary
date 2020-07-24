# GitDiary (pamiętnik oparty na git)


**[PL]** GitDiary jest aplikacją umżliwiającą prowadzenie zapisków wykorzystując narzędzia `git` oraz skrypty `bash`. Jest on stworzony w celu ćwiczenia umiejętności zarządzaniem repozytoriami `git`. Filozofia działania aplikacji zawarta jest w pliku [diary/index.md](./diary/index.md).

**[EN]** GitDiary is an application that allows you to keep a diary using `git` tools and `bash` scripts. It was created to practice the ability to manage git repositories. The application's operating philosophy is contained in the [diary/index.md](./diary/index.md) file.




## Instalacja i konfiguracja


Instalacja aplikacji

```
./run install
```

Zmiana konfiguracji

```
./run config
```

* Aby wyłączyć testowanie, ustaw zmienną `APP_RUN_WITH_TEST` na 0.
* Aby określić główną gałąź `git`, wpisz jej nazwę do zmiennej `GIT_MASTER_BRANCH`.

## Zarządzanie kluczami ssh

Wygenerowanie i rejestracja klucza

```
./run ssh
```

Wyświetlenie klucza publicznego

```
./run ssh --show

```


## Zapisywanie zmian

Zapisanie z domyślnymi ustawieniami

```
./run save
```

Zapisanie z dodatkowymi opcjami

```
./run save diary --message "Informacja, która będzie zawarta w zatwierdzeniu"
```


## Wyświetlanie zatwierdzeń

Wyświetlanie z domyślnymi ustawieniami

```
./run show
```

Wyświetlanie z doatkowymi opcjami

```
./run show diary
./run show scripts
```

#### Konserwacja i oczyszczanie aplikacji

Usuwanie plików dziennika `diary`:

```
./run clean diary --data
```

Usuwanie i wyrejestrowanie kluczy ssh

```
./run clean --ssh
```

Usuwanie kluczy ssh oraz plików konfiguracyjnych

```
./run clean --hard
```

