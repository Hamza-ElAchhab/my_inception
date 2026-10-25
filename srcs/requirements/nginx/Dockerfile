FROM debian:bookworm

RUN apt update && apt install nginx openssl -y


COPY conf/my_config.conf /etc/nginx/conf.d/my_config.conf

COPY tools/script.sh /script.sh


RUN chmod +x /script.sh


ENTRYPOINT ["/script.sh"]

# rules of create dockerfile for resuble of layers
