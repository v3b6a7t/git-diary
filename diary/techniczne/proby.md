## Próby różnych zastosowań


| DATA | TREŚĆ |
| --- | --- |
| 12.07.2020 | W czasie drogi do [Świebodzina koło Tarnowa](https://www.google.pl/maps/dir/Kłodzko/Kłokowa,+114/@50.3057783,17.6884954,8z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x470e17045d250309:0x773057f875141e1e!2m2!1d16.6613941!2d50.4345636!1m5!1m1!1s0x473d9ab6f9dd131d:0x9a1d91c17d425a04!2m2!1d20.9575104!2d49.9534956!3e0) wpadłem na pomysł aby w funkcji `git_add()` (w pliku: ./scripts/save.sh) zastować polecenie `git rm -q --cached` w miejsce `git reset -q HEAD`. Okazało się jednak, że się przeliczyłem, a polecenie `git rm --cached` nie jest wcale odwrotnością polecenia `git add`. |
