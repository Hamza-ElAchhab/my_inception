# install the base img then ...

FROM debian:bookworm


RUN apt update && apt install mariadb-server -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld

COPY tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]



# /var/lib/mysql


