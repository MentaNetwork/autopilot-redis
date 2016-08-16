FROM redis:alpine
MAINTAINER Menta Network <dev@mentanetwork.com>

ENV CONTAINERPILOT=file:///etc/containerpilot.json \
    CONTAINERPILOT_VERSION=2.4.1 \
    CONTAINERPILOT_SHA1=198d96c8d7bfafb1ab6df96653c29701510b833c

COPY containerpilot.json /etc/

RUN apk update && \
    apk add curl openssl tar

# Releases at https://github.com/joyent/containerpilot/releases
RUN curl --retry 5 -Lso /tmp/containerpilot.tar.gz \
    "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" && \
    echo "${CONTAINERPILOT_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c && \
    tar zxf /tmp/containerpilot.tar.gz -C /bin && \
    rm /tmp/containerpilot.tar.gz

ENTRYPOINT []

EXPOSE 6379

CMD ["containerpilot", "/usr/local/bin/docker-entrypoint.sh", "redis-server"]
