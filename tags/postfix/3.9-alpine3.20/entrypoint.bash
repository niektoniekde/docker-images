#! /bin/bash
set -eu -o pipefail

if [[ ! -v MAIL_CONFIG ]]; then
  echo "ERROR: variable 'MAIL_CONFIG' is not set" >&2
  exit 100
fi

tar -C /etc/postfix -cf - . | tar -C /usr/local/etc/postfix -xf -

postconf -n -c /etc/postfix > "${MAIL_CONFIG}/main.cf"
postconf -e "config_directory = ${MAIL_CONFIG}" 
postconf -e "meta_directory = ${MAIL_CONFIG}" 
postconf -e "sample_directory = ${MAIL_CONFIG}" 
postconf -e "maillog_file = /dev/stdout"

exec /usr/sbin/postfix start-fg 
