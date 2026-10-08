FROM debian:bookworm

RUN apt update   &&   apt install mariadb-server mariadb-client -y \
    && mkdir -p /run/mysqld \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql


COPY conf/mariadb_server.cnf /etc/mariadb_server.cnf
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]
