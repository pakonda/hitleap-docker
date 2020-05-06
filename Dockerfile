FROM debian:buster-slim
LABEL maintainer="pakondaman@gmail.com"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

# Labels
LABEL org.label-schema.schema-version="1.0" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="hitleap docker" \
        org.label-schema.description="Hitleap Viewer container" \
        org.label-schema.url="https://github.com/pakonda/hitleap-docker" \
        org.label-schema.vcs-url="https://github.com/pakonda/hitleap-docker" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.version=$BUILD_VERSION \
        org.label-schema.docker.cmd="docker run --name hitleap -e HITLEAP_USER=user -e HITLEAP_PASS=password pakonda/hitleap"

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
