FROM alpine:latest@sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f

# github metadata
LABEL org.opencontainers.image.source https://github.com/paullockaby/syslog-ng

# only need to install syslog-ng, nothing else
RUN apk add --no-cache tini syslog-ng
HEALTHCHECK --interval=2m --timeout=3s --start-period=30s CMD /usr/sbin/syslog-ng-ctl stats || exit 1

VOLUME ["/etc/syslog-ng", "/logs"]
ENTRYPOINT ["/sbin/tini", "--", "/usr/sbin/syslog-ng", "-F"]
