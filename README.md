# HitLeap Docker

<a target="_blank" href="https://hitleap.com/by/pkd"><img src="https://hitleap.com/banner.png" width="468" height="60"></a>

[HitLeap](https://hitleap.com/by/pkd) is a top traffic exchange service that helps you to increase visitors, rankings and more.

```shell
# hitleap will store sessions in this file
echo '{"newestVersion":{"str":"3.1.29"}}' > data

docker run --rm -it \
    --name hitleap \
    -e RESOLUTION=800x600 \
    -e VNC_PASSWORD=1234 \
    -v /dev/shm:/dev/shm \
    -v $(pwd)/data:/hitleap/app/data \
    -p 8080:80 \
    pakonda/hitleap:3.1.29

# go to http://localhost:8080
# sign in
```

With self signed certificate

```shell
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt

docker run --rm -it \
    --name hitleap \
    -e RESOLUTION=800x600 \
    -e VNC_PASSWORD=1234 \
    -e SSL_PORT=443 \
    -v /dev/shm:/dev/shm \
    -v $(pwd)/ssl:/etc/nginx/ssl \
    -v $(pwd)/data:/hitleap/app/data \
    -p 443:443 \
    pakonda/hitleap:3.1.29
```
