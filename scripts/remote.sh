#!/bin/bash

# -------------------------
# Do zrobienia 
# -------------------------

# dzoałania na wszystkich odległych repozytoriach 
# według wskazanego działania
# na przykład:

DIR=`dirname $0`

for REMOTE_BRANCH in `git branch -r`
do
    $DIR/show.sh $1 $REMOTE_BRANCH
done

# A także obsługa poleceń 'pull' i 'push' 
# dla wszystkich odległuch repozytoriów.