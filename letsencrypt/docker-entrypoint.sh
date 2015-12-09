#!/bin/bash

/opt/letsencrypt/venv/bin/letsencrypt certonly --agree-tos --email $DNS_MAIL --domains $DNS_ENTRY --standalone

FIRST_ENTRY=$(cut -d ',' -f 1 <<< $DNS_ENTRY)
CRT_PATH=$DNS_CERT/live/$FIRST_ENTRY

echo "Checking $CRT_PATH"


if [ -d $CRT_PATH ]; then

	ln -sf $CRT_PATH/fullchain.pem $DNS_CERT/cert.pem
	ln -sf $CRT_PATH/privkey.pem $DNS_CERT/key.pem

	cat $CRT_PATH/fullchain.pem $CRT_PATH/privkey.pem > $DNS_CERT/haproxy.pem
fi
