FROM debian:buster-slim
LABEL maintainer="pakondaman@gmail.com"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

# Labels
LABEL \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="hitleap docker" \
    org.label-schema.description="Hitleap Viewer container" \
    org.label-schema.url="https://github.com/pakonda/hitleap-docker" \
    org.label-schema.vcs-url="https://github.com/pakonda/hitleap-docker" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$BUILD_VERSION \
    org.label-schema.docker.cmd="docker run --name hitleap -e HITLEAP_USER=user -e HITLEAP_PASS=password pakonda/hitleap"

RUN \
    apt-get update && \
    apt-get install -y \
        sudo curl xvfb chromium \
        xdotool xz-utils procps \
        libgconf-2-4 libgles2-mesa-dev \
        openvpn \
        && rm -rf /var/lib/apt/lists/*

ENV \
    HOME=/home/app \
    HITLEAP_DIR=/home/app/hitleap \
    DISPLAY=:1 \
    LOGIN_WAIT=40 \
    LOGIN_TIMEOUT=10 \
    AUTO_SHUT=0

# Create app user
RUN \
    groupadd -g 5000 app && useradd -u 5000 -g app -d $HOME -G sudo -m -s /bin/bash app && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "app ALL=(ALL) ALL" >> /etc/sudoers && \
    echo "app ALL=(ALL) NOPASSWD: /usr/sbin/openvpn" >> /etc/sudoers && \
    echo "app ALL=(ALL) NOPASSWD: $HITLEAP_DIR/hitleap_cleanup.sh" >> /etc/sudoers && \
    echo "app ALL=(ALL) NOPASSWD: $HITLEAP_DIR/hitleap_autoshut.sh" >> /etc/sudoers && \
    echo "app ALL=(ALL) NOPASSWD: /usr/bin/Xvfb" >> /etc/sudoers

RUN \
    mkdir -p $HITLEAP_DIR && \
    chown -R app $HITLEAP_DIR

USER app

# Install HitLeap
RUN \
    mkdir -p $HITLEAP_DIR && \
    curl -sL https://hitleap.com/viewer/download?platform=Linux | tar -xJf - -C $HITLEAP_DIR && \
    chmod +x $HITLEAP_DIR/HitLeap-Viewer.desktop && \
    cp $HITLEAP_DIR/app/data $HITLEAP_DIR/app/data.orig

# Pipe hitleap logs
RUN \
    ln -sf /proc/1/fd/1 $HITLEAP_DIR/app/hitleap-viewer.log && \
    cd $HITLEAP_DIR/app/releases/*/ && \
    ln -sf /dev/null ./cefsimple-log.txt

COPY --chown=app *.sh $HITLEAP_DIR/
RUN chmod +x $HITLEAP_DIR/*.sh

ENTRYPOINT "$HITLEAP_DIR/hitleap_startup.sh"
