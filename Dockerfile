FROM openjdk:alpine
MAINTAINER Shoma Ishihara <sishihara@iij.ad.jp>

ARG http_proxy
ARG https_proxy
ARG presto_version=0.175

ENV HTTP_PROXY ${http_proxy}
ENV HTTPS_PROXY ${https_proxy}
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}

ENV PRESTO_VERSION ${presto_version}
ENV PRESTO_HOME /opt/presto-server-${presto_version}

RUN mkdir /work

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz /work/

RUN mkdir -p /opt && cd /opt && \
      tar xzvf /work/presto-server-${PRESTO_VERSION}.tar.gz && \
      mkdir -p /var/presto

COPY config/ ${PRESTO_HOME}/etc/

RUN apk --no-cache add python util-linux bash

ADD *.tmpl /opt/
ADD run.sh /run.sh

RUN chmod 755 /run.sh && \
      rm -rf /work

EXPOSE 8080

CMD ["/run.sh", "worker"]