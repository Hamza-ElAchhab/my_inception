#!/bin/sh


# build in shell
# learn about positional parameters.
set -e
# so if any one exit with not 0 will handle it


#-x509: mandatory to use for the self-sign
# -nodes: for skip the ask enter pass

if [ ! -f /the_certificate/server.crtf ] && [ ! -f /the_key/server.key ]; then

    mkdir /the_certificate
    mkdir /the_key

    openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
        -keyout /the_key/server.key \
        -out /the_certificate/server.crtf \
        -subj "/CN=hel-achh.42.fr"
fi


#directive
exec nginx -g "daemon off;"

