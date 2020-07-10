#!/bin/bash

if [ "_$1_" = "__" ] 
then
    echo "Error: Required parameter!"
    exit 1
fi

for ARG in $*; do
    if [ $ARG = "--full" ]
    then DISPLAY=full; break;
    else DISPLAY=short
    fi
done

# ================================
# SCRIPT FUNCTIONS DEFININITIONS
# ================================

# MAIN 
# $1 -- start param to run git process

main() {
    if [ $1 = "all" ] || [ $1 = "other" ]
    then
        process '.' $1

    elif [ `ls -dl */ | grep "\s$1/$" -c` -gt 0 ]
    then
        process $1 $1

    fi
}


# PROCESS 
# $1 -- param to 'git_add'
# $2 -- param to 'git_commit'

process() {
    if [ `git ls-files -m -d -o $1 | wc -l` -gt 0 ]
    then 
        git_add $1
        git_commit $2
    fi
}

# INFO
# $1 -- param to display info

info() {
    if [ $DISPLAY = "full" ]
    then
        echo
        echo "---[ $1 ]---"
        echo
    else 
        echo
    fi
}


# ================================
# GIT FUNCTIONS DEFINITIONS
# ================================


# git_add $1

git_add() {

    if [ $1 = '.' ]
    then 
        git add .
    else
        git reset -q HEAD `git ls-files *[^$1]`
        git add `git ls-files -m -d -o $1/*`
    fi

    if [ $DISPLAY = "full" ]
    then
        info "Status after staged"
        git status
    fi
}


# git_commit $1

git_commit() {
    
    info "Commit '$1'"
    git commit -m "[${1^^}:`git log --oneline  | grep "\[${1^^}:[0-9]*\]" -c`] `date +'%Y-%m-%d %H:%M:%S.%3N'`"

    info "Commited '$1'"
    git log --oneline -1

    if [ $DISPLAY = "full" ]
    then
        REV_PARSE=`git rev-parse HEAD`
        
        info "Last commit (${REV_PARSE:0:7})"
        git cat-file -p $REV_PARSE

        info "Tree commit (${REV_PARSE:0:7})"
        git ls-tree $REV_PARSE
    fi
}


# ================================
# BODY OF SCRIPT
# ================================

clear

main $1

echo