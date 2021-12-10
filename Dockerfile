FROM debian:bullseye-slim@sha256:656b29915fc8a8c6d870a1247aad7796ce296729b0ae95e168d1cfe30dd2fb3c AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/paullockaby/syslog-ng

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends syslog-ng && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=2m --timeout=3s --start-period=30s CMD /usr/sbin/syslog-ng-ctl stats || exit 1
VOLUME ["/etc/syslog-ng", "/logs"]
ENTRYPOINT ["/usr/sbin/syslog-ng", "-F", "--no-caps"]
