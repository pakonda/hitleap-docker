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

# start openvpn
if [[ "$OVPN" ]]; then
    iproute_init="/tmp/iproute_init"
    iproute_new="/tmp/iproute_new"
    ip route show > $iproute_init
    sudo openvpn $OVPN &
    until cmp -s "$iproute_init" "$iproute_new"; do
        ip route show > $iproute_new
        sleep 3
    done
    rm $iproute_init $iproute_new
    echo -e "\nVPN $OVPN, Connection Initiated\n"
fi

## start hitleap
echo -e "\nStarting HitLeap Viewer\n"
sleep 5
cp $HITLEAP_DIR/app/data.orig $HITLEAP_DIR/app/data
sudo $HITLEAP_DIR/hitleap_cleanup.sh &
$HITLEAP_DIR/hitleap_auto_login.sh &
cd $HITLEAP_DIR && ./HitLeap-Viewer.desktop
