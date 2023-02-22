#!/bin/bash

# Read configuration file
source config.cfg

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

