FROM debian:bookworm

RUN apt update   &&   apt install mariadb-server mariadb-client -y \
    && mkdir -p /run/mysqld \
    && mkdir -p /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql



COPY conf/mariadb_server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


COPY tools/script.sh /script.sh
RUN chmod +x /script.sh


ENTRYPOINT ["/script.sh"]
