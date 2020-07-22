#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"

if [ ! -f "$PATH_CONFIG" ]; then
    
    "$DIR/config.sh"

fi

# REQUIRE SOURCES & DIRECTORY

require_source "config"
require_source "display"
require_directory "diary"


# CHECK INSTALL GIT & PREPARE FIRST COMMIT

if [[ "$GIT_VERSION" =~ [^0-9.]+ ]]; then
    
    display warning begin
    echo "WARNING!"
    echo "GIT DON'T INSTALLED"
    echo
    echo "See how to do it"
    echo "https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
    display warning end

else
    
    if [ ! -d ".git" ]; then git init; fi

    if ! git rev-parse --verify HEAD >/dev/null 2>&1; then

        COMMIT_MESSAGE="Application has been initiated: `date +'%d-%m-%Y %H-%M-%S'`"

        echo "$COMMIT_MESSAGE" >> $PATH_DIARY
        git add $PATH_DIARY
        git commit -m "COMMIT_MESSAGE"
    
    fi

fi

# DISPLAY SUMMARY

if [ -f "$PATH_DIARY" ] && [ `git rev-list HEAD | wc -l` -gt 0 ]; then 

    display_info "${COMMIT_MESSAGE:-Everything is good}"; echo

else 

    display warning begin
    echo "Something is not goot"
    echo "Please use the command: './run config'"
    display warning end
fi
