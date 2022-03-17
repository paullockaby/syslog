FROM debian:bullseye-slim@sha256:c8dfa67963242ad311a16f6296a61d430f43267cb26675c2153ba4c5efea9ee8 AS base

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
