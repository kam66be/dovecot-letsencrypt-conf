#!/bin/bash

TIME=`date`
SCAN="/etc/letsencrypt/live/mail.*"
OUTPUT="/etc/dovecot/letsencrypt.conf"

cat > $OUTPUT <<_EOL_
# Generated at ${TIME}
#
#!include ${OUTPUT} 

verbose_ssl = yes

_EOL_

for s in $SCAN; do 
    cat >> $OUTPUT <<_EOL_
local_name ${s##*/} {
  ssl_cert = <${s}/fullchain.pem
  ssl_key = <${s}/privkey.pem
}
_EOL_
done
