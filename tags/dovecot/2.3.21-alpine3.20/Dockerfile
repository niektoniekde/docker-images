FROM alpine:3.20

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
"

ARG PKGS_DOVECOT=" \
  dovecot \
  dovecot-gssapi \
  dovecot-ldap \
  dovecot-lmtpd \
  dovecot-lua \
  dovecot-mysql \
  dovecot-openrc \
  dovecot-pgsql \
  dovecot-pigeonhole-plugin \
  dovecot-pigeonhole-plugin-ldap \
  dovecot-pop3d \
  dovecot-sql \
  dovecot-sqlite \
  dovecot-submissiond \ 
"

COPY dovecot.conf /tmp/dovecot.conf
COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN apk add --no-cache \
  ${PKGS_BASIC} \
  ${PKGS_DOVECOT} \
  && addgroup -g ${VMAIL_GID} vmail \
  && adduser -D \
    -u ${VMAIL_UID} \
    -G vmail \
    -h /home/vmail \
    -s /sbin/nologin \
    vmail \
  && mkdir -p /usr/local/etc/dovecot/conf.d \
  && mkdir -p /var/local/vmail \
  && chown root:dovecot -R /usr/local/etc/dovecot \
  && mv /tmp/dovecot.conf /usr/local/etc/dovecot \
  && chmod 0755 /usr/local/etc/dovecot \
  && chmod 0775 /usr/local/etc/dovecot/conf.d \
  && chmod 0755 /usr/local/bin/entrypoint.bash

VOLUME ["/usr/local/etc/dovecot/conf.d", "/var/local/vmail"]

ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]
