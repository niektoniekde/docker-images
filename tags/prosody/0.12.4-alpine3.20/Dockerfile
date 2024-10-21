FROM alpine:3.20

ARG PROSODY_UID=101
ARG PROSODY_GID=101

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

ARG PKGS_PROSODY=" \
  prosody \
"

ARG PROSODY_CONFIG="/usr/local/etc/prosody/prosody.cfg.lua"
ARG PROSODY_CONFD="/usr/local/etc/prosody/conf.d"

COPY entrypoint.bash /usr/local/bin/entrypoint.bash
RUN addgroup -g ${PROSODY_GID} prosody \
  && adduser -D \
    -u ${PROSODY_UID} \
    -G prosody \
    -h /var/lib/prosody \
    -s /sbin/nologin \
    prosody \
  && apk add --no-cache \
  ${PKGS_BASIC} \
  ${PKGS_PROSODY} \
  && chmod 0755 /usr/local/bin/entrypoint.bash \
  && mkdir -p "${PROSODY_CONFD}" \
  && chown prosody:prosody "${PROSODY_CONFD}" \
  && echo "Include \"${PROSODY_CONFD}/*.cfg.lua\"" \
  > "${PROSODY_CONFIG}" \
  && chown root:prosody "${PROSODY_CONFIG}"

VOLUME ["/usr/local/etc/prosody/conf.d"]

ENV PROSODY_CONFIG="${PROSODY_CONFIG}"
ENV PROSODY_CONFD="${PROSODY_CONFD}"
ENV PROSODY_ADMIN="admin@localhost"

USER prosody
ENTRYPOINT ["/usr/local/bin/entrypoint.bash"]
