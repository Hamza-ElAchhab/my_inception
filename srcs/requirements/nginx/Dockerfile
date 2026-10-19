FROM debian:bookworm

RUN apt update && apt install -y nginx openssl


COPY conf/my_config.conf /etc/nginx/conf.d/my_config.conf

COPY tools/script.sh /script.sh


RUN chmod +x /script.sh


ENTRYPOINT ["/script.sh"]


# echo '<h1>Hello from Nginx HTTP</h1>' > /var/www/html/index.html