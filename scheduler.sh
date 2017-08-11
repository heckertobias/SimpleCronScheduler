#!/bin/bash

# Scheduler controll script
# Type --help or -h to get information about usage

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source "$DIR"/config.sh

function schedhelp {
  echo "SimpleCronScheduler usage:"
  echo " scheduler add ?    - add a script placed in $SCRIPTDIR to the queue"
  echo " scheduler remove ? - removes all occurrence of ? from the queue"
  echo " scheduler reset    - clears the complete queue"
}

if [ $# -eq 1 ]
  then
    if [ $1 = "reset" ]
      then
        echo "" > $JOBFILE
        #kill (echo $LOCKFILE)
        rm -f $LOCKFILE
        
        echo "SimpleCronScheduler was successfully resetted"
    else
      schedhelp
    fi
elif [ $# -eq 2 ]
  then
    if [ $1 = "add" ]
      then
        if [ -f $SCRIPTDIR$2 ]
          then
            chmod +x $SCRIPTDIR$2
            echo $2 >> $JOBFILE
            
            echo "$2 was added to SimpleCronSchedulers queue"
        else
          echo "Script $2 does not exit in $SCRIPTDIR"
        fi
    elif [ $1 = "remove" ]
      then
        echo "REMOVE is currently not implemented in SimpleCronScheduler"
    else
      schedhelp
    fi
else
  schedhelp
fi