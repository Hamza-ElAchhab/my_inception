#!/bin/bash



# there are two tpyes of create, send req of info and wait for profesnoil response, or create fast one with your own self.
# -x509 forma of sertificate and this means i want create fast certf without any middle man, without -x509 means you want to provide it
# -nodes means dont make a password for the private key, without it every time someone need the file to read should enter a password
# should private key be able to descripte the thing by public key
# without -keyout will put in : privkey.pem
# without -out will be no crtf
# -subj "/CN=hel-achh.42.fr" for skip terminal asking 7 questions.

sleep 7

if [ ! -f /the_certificate/server.crtf ] || [ ! -f /the_key/server.key ];then

    mkdir /the_certificate
    mkdir /the_key
    # krivate key extention will out any way just we put it in a file.
    # if you dont give path for cerf will print it in terminal.
    openssl req -x509 -nodes -out /the_certificate/server.crtf -keyout /the_key/server.key -subj="/CN=hel-achh.42.fr"
fi



exec nginx -g "daemon off;"

