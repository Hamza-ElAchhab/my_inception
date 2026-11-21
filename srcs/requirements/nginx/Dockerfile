# Get the base FS and install nginx + openssl, and put the config into cntr + script then start with script

FROM debian:bookworm

RUN apt update && apt install nginx openssl -y && rm -rf /var/lib/apt/lists/*

COPY conf/my_config.conf /etc/nginx/conf.d/my_config.conf

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
