#!/bin/bash


config_file_path="/etc/linuxtips/config.sh"

source $config_file_path

cat $TIPS_PATH/$CONNECTION_TIMES.txt

if [ "$CONNECTION_TIMES" -lt 10 ]; then
    t=$(($CONNECTION_TIMES + 1))
    echo "CONNECTION_TIMES=$t" > $config_file_path
else
    echo "CONNECTION_TIMES=1" > $config_file_path
fi