FROM consol/ubuntu-icewm-vnc
LABEL maintainer="pakondaman@gmail.com"

ENV HITLEAP_DIR=$HOME/hitleap \
    VNC_RESOLUTION=800x600

USER 0
# RUN sed -i 's|archive.ubuntu|th.archive.ubuntu|g' /etc/apt/sources.list
RUN apt-get update && apt-get -y install \
    xz-utils \
    xdotool \
    chromium-browser \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
USER 1000

# Install HitLeap
RUN mkdir -p $HITLEAP_DIR && \
    wget -qO- https://hitleap.com/viewer/download?platform=Linux | tar -xJf - -C $HITLEAP_DIR && \
    chmod +x $HITLEAP_DIR/HitLeap-Viewer.desktop && \
    cp $HITLEAP_DIR/app/data $HITLEAP_DIR/app/data.orig

# Pipe hitleap logs
RUN ln -sf /proc/1/fd/1 $HITLEAP_DIR/app/hitleap-viewer.log && \
    cd $HITLEAP_DIR/app/releases/*/ && \
    ln -sf /dev/null ./cefsimple-log.txt

COPY --chown=1000:root *.sh $STARTUPDIR/
RUN chmod a+x $STARTUPDIR/hitleap_*.sh


ENTRYPOINT ["/dockerstartup/hitleap_startup.sh"]
CMD [ "--wait"]
