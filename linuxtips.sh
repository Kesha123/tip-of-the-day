#!/bin/bash

while getopts 'eh:' OPTION; do
    case "$OPTION" in
        e)
            nano $HOME/tip-of-the-day/config.sh;;

        h)
            echo "linuxtips -e to edit configuaration file.";;

        \?)
        echo "-h to get help." >&2
        exit 1
        ;;
    esac
done
shift $((OPTIND-1))
