#!/bin/bash

if [ "_$1_" = "__" ] 
then
    echo "Error: Required parameter!"
    exit 1
fi

# FUNCTIONS DEFUNINITIONS

main() {
    if [ $1 = "all" ] || [ $1 = "other" ]
    then
        git_add '.'
        git_commit $1

    elif [ `ls -dl */ | grep "\s$1/$" -c` -gt 0 ]
    then
        git_add $1
        git_commit $1
    fi
}

git_add() {
    if [ $1 = '.' ]
    then 
        git add .
    else
        git reset HEAD `git ls-files *[^$1]`
        git add `git ls-files -m -d -o $1/*`
    fi
}

git_commit() {
    
    info "Start commit '$1'"
    git commit -m "[${1^^}:`git log --oneline  | grep "\[${1^^}:[0-9]*\]" -c`] `date +'%Y-%m-%d %H:%M:%S.%3N'`"
    
    info "End commit '$1'"
    git log --oneline -1
    
    info "Show commit"
    git cat-file -p `git rev-list HEAD -1`

    info "Show commited tree"
    git ls-tree `git rev-list HEAD -1`
}


info() {
    echo
    echo "---[ $1 ]---"
    echo
}



# BODY SCRIPT

clear

main $1

echo