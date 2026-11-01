#!/bin/shell

# this is a Shebang
# sh script.sh -> run direct with shell
# ./script.sh in this case linux want to know with what should run it



# there are two tpyes of create, send req of info and wait for profesnoil response, or create fast one with your own self.
# -x509 forma of sertificate and this means i want create fast certf without any middle man, without -x509 means you want to provide it
# -nodes means dont make a password for the private key, without it every time someone need the file to read should enter a password
# -newkey rsa: means i dont have any path to private key you create one, rsa is asymitric algo
# -days 365 : expire
# should private key be able to descripte the thing by public key
# without -keyout will put in : privkey.pem
# without -out will be no crtf
# -subj "/CN=hel-achh.42.fr" for skip terminal asking 7 questions.



if [ ! -f /the_certificate/server.crtf ] || [ ! -f /the_key/server.key ];then

    mkdir /the_certificate
    mkdir /the_key

    openssl req -x509 -nodes -newkey rsa \
        -keyout /the_key/server.key \
        -out /the_certificate/server.crtf \
        -subj "/CN=hel-achh.42.fr"
fi


# -g == global_derictive is a modifycation on the config
exec nginx -g "daemon off;"

