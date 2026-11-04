


# the first probleme that we will solve is store tables in the database
# installed src code the wordpress, and then starting the init wordpress
# but init needs CLI for wordpress
# fpm is app server
# fpm execute code php, but if the code calls a database data, will fpm call it and execute too
# خادم الويب (Nginx) : has no idea on database or database server
# database: cant convert data to html

# when you install and run php-fpm
# make him self in backgroud + listen on fastcgi req + and make workers for every req.


# listen = localhost:9000


FROM debian:bookworm


RUN apt update && apt install curl -y \
        php8.2-cli \
        php8.2-fpm  \
        php8.2-mysql


RUN curl https://wordpress.org/latest.tar.gz --output /zipped \
    && tar -x -f /zipped \
    && rm /zipped



RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /my_cli



COPY tools/script.sh /script.sh
RUN chmod +x /script.sh



# search about if the workers need write permission
# RUN chmod 777 /wordpress


ENTRYPOINT ["/script.sh"]

