#!/bin/bash
# hitleap auto login script

getHitleapId(){
    WIN_ID=$(xdotool search --name "HitLeap")
    # echo $WIN_ID
}

isLoggedIn() {
    WIN_NAME=$(xdotool getwindowname $WIN_ID)
    # echo $WIN_NAME
    if [[ $WIN_NAME == *" | "* ]]; then
        IS_LOGGED_IN=1
    fi
}

until [[ $WIN_ID ]]; do getHitleapId; sleep 1; done

# Start auto log-in
echo -e "\nWaiting for homepage load. Auto log-in script will execute in $LOGIN_WAIT sec.\n"
sleep $LOGIN_WAIT
# xdotool windowactivate $WIN_ID # not available on xvfb
xdotool sleep 1
xdotool key Tab
xdotool type $HITLEAP_USER
xdotool key Tab
xdotool type $HITLEAP_PASS
xdotool key Return

COUNTER=0
while true
do
    sleep 1
    if [[ $IS_LOGGED_IN -ne 1 ]]; then
        isLoggedIn
        COUNTER=$((COUNTER+1))
        if [[ $COUNTER -gt $LOGIN_TIMEOUT ]]; then
            echo -e "Login timeout!!"
            echo -e "Please check your username/password or internet connection."
            pkill -f HitLeap-Viewer
        fi
    else
        echo -e "\n====================  HitLeap Viewer logged-in ====================\n"
        exit 0
    fi
done
