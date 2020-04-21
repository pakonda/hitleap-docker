# HitLeap Docker

![Docker Pulls](https://img.shields.io/docker/pulls/pakonda/hitleap)
![Docker Stars](https://img.shields.io/docker/stars/pakonda/hitleap)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/pakonda/hitleap?sort=semver)

[HitLeap](https://hitleap.com/by/pkd) docker image with HTML5 VNC interface to access

-------------------------
<a target="_blank" href="https://hitleap.com/by/pkd"><img src="https://hitleap.com/banner.png" width="468" height="60"></a>

Get $100 in cloud credits from @DigitalOcean using my link: https://m.do.co/t/e9d7773c782b

-------------------------

## Quick Start

-------------------------

```shell
docker run -d \
    --name hitleap \
    -e RESOLUTION=800x600 \
    -e VNC_PASSWORD=1234 \
    -v /dev/shm:/dev/shm \
    -p 8080:80 \
    pakonda/hitleap

# go to http://localhost:8080
# sign in
```

With self signed certificate

```shell
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt

docker run -d \
    --name hitleap \
    -e RESOLUTION=800x600 \
    -e VNC_PASSWORD=1234 \
    -e SSL_PORT=443 \
    -v /dev/shm:/dev/shm \
    -v $(pwd)/ssl:/etc/nginx/ssl \
    -p 443:443 \
    pakonda/hitleap
```
