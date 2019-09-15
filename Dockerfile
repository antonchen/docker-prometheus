FROM 0x416e746f6e0a/alpine-base:3.10

# set maintainer label
LABEL MAINTAINER="Anton Chen <contact@antonchen.com>"

ARG ARCH=amd64
ARG VERSION=2.12.0

ADD https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-${ARCH}.tar.gz /tmp/
RUN \
 tar xf /tmp/prometheus-${VERSION}.linux-${ARCH}.tar.gz -C /tmp && cd /tmp/prometheus-${VERSION}.linux-${ARCH} && \
 mkdir -p /etc/prometheus && \
 mv prometheus promtool /bin/ && \
 mv prometheus.yml console_libraries consoles /etc/prometheus/ && \ 
 cd /tmp && \
 echo "**** cleanup ****" && \
 rm -rf \
    /tmp/*

EXPOSE 9090
VOLUME [ "/prometheus" ]
WORKDIR /prometheus
CMD [ "/bin/prometheus", \
      "--config.file=/etc/prometheus/prometheus.yml", \
      "--storage.tsdb.path=/prometheus", \
      "--web.console.libraries=/etc/prometheus/console_libraries", \
      "--web.console.templates=/etc/prometheus/consoles" ]
