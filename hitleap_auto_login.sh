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

sleep 10
xdotool windowactivate $WIN_ID
xdotool sleep 2
xdotool key Tab
xdotool type $HITLEAP_USER
xdotool key Tab
xdotool type $HITLEAP_PASS
xdotool key Return

until [[ $IS_LOGGED_IN ]]; do isLoggedIn; sleep 1; done
echo -e "\n====================  HitLeap Viewer logged in ====================\n"
