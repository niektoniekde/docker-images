FROM alpine:3.20

ARG POSTFIX_UID=101
ARG POSTFIX_GID=101
ARG VMAIL_UID=1000
ARG VMAIL_GID=1000

ARG PKGS_BASIC=" \
  bash \
  bind-tools \
  curl \
  iproute2-ss \
  mailx \
  netcat-openbsd \
  socat \
  tar \
"

ARG PKGS_POSTFIX=" \
  postfix \
"

COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN addgroup -g ${POSTFIX_GID} postfix \
  && adduser -D \
    -u ${POSTFIX_UID} \
    -G postfix \
    -h /dev/null \
    -s /sbin/nologin \
    postfix \
  && addgroup -g ${VMAIL_GID} vmail \
  && adduser -D \
    -u ${VMAIL_UID} \
    -G vmail \
    -h /home/vmail \
    -s /sbin/nologin \
    vmail \
  && apk add --no-cache \
  ${PKGS_BASIC} \
  ${PKGS_POSTFIX} \
  && chmod 0755 /usr/local/bin/entrypoint.bash

ENV MAIL_CONFIG="/usr/local/etc/postfix"

VOLUME ["/usr/local/etc/postfix", "/var/local/vmail"]

ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]
