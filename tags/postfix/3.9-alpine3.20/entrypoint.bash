#! /bin/bash
set -eu -o pipefail

if [[ ! -v MAIL_CONFIG ]]; then
  echo "ERROR: variable 'MAIL_CONFIG' is not set" >&2
  exit 100
fi

if [[ ! -f ${MAIL_CONFIG}/main.cf ]]; then
  echo "INFO: No configuration detected, making default one."
  tar -C /etc/postfix -cf - . | tar -C /usr/local/etc/postfix -xf -

  postconf -n -c /etc/postfix > "${MAIL_CONFIG}/main.cf"
  postconf -e "config_directory = ${MAIL_CONFIG}" 
  postconf -e "meta_directory = ${MAIL_CONFIG}" 
  postconf -e "sample_directory = ${MAIL_CONFIG}" 
  postconf -e "maillog_file = /dev/stdout"
fi

exec /usr/sbin/postfix start-fg 
