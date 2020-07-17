#!/bin/bash

DIR=`dirname $0`

source "$DIR/utils/enviroment.sh"


# REQUIRE SOURCES & DIRECTORIES

require_source "config"
require_source "display"
require_directory "ssh"


# CREATE AND DISPLAY SSH KEY

if [ ! -z $DIR_SSH ] && [ ! -z $SSH_EMAIL ] && [ ! -z $SSH_FILENAME ]; then

    KEY_FILENAME="$DIR_SSH/$SSH_FILENAME";

    
    # DETERMINING THE VARIABLE VALUE OF SSH_MODE

    SSH_MODE=`echo $@ | grep -oP "\-{2}\w+"`
    SSH_MODE=${SSH_MODE:2}

    
    # THE SSH_MODE VARIABLE HAS A VALUE "clip"

    if [ "$SSH_MODE" = "clip" ]; then
        vim "$KEY_FILENAME.pub"
        exit 0
    fi

    # THE SSH_MODE VARIABLE HAS A VALUE "delete"

    if [ "$SSH_MODE" = "delete" ]; then

        # DO ZROBIENIA
        # Coś mi tutaj nie wyszło,
        # Nie jest usuwany klucz z listy

        if [ `ssh-add -l | grep "$KEY_FILENAME" -c` -gt 0 ]; then

            ssh-add -d "$KEY_FILENAME.pub"
            display_info "The SSH key '$SSH_FILENAME' has been removed from the Autentication Agent"; echo
        
        fi


        if [ ! `ssh-add -l | grep "$KEY_FILENAME" -c` -gt 0 ] & [ -f "$KEY_FILENAME" ]; then 
        
            rm $KEY_FILENAME*
            display_info "The SSH key '$SSH_FILENAME' has been removed from the storage"; echo
        
        fi 


        if [ `ls -lfA $DIR_SSH | wc -l` = 0  ]; then 

            rm -r $DIR_SSH

        fi

        exit 0

    fi

    # CREATED NEW KEY SSH

    if [ ! -f "$KEY_FILENAME" ]; then

        display info begin
        echo " An SSH key will be generated "
        echo " please enter a strong password "
        display info end

        ssh-keygen -t rsa -b 4096 -C "$SSH_EMAIL" -f "$KEY_FILENAME"

        if [ -f "$KEY_FILENAME" ]; then
        
            display info begin
            echo " The private key will be added "
            echo " to the SSH Authentication Agent "
            echo " Enter your password "
            display info end

            ssh-add "$KEY_FILENAME"
        fi

    else

        display_info "SSH key '$SSH_FILENAME' already exists"; echo
    
    fi

fi
