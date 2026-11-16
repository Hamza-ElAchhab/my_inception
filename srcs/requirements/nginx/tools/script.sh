#!/bin/bash


if [ ! -f /the_certificate/server.crtf ] || [ ! -f /the_key/server.key ];then

    mkdir /the_certificate
    mkdir /the_key
    openssl req -x509 -nodes -out /the_certificate/server.crtf -keyout /the_key/server.key -subj="/CN=hel-achh.42.fr"
fi


exec nginx -g "daemon off;"

