#!/bin/bash

usage () {
  echo "usage: $0 <starting directory>"
  echo "script to get mac times from an image and output in csv"
}

if [ $# -lt 1 ] ; then
  usage
fi

olddir=$(pwd)
cd $1
printf "Access Date,Access Time,Modify Date,Modify Time,Create Date,Create Time,Permissions,User ID,Group ID,File Size,Filename\n"
find ./ -printf "%Ax,%AT,%Tx,%TT,%Cx,%CT,%m,%U,%G,%s,%p\n"
cd $olddir
