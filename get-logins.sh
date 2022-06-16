#!/bin/bash

#get-logins.sh

usage () {
  echo "usage: $0 <mount point of root> [database name]"
  echo "Simple script to get logins and optionally store them in the database"
  exit 1
}

if [ $# -lt 1 ] ; then
  usage
fi

echo "who-what,terminal-event,start,stop,elapsedTime,ip" | tee /tmp/logins.csv

for logfile in $1/var/log/wtmp*
do
  last -aiFwx -f $logfile | awk '{print substr($0, 1, 8) "," substr($0, 10, 13) "," substr($0, 23, 24) "," substr($0, 50, 24) "," substr($0, 75, 12) "," substr($0, 88, 15)}' | sed 's/[[:space:]]*;/;/g' | sed 's/[[:space:]]+n\n/\n/' | tee -a /tmp/logins.csv
done

echo "who-what,terminal-event,start,stop,elapsedTime,ip" | tee /tmp/logins.csv

for logfile in $1/var/log/btmp*
do
  last -aiFwx -f $logfile | awk '{print substr($0, 1, 8) "," substr($0, 10, 13) "," substr($0, 23, 24) "," substr($0, 50, 24) "," substr($0, 75, 12) "," substr($0, 88, 15)}' | sed 's/[[:space:]]*;/;/g' | sed 's/[[:space:]]+n\n/\n/' | tee -a /tmp/logins.csv
done
