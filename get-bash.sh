#!/bin/bash

#get-bash.sh

usage () {
  echo "usage: $0 <mount point of root> [database name]"
  echo "Simple script to get user histories and optionally store them in the database"
  exit 1
}

if [ $# -lt 1 ] ; then
  usage
fi

olddir=$(pwd)
cd $1

find home -type f -regextype posix-extended -regex "home/[a-zA-Z\.]+(/\.bash_history)" -exec awk '{print "{};" $0}' {} \; | tee /tmp/histories.csv

#repeat for root User
find home -type f -regextype posix-extended -regex "root(/\.bash_history)" -exec awk '{print "{};" $0}' {} \; | tee /tmp/histories.csv
