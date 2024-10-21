#! /bin/bash
set -eu -o pipefail

if [[ ! -v PROSODY_CONFIG ]]; then
  echo "ERROR: variable 'PROSODY_CONFIG' is not set" >&2
  exit 100
fi

if [[ ! -v PROSODY_CONFD ]]; then
  echo "ERROR: variable 'PROSODY_CONFD' is not set" >&2
  exit 100
fi

if [[ ! -v PROSODY_ADMIN ]]; then
  echo "ERROR: variable 'PROSODY_ADMIN' is not set" >&2
  exit 100
fi

if ! ls -1 ${PROSODY_CONFD}/*.conf 2>/dev/null; then
  cat > "${PROSODY_CONFD}/example.cfg.lua" << EOF
-- This file was auto-generated because configuration
-- wasn't present at container start. Feel free to
-- remove or modify this file with meaningful
-- configuration.

-- Information on configuring Prosody can be found on
-- website at https://prosody.im/doc/configure

-- Repository configuration file is at default location:
-- /etc/prosody/prosody.cfg.lua

pidfile = "/run/prosody/prosody.pid"
admins = { "${PROSODY_ADMIN}" }
certificates = "/etc/prosody/certs"
modules_enabled = {
  "disco"; 
  "roster";
  "tls";
  "saslauth";
  "admin_shell";
}

modules_disabled = {
  "s2s";
}

authentication = "internal_hashed"
storage = "internal"

log = {
  debug = "*console";
  info = "*console";
  warn = "*console";
  error = "*console";
}

VirtualHost "localhost"
  enabled = true;
EOF
fi

exec /usr/bin/prosody -F --config "${PROSODY_CONFIG}"
