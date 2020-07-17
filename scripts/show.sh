#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"


# REQUIRE SOURCES

require_source "display"


# DETERMINATION VALUES OF VARIABLES

if [ -z $1 ]; then
    display_warning "Required parameter!"; echo
    exit 1
fi


# PARAMETERS

GIT_LS_FILES="git ls-files -m -d -o -v --exclude-from=.gitignore $1"

GREP_MAX_COUNT="-m 5"


# VIEW LOCAL OR REMOTE LOG CONTENTS FOR THE SELECTED TYPE

if [ -z $2 ]; then

    display_info "Branch: '`git rev-parse --abbrev-ref HEAD`', param: '$1'"

    if [ `$GIT_LS_FILES $1 | wc -l` -gt 0 ]; then
        
        display warning begin
        $GIT_LS_FILES
        display warning end
    
    fi

else 

    display_info "Remote: '$2', param: '$1'"

fi


# VIEW LOCAL OR REMOTE LOG CONTENTS FOR ALL TYPES

display gray begin
git log --oneline $2 | grep $GREP_MAX_COUNT "\[${1^^}:[0-9]*\]"
display gray end
