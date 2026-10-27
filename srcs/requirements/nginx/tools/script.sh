#!/bin/sh


if [ ! -f /the_certificate/server.crtf ] || [ ! -f /the_key/server.key ]; then

    mkdir /the_certificate
    mkdir /the_key

    openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
        -keyout /the_key/server.key \
        -out /the_certificate/server.crtf \
        -subj "/CN=hel-achh.42.fr"
fi


exec nginx -g "daemon off;"

