FROM 0x416e746f6e0a/alpine-base:3.11

# set maintainer label
LABEL MAINTAINER="Anton Chen <contact@antonchen.com>"

ARG ARCH=amd64
ARG VERSION=2.16.0
ENV RTIME=15d RSIZE=0 RELOAD="false"

ADD https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-${ARCH}.tar.gz /tmp/
RUN \
 tar xf /tmp/prometheus-${VERSION}.linux-${ARCH}.tar.gz -C /tmp && cd /tmp/prometheus-${VERSION}.linux-${ARCH} && \
 mv prometheus promtool /bin/ && \
 mkdir -p /etc/prometheus && \
 mv prometheus.yml console_libraries consoles /etc/prometheus/ && \
 cd /tmp && \
 echo "**** cleanup ****" && \
 rm -rf \
    /tmp/*

# copy local files
COPY root/ /

EXPOSE 9090
VOLUME [ "/prometheus" ]
WORKDIR /prometheus
