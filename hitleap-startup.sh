#! /bin/bash

/startup.sh &

SERVICE="x11vnc"
is_x11vnc_run=false
while [ "$is_x11vnc_run" == false ]
do
    if pgrep -x "$SERVICE" >/dev/null
    then
        echo 'Start Hitleap in 5s'
        is_x11vnc_run=true
        sleep 5
        cd /hitleap
        DISPLAY=:1 ./hl
    else sleep 1
    fi
done
