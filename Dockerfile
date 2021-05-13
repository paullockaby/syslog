FROM debian:bullseye-slim@sha256:5ee72c20d758a6e1bde32c4e7dd1cde408d57850166c86409c857468242653e1

# github metadata
LABEL org.opencontainers.image.source https://github.com/paullockaby/syslog-ng

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q update && \
    apt-get install -y --no-install-recommends syslog-ng && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=2m --timeout=3s --start-period=30s CMD /usr/sbin/syslog-ng-ctl stats || exit 1
VOLUME ["/etc/syslog-ng", "/logs"]
ENTRYPOINT ["/usr/sbin/syslog-ng", "-F", "--no-caps"]
