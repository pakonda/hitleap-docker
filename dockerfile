FROM dorowu/ubuntu-desktop-lxde-vnc

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /hitleap /root/Desktop

RUN curl -L https://hitleap.com/viewer/download?platform=Linux --output /tmp/hitleap.tar.xz && \
    tar -xJf /tmp/hitleap.tar.xz -C /hitleap && \
    mv /hitleap/HitLeap-Viewer.desktop /hitleap/hl && \
    chmod +x /hitleap/hl && \
    ln -s /hitleap/app /root/Desktop && \
    ln -s /hitleap/hl /root/Desktop && \
    rm /tmp/hitleap.tar.xz

WORKDIR /
COPY hitleap-startup.sh .
RUN chmod +x hitleap-startup.sh

ENTRYPOINT [ "/hitleap-startup.sh" ]


EXPOSE 80
