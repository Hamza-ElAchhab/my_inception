

FROM debian:bookworm

RUN apt update && apt install -y \
        php8.2-cli \
        php8.2-fpm \
        mariadb-client \
        curl\
        php8.2-mysql



# latest non-support
RUN curl https://wordpress.org/latest.tar.gz --output /zipped \
    && tar -xzf /zipped\
    && rm zipped



RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /my_cli



COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh /script.sh


# && chown -R www-data:www-data /wordpress/wp-content/uploads
RUN chmod +x /script.sh && chown -R www-data:www-data /wordpress




ENTRYPOINT ["/script.sh"]

