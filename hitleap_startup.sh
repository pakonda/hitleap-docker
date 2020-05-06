#! /bin/bash

## check required env var
if [ -z "$HITLEAP_USER" ] || [ -z "$HITLEAP_PASS" ]; then
    echo -e "\nMakes sure that all HITLEAP_USER and HITLEAP_PASS are set\n"
    exit 1
fi

## start xvfb
echo -e "\nStarting Xvfb DISPLAY=$DISPLAY"
sudo Xvfb $DISPLAY -ac -screen 0 800x600x16 -nolisten tcp &
until pids=$(pidof Xvfb); do sleep 1; done

## start hitleap
sleep 3;
echo -e "\nStarting HitLeap Viewer\n"
cp $HITLEAP_DIR/app/data.orig $HITLEAP_DIR/app/data
$HITLEAP_DIR/hitleap_auto_login.sh &
cd $HITLEAP_DIR && ./HitLeap-Viewer.desktop
