#!/bin/bash

# Read configuration file
source log-monitor.cfg

# Check if argument is provided
if [ -n "$1" ]
then
    LOGFILE="$1"
fi

# Parse log file for specified string
tail -n0 -F $LOGFILE | while read LINE
do
   echo "$LINE" | grep "$SEARCHSTRING" > /dev/null
   if [ $? = 0 ]
   then
      # Restart corresponding service
      systemctl restart backend@$SERVICENAME.service
   fi
done

