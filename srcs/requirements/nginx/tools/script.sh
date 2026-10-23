#!/bin/sh


#-x509: mandatory to use for the self-sign
# -nodes: for skip the ask enter pass

if [ ! -f /the_certificate/server.crtf ] || [ ! -f /the_key/server.key ]; then

    mkdir /the_certificate
    mkdir /the_key

    openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
        -keyout /the_key/server.key \
        -out /the_certificate/server.crtf \
        -subj "/CN=hel-achh.42.fr"
fi


#directive
exec nginx -g "daemon off;"




# http requests types

# fastcgi_param QUERY_STRING    $query_string;
# fastcgi_param REQUEST_METHOD  $request_method;
# fastcgi_param CONTENT_TYPE    $content_type;
# fastcgi_param CONTENT_LENGTH  $content_length;
# fastcgi_param REQUEST_URI     $request_uri;
# fastcgi_param SERVER_PROTOCOL $server_protocol;


# location ~ \.php$ {
#     fastcgi_param REQUEST_METHOD $request_method;
#     fastcgi_param REQUEST_URI $request_uri;
#     fastcgi_param QUERY_STRING $query_string;

#     fastcgi_pass wordpress:9000;
# }

