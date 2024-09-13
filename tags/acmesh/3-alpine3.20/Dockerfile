FROM alpine:3.20

RUN apk add --no-cache \
  acme.sh \
  bash \
  bind-tools \
  curl \
  gzip \
  netcat-openbsd \
  tar \
  && addgroup -g 101 acme \
  && adduser -D \
    -u 101 \
    -G acme \
    -h /home/acme \
    -s /bin/bash \
    acme

USER acme
