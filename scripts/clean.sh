#!/bin/bash

DIR=`dirname $0`
DIR_DIARY="diary"
DIR_CONFIG="scripts/config"


source "$DIR/utils/display.sh"


info_message() {

    display info begin
    echo " Cleaning has been done! "
    echo " You can now use the command: "
    echo " './run config' or './run install' " 
    display info end

}


if [ -d "$DIR_CONFIG" ]; then rm -r "$DIR_CONFIG"; fi

if [ ! -d "$DIR_CONFIG" ]; then info_message; fi


case "$1" in
    
    "$DIR_DIARY" )
        for ARG in $*; do
            if [ $ARG = "--force" ]
            then CLEAN_MODE=force; break;
            else CLEAN_MODE=soft
            fi
        done

        if [ "$CLEAN_MODE" = "force" ]; then     
            if [ -d "$DIR_DIARY" ]; then rm -r "$DIR_DIARY"; fi
        fi;;
    
    *)  display_warning "This clean option for '$1' is not supported!"; echo;;

esac