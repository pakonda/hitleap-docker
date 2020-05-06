FROM debian:buster-slim

RUN apt-get update && apt-get install -y \
    curl xvfb chromium \
    xdotool xz-utils procps \
    libgconf-2-4 libgles2-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# ENV QT_DEBUG_PLUGINS=1
ENV HITLEAP_DIR=/opt/hitleap \
    DISPLAY=:1

# Install HitLeap
RUN mkdir -p $HITLEAP_DIR && \
    curl -sL https://hitleap.com/viewer/download?platform=Linux | tar -xJf - -C $HITLEAP_DIR && \
    chmod +x $HITLEAP_DIR/HitLeap-Viewer.desktop && \
    cp $HITLEAP_DIR/app/data $HITLEAP_DIR/app/data.orig

# Pipe hitleap logs
RUN ln -sf /proc/1/fd/1 $HITLEAP_DIR/app/hitleap-viewer.log && \
    cd $HITLEAP_DIR/app/releases/*/ && \
    ln -sf /dev/null ./cefsimple-log.txt

COPY *.sh $HITLEAP_DIR/
RUN chmod a+x $HITLEAP_DIR/*.sh

ENTRYPOINT "$HITLEAP_DIR/hitleap_startup.sh"
