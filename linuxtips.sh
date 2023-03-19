#!/bin/bash

while getopts 'eh:' OPTION; do
    case "$OPTION" in
        e)
            nano /etc/linuxtips/config.sh;;

        h)
            echo "linuxtips -e to edit configuaration file.";;

        \?)
        echo "-h to get help." >&2
        exit 1
        ;;
    esac
done
shift $((OPTIND-1))
