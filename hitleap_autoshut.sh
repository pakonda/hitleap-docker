#!/bin/bash
# autoshut

secs=$(($1 * 60))
if [ $secs -ne 0 ]; then
    echo "HitLeap will terminate in $1 minutes"
    sleep $secs
    pkill -f HitLeap-Viewer
fi



