FROM debian:bookworm


# the catalog already exists just update it.
RUN apt update && apt install nginx openssl -y


COPY conf/my_config.conf /etc/nginx/conf.d/my_config.conf

COPY tools/script.sh /script.sh
RUN chmod +x /script.sh


ENTRYPOINT ["/script.sh"]

# ./script : means find in current working dir

