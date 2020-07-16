#!/bin/bash

source "`dirname $0`/utils/display.sh"


if [ "_$1_" = "__" ]; then
    display_warning "Error: Required parameter!"echo; 
    exit 0
fi


 DISPLAY_MODE=`echo $@ | grep -oP "\-{2}\w+"`
 DISPLAY_MODE=${DISPLAY_MODE:2}


# ================================
# SCRIPT FUNCTIONS DEFININITIONS
# ================================


main() {
    if [ $1 = "all" ] || [ $1 = "other" ]; then
        process '.' $1
    elif [ `ls -dl */ | grep "\s$1/$" -c` -gt 0 ]; then
        process $1 $1
    fi
}

process() {
    if [ `git ls-files -m -d -o $1 | wc -l` -gt 0 ]; then 
        git_add $1
        git_commit $2
    fi
}

save_info() {
    if [ "$DISPLAY_MODE" = "full" ]
        then display_info $1; echo
        else echo
    fi
}



# ================================
# GIT FUNCTIONS DEFINITIONS
# ================================

git_add() {

    if [ $1 = '.' ]; then 
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
    save_info "Commit '$1'"
    git commit -m "[${1^^}:`git log --oneline  | grep "\[${1^^}:[0-9]*\]" -c`] `date +'%Y-%m-%d %H:%M:%S.%3N'`"
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

clear

main $1

echo
