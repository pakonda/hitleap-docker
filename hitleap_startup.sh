#! /bin/bash

## check required env var
if [ -z "$HITLEAP_USER" ] || [ -z "$HITLEAP_PASS" ]; then
    echo -e "\nMakes sure that all HITLEAP_USER and HITLEAP_PASS are set\n"
    exit 1
fi

## start vnc
$STARTUPDIR/vnc_startup.sh &

## wait xvnc started
until pgrep Xvnc; do sleep 1; done
sleep 3

## start hitleap
cp $HITLEAP_DIR/app/data.orig $HITLEAP_DIR/app/data
$STARTUPDIR/hitleap_auto_login.sh &
cd $HITLEAP_DIR && ./HitLeap-Viewer.desktop
