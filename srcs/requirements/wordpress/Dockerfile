FROM debian:bookworm

RUN apt-get update && apt-get install -y \
        # php8.2 \
        php8.2-cli \
        php8.2-fpm \
        php8.2-mysql \
        php8.2-curl \
        mariadb-client \
        curl \
        ca-certificates \
        && mkdir -p /src_wordpress


RUN curl -fsSL https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /src_wordpress --strip-components=1 \
    && rm /tmp/wordpress.tar.gz



#PHP Archive
RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o /wp.phar \
    && chmod +x /wp.phar



COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh /script.sh


RUN chmod +x /script.sh && chown -R www-data:www-data /src_wordpress


# how
ENTRYPOINT ["/script.sh"]

