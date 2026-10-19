#!/bin/sh


set -e

#-x509: mandatory to use for the self-sign
# -nodes: for skip the ask enter pass

if [ ! -f /the_certificate/server.crtf ] && [ ! -f /the_key/server.key ]; then

    mkdir /the_certificate
    mkdir /the_key

    openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
        -keyout /the_certificate/server.key \
        -out /the_key/server.crt \
        "/CN=hel-achh.42.fr"
fi


exec nginx -g "daemon off;"

