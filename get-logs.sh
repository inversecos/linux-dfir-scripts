#!/bin/bash

#get-logs.sh

usage () {
  echo "usage: $0 <mount point of root> [database name]"
  echo "Simple script to get log files and optionally store them in the database"
  exit 1
}

if [ $# -lt 1 ] ; then
  usage
fi

olddir=$(pwd)
cd $1/var

find log -type f -regextype posix-extended -regex '\log/[a-zA-Z\.]+(/[a-zA-Z\.]+)*' -exec awk '{ print "{};" $0}' {} \; | tee -a /tmp/logfiles.csv
cd $olddir
