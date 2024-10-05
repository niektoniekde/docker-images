#! /bin/bash
set -eu -o pipefail

CONFD_DIR="/usr/local/etc/dovecot/conf.d"

if ! ls -1 ${CONFD_DIR}/*.conf 2>/dev/null; then
  cat > "${CONFD_DIR}/00_example.conf" << EOF
mail_home=/var/local/vmail/%Lu
mail_location=maildir:~/
mail_uid=1000
mail_gid=1000

protocols = imap pop3 submission sieve lmtp

first_valid_uid = 1000
last_valid_uid = 1000

passdb {
  driver = static
  args = password=pass
}

ssl=yes
ssl_cert=</etc/ssl/dovecot/cert.pem
ssl_key=</etc/ssl/dovecot/key.pem

namespace {
  inbox = yes
  separator = /
}

service lmtp {
  inet_listener {
    port = 1024
  }
}

service pop3 {
  inet_listener {
    port = 1995
  }
}

service imap {
  inet_listener {
    port = 1993
  }
}

service submission {
  inet_listener {
    port = 1587
  }
}

service sieve {
  inet_listener {
    port = 4190
  }
}

listen = *

log_path=/dev/stdout
info_log_path=/dev/stdout
debug_log_path=/dev/stdout
EOF
fi

exec /usr/sbin/dovecot -F -c /usr/local/etc/dovecot/dovecot.conf
