FROM debian:bookworm


RUN apt update && apt install mariadb-server mariadb-client -y \
    && mkdir /run/mysqld && \
    chmod 777 /run/mysqld


COPY tools/script.sh /script.sh
RUN chmod +x /script.sh


ENTRYPOINT ["/script.sh"]



# learn about the CMD.

