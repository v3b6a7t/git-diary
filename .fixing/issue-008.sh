#!/bin/bash

# FIXING ISSUES #8 
# https://github.com/v3b6a7t/git-diary/issues/8#issuecomment-662005174


source "scripts/utils/enviroment.sh"

unset $__SHOW
unset $__MODE

get_run_param "--show"
get_run_param "--mode"

if [ -z "$__SHOW" ] && [ -z "$__MODE" ]; then

    ./$0 --show "Ala ma kota" --mode "Ola ma Asa"

else

    echo "SHOW --> $__SHOW"
    echo "MODE --> $__MODE"

fi
