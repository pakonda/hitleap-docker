# HitLeap Docker

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/pakonda/hitleap)
![Docker Pulls](https://img.shields.io/docker/pulls/pakonda/hitleap)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/pakonda/hitleap)

[HitLeap](https://hitleap.com/by/pkd) docker image

-------------------------

## Quick Start

```shell
docker run -d \
    --name hitleap \
    -e HITLEAP_USER=user \
    -e HITLEAP_PASS=password \
    -e AUTO_SHUT=60 \ # Auto shutdown (minutes)
    pakonda/hitleap

## run multiple instances with openvpn
## grab some ovpn config file from https://www.vpngate.net

docker run -d \
    --name hitleap \
    --device=/dev/net/tun \
    --cap-add=NET_ADMIN \
    --dns=1.1.1.1 \
    -e HITLEAP_USER=user \
    -e HITLEAP_PASS=password \
    -e OVPN=/etc/openvpn/client/vpn_config.ovpn \
    -v ./vpn_config.ovpn:/etc/openvpn/client/vpn_config.ovpn \
    pakonda/hitleap
```

-------------------------
<a target="_blank" href="https://hitleap.com/by/pkd"><img src="https://hitleap.com/banner.png" width="468" height="60"></a>

Get $100 in cloud credits from @DigitalOcean using my link: https://m.do.co/t/e9d7773c782b

-------------------------
