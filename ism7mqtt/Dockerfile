FROM zivillian/ism7mqtt:v0.0.12

# Default ENV
ENV \
    LANG="C.UTF-8" \
    S6_OVERLAY_VERSION=3.1.2.1 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_SERVICES_READYTIME=50 \
    BASHIO_VERSION=0.14.3 \
    TEMPIO_VERSION=2021.09.0



SHELL ["/bin/ash", "-o", "pipefail", "-c"]

COPY run.sh /
WORKDIR /usr/src
ARG BUILD_ARCH

# A lot of this is copied from HAs base image, so we can use its fancy features to retrieve options and MQTT credentials.
# Could probably be done a lot simpler...
RUN \
    set -x \
    && chmod a+x /run.sh \
    && apk add --no-cache \
        bash \
        bind-tools \
        ca-certificates \
        curl \
        jq \
        tzdata \
        xz \
        icu-libs \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then \
            export S6_ARCH="arm"; \
        elif [ "${BUILD_ARCH}" = "i386" ]; then \
            export S6_ARCH="i686"; \
        elif [ "${BUILD_ARCH}" = "amd64" ]; then \
            export S6_ARCH="x86_64"; \
        else \
            export S6_ARCH="${BUILD_ARCH}"; \
        fi \
    \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}.tar.xz" \
        | tar Jxvf - -C / \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" \
        | tar Jxvf - -C / \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz" \
        | tar Jxvf - -C / \
    && curl -L -f -s "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz" \
        | tar Jxvf - -C / \
    && mkdir -p /etc/fix-attrs.d \
    && mkdir -p /etc/services.d \
    \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v${BASHIO_VERSION}.tar.gz" \
        | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio \
    \
    && curl -L -f -s -o /usr/bin/tempio "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}" \
    && chmod a+x /usr/bin/tempio \
    && rm -rf /usr/src/*





ENTRYPOINT ["/init"]
CMD ["/run.sh"]