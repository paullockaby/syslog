# syslog-ng
A container for running syslog-ng. This simply installs syslog-ng and lets you
configure it to run either on Docker or Kubernetes.

## Running on Docker

This container expects to listen on two ports and have two mounted volumes. It
needs to listen on port 514 TCP and 514 UDP. It needs to have `/logs` mounted
and `/etc/syslog-ng` mounted.

    docker build -t ghcr.io/paullockaby/syslog-ng:latest .
    docker run --rm -p 514:514/tcp -p 514:514/udp -v $PWD/logs:/logs -v $PWD/example:/etc/syslog-ng ghcr.io/paullockaby/syslog-ng:latest

An example configuration file for mounting into `/etc/syslog-ng` is provided
in the `example` directory.
