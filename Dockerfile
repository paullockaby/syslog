FROM debian:bullseye-slim@sha256:f4da3f9b18fc242b739807a0fb3e77747f644f2fb3f67f4403fafce2286b431a AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/paullockaby/syslog-ng

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends syslog-ng && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=2m --timeout=3s --start-period=30s CMD /usr/sbin/syslog-ng-ctl stats || exit 1
VOLUME ["/etc/syslog-ng", "/logs"]
EXPOSE 514/tcp 514/udp
ENTRYPOINT ["/usr/sbin/syslog-ng", "-F", "--no-caps"]
