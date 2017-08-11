#!/bin/bash

# Scheduler controll script
# Type --help or -h to get information about usage

source ./config.sh

if [ $# -eq 1 ]
  then
    if [ $1 = "clear" ]
      then
        echo "CLEAR"
    elif [ $1 = "reset" ]
      then
        echo "RESET"
    else
      echo "help"
    fi
elif [ $# -eq 2 ]
  then
    if [ $1 = "add" ]
      then
        echo "ADD $2"
    elif [ $1 = "remove" ]
      then
        echo "REMOVE $2"
    else
      echo "help"
    fi
fi