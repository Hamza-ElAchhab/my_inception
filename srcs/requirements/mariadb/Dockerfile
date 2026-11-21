# install the base img, and install the database service, and copy our script into cntr, and run it.

FROM debian:bookworm

RUN apt update && apt install mariadb-server -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld && \
    rm -rf /var/lib/apt/lists/*

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
