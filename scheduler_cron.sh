#!/bin/bash

source ./config.sh

DATE=$(date +%Y%m%d%H%M)
NEXT=$(head -n 1 $JOBFILE)
if [ ! -e $LOCKFILE ] && [ ! -z $NEXT ]
then

echo "" > $LOCKFILE

tail -n +2 $JOBFILE > /tmp/tail.tmp && mv -f /tmp/tail.tmp $JOBFILE

LOGFILE=$OUTPUTDIR$NEXT-$DATE.log

$SCRIPTDIR$NEXT >> $LOGFILE && (cat $(echo "$LOGFILE") | mail -s "Job $NEXT done" $EMAIL) &&

rm $LOCKFILE

fi