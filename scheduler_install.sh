#!/bin/bash

# install script for SimpleCronScheduler
# with option 'remove' the scheduler can be deinstalled

# TODO: make 

DIR=$(dirname "${VAR}")

if [ $# -eq 1 ] && [ $1 = "remove" ]
  then
    echo "Do you really want to remove SimpleCronScheduler? (y = \"yes\", n = \"no\""
    read $yn
    
    # Uninstall
    if [ $yn = "y" ]
      then
        # remove scripts
        rm -f /etc/cron.d/scheduler
        rm -f /usr/local/bin/scheduler
        
        # remove dirs and files
        rm -rf /var/scheduler
        rm -f /tmp/scheduler.lock
        rm -f $DIR/config.sh
    fi
else
  # Install
  
  # setup email-adress and other settings
  echo "Enter your EMail-Address for Notifications:"
  read $email
  echo "EMAIL=$email" >> $DIR/config.sh
  echo "JOBFILE=/var/scheduler/scheduler.jobs" >> $DIR/config.sh
  echo "LOCKFILE=/tmp/scheduler.lock" >> $DIR/config.sh
  echo "SCRIPTDIR=/var/scheduler/scripts/" >> $DIR/config.sh
  echo "OUTPUTDIR=/var/scheduler/output/" >> $DIR/config.sh
  
  
  # get useraccout to run cron-job
  echo "Enter useraccout to run scripts with:"
  read $user
  
  # make dirs and files
  mkdir /var/scheduler
  mkdir /var/scheduler/scripts
  mkdir /var/scheduler/output
  echo "" > /var/scheduler/scheduler.jobs
  
  # setup controll script and cron-job
  chmod +x $DIR/scheduler.sh
  ln -s $DIR/scheduler.sh /usr/local/bin/scheduler
  chmod +x $DIR/scheduler_cron.sh
  echo "* * * * * $user $DIR/scheduler_cron.sh > /dev/null 2>&1" >> /etc/cron.d/scheduler
fi