## Zmiany w aplikacji


| DATA | TREŚĆ |
| --- | --- |
| 15.07.2020 | Dodano podstawowy skrypt instalacyjny `scripts/install.sh`. |
| 13.07.2020 | Wprowadzono konfigurację `scripts/config.sh` aplikacji umożliwiającą, w razie potrzeby, inicjację git oraz utworzenie pierwszego zatwierdzenia w głównej gałęzi. Dodano plik `.gitignore` oraz `git ls-files --exclude-from=.gitignore` do skryptu `scripts/show.sh`. |
| 13.07.2020 | Ujednolicono nazwy funkcji w ./scripts/util/display.sh oraz zmieniono sposób wyświetlania w ./scripts/show.sh wprowadzając flagę `grep --max-count`. |
