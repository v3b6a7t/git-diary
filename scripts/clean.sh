#!/bin/bash

DIR=`dirname $0`
DIR_DIARY="diary"
DIR_CONFIG="scripts/config"

source "$DIR/utils/display.sh"



# FUNCTIONS DEFINITIONS


info_message() {
    display info begin
    echo " Cleaning has been done! "
    echo " You can now use the command: "
    echo " './run config' or './run install' " 
    display info end
}


clean_data_config() {
    if [ -d "$DIR_CONFIG" ]; then rm -r "$DIR_CONFIG"; fi
    if [ ! -d "$DIR_CONFIG" ]; then info_message; fi
}

clean_data_diary() {
    if [ -d "$DIR_DIARY" ]; then 
        rm -r "$DIR_DIARY"; 
    fi
}


clean_data_ssh() {
    "$DIR/ssh.sh" "diary --delete"
}

clean_data() {    
    
    case "$1" in
    
        "force")    clean_data_diary
                    ;;

        "ssh")      clean_data_ssh
                    ;; 

        "config")   clean_data_ssh
                    clean_data_config
                    ;;
    esac

}


# BODY SCRIPT

case "$1" in

    "$DIR_DIARY" )
            CLEAN_MODE=`echo $@ | grep -oP "\-{2}\w+"`
            clean_data ${CLEAN_MODE:2}
            ;;
    
    *)      display_warning "This clean option for '$1' is not supported!"; echo
            ;;
esac
