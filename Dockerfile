FROM dorowu/ubuntu-desktop-lxde-vnc
LABEL maintainer="pakondaman@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /hitleap /root/Desktop

RUN curl -L https://hitleap.com/viewer/download?platform=Linux --output /tmp/hitleap.tar.xz && \
    tar -xJf /tmp/hitleap.tar.xz -C /hitleap && \
    mv /hitleap/HitLeap-Viewer.desktop /hitleap/hl && \
    chmod +x /hitleap/hl && \
    ln -s /hitleap/app /root/Desktop && \
    ln -s /hitleap/hl /root/Desktop && \
    rm /tmp/hitleap.tar.xz

# pipe hitleap logs to stdout
RUN ln -sf /proc/1/fd/1 /hitleap/app/hitleap-viewer.log
RUN cd /hitleap/app/releases/*/ && \
    ln -sf /proc/1/fd/1 ./cefsimple-log.txt

WORKDIR /
COPY hitleap-*.sh /
RUN chmod +x hitleap-*.sh

EXPOSE 80

ENTRYPOINT [ "/hitleap-startup.sh" ]
