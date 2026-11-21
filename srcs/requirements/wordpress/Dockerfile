# get Debian Bookworm. Installs PHP8.2-CLI, PHP-FPM, cURL, and the MySQL PHP extension. Downloads and extracts WordPress,
# downloads CLI for wordpress, copies script into cntr, and configures it as the container entrypoint.

FROM debian:bookworm


RUN apt update && apt install curl -y \
    php8.2-cli \
    php8.2-fpm  \
    php8.2-mysql \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://wordpress.org/latest.tar.gz --output /zipped \
    && tar -x -f /zipped \
    && rm /zipped

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /my_cli


COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

RUN chmod 777 -R /wordpress


ENTRYPOINT ["/script.sh"]
