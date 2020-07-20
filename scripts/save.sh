#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"



# REQUIRE SOURCES

require_source "display"


# GET RUN MODE

get_run_mode "DISPLAY_MODE"


# CHECK rev-parse orgin/master

get_current_branch "CURRENT_BRANCH"
get_master_branch "MASTER_BRANCH"

GIT_REV_LIST=`git rev-list $CURRENT_BRANCH`
GIT_REV_PARSE=`git rev-parse origin/master`


if [ `echo "$GIT_REV_LIST" | grep "$GIT_REV_PARSE" -c` = 0 ]; then 
    
    display warning begin
    echo " This function cannot be used! "
    echo " Please use 'git pull' first! "
    display warning end
    
    exit 1

fi



# DETERMINATION VALUES OF VARIABLES

if [ -z $1 ]; then

    display_warning "Required parameter!"; echo

    exit 1

fi



# ================================
# script FUNCTIONS DEFININITIONS
# ================================


main() {

    if [ $1 = "all" ] || [ $1 = "other" ]; then
    
        process '.' "$1"
    
    elif [ `ls -dl */ | grep "\s$1/$" -c` -gt 0 ]; then
    
        process "$1" "$1"
    
    fi

}


process() {

    # $1 -- what is to be added to stag
    # $2 -- the type of files to commit
    # $3 -- commit message

    if [ `git ls-files -m -d -o "$1" | wc -l` -gt 0 ]; then 

        git_add "$1"
        git_commit "$2" "$3"
    
    else
    
        display_info "Nothing has been changed in the '$1' directory"
    
    fi

}


save_info() {

    if [ "$DISPLAY_MODE" = "full" ]

        then display_info "$1"; echo
        else echo
    
    fi

}



# ================================
# GIT FUNCTIONS DEFINITIONS
# ================================


git_add() {

    if [ "$1" = "." ]; then 
    
        git add .
    
    else

        git reset -q HEAD `git ls-files *[^$1]`
        git add `git ls-files -m -d -o $1/`

    fi


    if [ "$DISPLAY_MODE" = "full" ]; then

        save_info "Status after staged"
        git status
    
    fi

}


git_commit() {

    # $1 -- the type of files to commit
    
    get_run_param "--message"

    COMMIT_MESSAGE=${__MESSAGE__:-`date +'%Y-%m-%d %H:%M:%S.%3N'`}

    save_info "Commit '$1'"
    git commit -m "[${1^^}:`git log --oneline  | grep "\[${1^^}:[0-9]*\]" -c`] $COMMIT_MESSAGE"
    save_info "Commited '$1'"
    

    if [ "$DISPLAY_MODE" != "full" ]; then

        git log --oneline -1
    
    else
    
        git log -1
        REV_PARSE=`git rev-parse HEAD`
        
        display gray begin
        save_info "Tree commit (${REV_PARSE:0:7})"
        git ls-tree $REV_PARSE
        display gray end
    
    fi

}


# ================================
# BODY OF SCRIPT
# ================================




main "$1"

echo
