#!/bin/bash

# Params:
# $1 : EXPECTED -- delect directory or all files

git_add () {
    if [ `git status | grep 'git add <file>...' -c` -gt 0 ] 
    then
        git add $1
        git_add $1
    else
        echo ===========================================
        echo "GIT: File(s) '$1' added to stash"
        echo ===========================================
        git status
    fi
}

git_add $1
