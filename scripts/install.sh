#!/bin/bash

DIR=`dirname $0`

if [ ! -f "$DIR/config/config.conf" ]; then
    
    "$DIR/config.sh"

fi

source "$DIR/config/config.conf"
source "$DIR/utils/display.sh"

if [[ $GIT_VERSION =~ [^0-9.]+ ]]; then
    
    display warning begin
    echo "WARNING!"
    echo "GIT DON'T INSTALLED"
    echo
    echo "See how to do it"
    echo "https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
    display warning end

else
    
    if [ ! -d ".git" ]; then git init; fi

    if [ ! -d "diary" ]; then mkdir "diary"; fi

    if ! git rev-parse --verify HEAD >/dev/null 2>&1; then

        COMMIT_MESSAGE="Application has been initiated: `date +'%d-%m-%Y %H-%M-%S'`"
        DIARY_INDEX="diary/index.md"

        echo "$COMMIT_MESSAGE" >> $DIARY_INDEX
        git add $DIARY_INDEX
        git commit -m "COMMIT_MESSAGE"
    
    fi

fi


if [ -f $DIARY_INDEX ] & [ `git rev-list HEAD | wc -l` -gt 0 ]; then

    display_info "${COMMIT_MESSAGE:-Everything is good}"; echo

fi
