#!/bin/bash

DIR=`dirname $0`

source "$DIR/config/config.conf"
source "$DIR/utils/display.sh"

if [ "_$DIR_SSH_" != "__" ] & [ "_$SSH_EMAIL_" != "__" ] & [ "_$SSH_FILENAME_" != "__" ]; then

    KEY_FILENAME="$DIR_SSH/$SSH_FILENAME";


    for ARG in $*; do
        if [ $ARG = "--delete" ]
        then SSH_MODE=delete; break;
        else SSH_MODE=create
        fi
    done


    if [ "$SSH_MODE" = "delete" ]; then

        if [ -f "$KEY_FILENAME" ] & [ `ssh-add -l | grep "$KEY_FILENAME" -c` -gt 0 ]; then 

            ssh-add -d "$KEY_FILENAME.pub" & rm $KEY_FILENAME*

            display_info "The SSH key '$SSH_FILENAME' has been deleted"; echo

        fi            

        exit 1

    fi


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
