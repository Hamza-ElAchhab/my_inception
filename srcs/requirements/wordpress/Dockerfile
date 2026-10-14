FROM debian:bookworm

RUN apt-get update && apt-get install -y \
        php8.2-cli \
        php8.2-fpm \
        php8.2-mysql \
        mariadb-client \
        curl \
        ca-certificates



RUN curl https://wordpress.org/latest.tar.gz --output /zipped \
    && tar -xzf /zipped\
    && rm zipped



RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /my_cli



COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh /script.sh

#tikrari -R
RUN chmod +x /script.sh && chown -R www-data:www-data /wordpress


# www-data: namev of php-fpm

# run it direct from docker without shell
#exec form
# SIGTERM
# ENTRYPOINT ["/script.sh"]


# using shell /bin/sh "/script.sh"
# shell form


ENTRYPOINT ["/script.sh"]

