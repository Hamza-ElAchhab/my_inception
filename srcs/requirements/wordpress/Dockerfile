# make a description

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
#sucurity reson kernel can run any thing, else you give the permission.
RUN chmod +x /script.sh

RUN chmod 777 -R /wordpress


ENTRYPOINT ["/script.sh"]

