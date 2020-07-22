#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"


# REQUIRE SOURCES & DIRECTORIES

require_source "config"
require_source "display"
require_directory "ssh"


#-----------------------------------
# SCRIPT FUNCTIONS DEFINITIONS
#-----------------------------------

show_ssh_key() {

    # $1 -- path to file ssh key

    vim "$1.pub"
    exit 0

}


remove_ssh_key_from_agent() {

    # $1 -- path to file ssh key

    if [ `ssh-add -d "$1.pub" 2>&1 | grep "^Identity removed\:" -c` -gt 0 ]; then
        
        display_info "The SSH key '$SSH_FILENAME' has been removed from the Autentication Agent";

    else

        display_warning "The SSH key '$SSH_FILENAME' could not be removed from the Autentication Agent"; echo
        exit 2

    fi

    

}


remove_ssh_key_from_storage() {

    # $1 -- path to file ssh key

    rm $1*
                
    if [ ! -f "$1" ]; then 
                
        display_info "The SSH key '$1' has been removed from the storage";
        if [ `ls -lfA $DIR_SSH | wc -l` = 0  ]; then rm -r $DIR_SSH; fi

    else 
    
        display_warning "The SSH key '$SSH_FILENAME' could not be removed from the storage"; echo
        exit 2
    
    fi

}


remove_ssh_key() {

    # $1 -- path to file ssh key

    if [ -f "$1" ]; then

        remove_ssh_key_from_agent $1
        remove_ssh_key_from_storage $1
        echo 

    else

        display_warning "The SSH key '$SSH_FILENAME' not exists"; echo
        exit 2

    fi

}


create_ssh_key() {

    # $1 -- path to file ssh key

    if [ ! -f "$1" ]; then

        display info begin
        echo " An SSH key will be generated "
        echo " please enter a strong password "
        display info end

        ssh-keygen -t rsa -b 4096 -C "$SSH_EMAIL" -f "$1"

        if [ -f "$1" ]; then
        
            display info begin
            echo " The private key will be added "
            echo " to the SSH Authentication Agent "
            echo " Enter your password "
            display info end

            ssh-add "$1"
        fi

    else

        display_info "SSH key '$SSH_FILENAME' already exists"; echo
    
    fi

}


#-----------------------------------
# BODY SCRIPT
#-----------------------------------


# CREATE AND DISPLAY SSH KEY

if [ ! -z "$DIR_SSH" ] && [ ! -z "$SSH_EMAIL" ] && [ ! -z "$SSH_FILENAME" ]; then

    KEY_FILENAME="$DIR_SSH/$SSH_FILENAME";

    get_run_mode "SSH_MODE"

    case "$SSH_MODE" in
        
        "show")     show_ssh_key "$KEY_FILENAME"
                    ;;

        "delete")   remove_ssh_key "$KEY_FILENAME"
                    ;;

            *)      create_ssh_key "$KEY_FILENAME"
                    ;;
    esac

fi
