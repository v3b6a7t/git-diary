## Zmiany w aplikacji


| DATA | TREŚĆ |
| --- | --- |
| 15.07.2020 | Dodano podstawowy skrypt instalacyjny `scripts/install.sh` ([#ce5bfdb](https://github.com/v3b6a7t/git-diary/commit/ce5bfdba4342096bb8c9a444c055cd896b9e0109#diff-80423f13d45b53af35790ffc6009be4d)) oraz czyszczący `scripts/clean.sh` ([#26b9646](https://github.com/v3b6a7t/git-diary/commit/26b964622b4b6a6c96db4afdcaaa7ed873ed3fe8#diff-bd64fd12861923c5811624099c73f523)) |
| 13.07.2020 | Wprowadzono konfigurację `scripts/config.sh` ([#ce5bfdb](https://github.com/v3b6a7t/git-diary/commit/ce5bfdba4342096bb8c9a444c055cd896b9e0109#diff-bf341924f07a18ca2bcbbe80e9553f6e)) aplikacji umożliwiającą, w razie potrzeby, inicjację git oraz utworzenie pierwszego zatwierdzenia w głównej gałęzi. Dodano plik `.gitignore` oraz `git ls-files --exclude-from=.gitignore` do skryptu `scripts/show.sh` ([#56d3965](https://github.com/v3b6a7t/git-diary/commit/56d3965f9c9478429364c41ae045ccb964068f62#diff-c25c15ca3033369ec69257b29805eadc)). |
| 13.07.2020 | Ujednolicono nazwy funkcji w `scripts/util/display.sh` ([#eb1026a](https://github.com/v3b6a7t/git-diary/commit/eb1026a49204f02fe5922c064e2c367b6b9b351f#diff-df46c8ebb1a65b6df3d55b10a35d1ab6)) oraz zmieniono sposób wyświetlania w `scripts/show.sh` wprowadzając flagę `grep --max-count` ([#eb1026a](https://github.com/v3b6a7t/git-diary/commit/eb1026a49204f02fe5922c064e2c367b6b9b351f#diff-c25c15ca3033369ec69257b29805eadcR39)). |
